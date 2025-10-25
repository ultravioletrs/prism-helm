#!/bin/sh

set -e
echo "Starting cert provisioning"

REPO_URL="https://github.com/absmach/certs.git"
REPO_NAME=$(basename -s .git "$REPO_URL")
CERT_PATH="/etc/certs/prism-server.crt"
OUTPUT_DIR="/etc/certs"
BACKUP_DIR="/etc/certs/ssl_backup_$(date +%Y%m%d_%H%M%S)"

echo "Am certs host $AM_CERTS_SERVICE_HOST"
echo "Am certs port $AM_CERTS_SERVICE_PORT"

CERTS_SERVICE_HOST="${AM_CERTS_SERVICE_HOST:-prism-staging-am-certs}"
CERTS_SERVICE_PORT="${AM_CERTS_SERVICE_PORT:-9010}"

backup_certificates() {
    if [ -f "$CERT_PATH" ] || [ -f "$OUTPUT_DIR/ca.crt" ] || [ -f "$OUTPUT_DIR/prism-server.key" ]; then
        echo "Backing up existing certificates to $BACKUP_DIR..."
        mkdir -p "$BACKUP_DIR"
        [ -f "$OUTPUT_DIR/ca.crt" ] && cp "$OUTPUT_DIR/ca.crt" "$BACKUP_DIR/"
        [ -f "$OUTPUT_DIR/prism-server.crt" ] && cp "$OUTPUT_DIR/prism-server.crt" "$BACKUP_DIR/"
        [ -f "$OUTPUT_DIR/prism-server.key" ] && cp "$OUTPUT_DIR/prism-server.key" "$BACKUP_DIR/"
        echo "Backup completed!"
    fi
}

restore_certificates() {
    if [ -d "$BACKUP_DIR" ] && [ "$1" = "restore" ]; then
        echo "Restoring certificates from backup..."
        [ -f "$BACKUP_DIR/ca.crt" ] && cp "$BACKUP_DIR/ca.crt" "$OUTPUT_DIR/ca.crt"
        [ -f "$BACKUP_DIR/prism-server.crt" ] && cp "$BACKUP_DIR/prism-server.crt" "$OUTPUT_DIR/prism-server.crt"
        [ -f "$BACKUP_DIR/prism-server.key" ] && cp "$BACKUP_DIR/prism-server.key" "$OUTPUT_DIR/prism-server.key"
        echo "Certificates restored!"
        return 0
    fi
    return 1
}

check_ocsp_status() {
    echo "Checking OCSP status for $CERT_PATH"
    OCSP_OUTPUT=$(./cli certs ocsp "$CERT_PATH" 2>&1)
    if [ $? -eq 0 ]; then
        echo "OCSP Output: $OCSP_OUTPUT"
        # Check if output is valid JSON before parsing
        if echo "$OCSP_OUTPUT" | jq empty 2>/dev/null; then
            STATUS=$(echo "$OCSP_OUTPUT" | jq -r '.status')
            if [ "$STATUS" == "Valid" ]; then
                echo "Certificate is valid and does not need regeneration."
                return 0
            else
                echo "Certificate status is $STATUS. Regenerating certificates..."
                return 1
            fi
        else
            echo "OCSP output is not valid JSON: $OCSP_OUTPUT"
            return 1
        fi
    else
        echo "Failed to check OCSP status. Output: $OCSP_OUTPUT"
        return 1
    fi
}

issue_certificate() {
    echo "Running the CLI tool to issue certificates using CSR..."

    IP_ADDRESSES='["164.90.178.85","109.92.195.153"]'
    DNS_NAMES='["prism.ultraviolet.rs","backends","manager","staging.prism.ultraviolet.rs"]'

    CSR_METADATA='{"common_name":"Ultraviolet","organization":["ultraviolet"],"organizational_unit":["prism"],"dns_names":'"$DNS_NAMES"',"ip_addresses":'"$IP_ADDRESSES"'}'
    
    echo "Generating private key..."
    openssl genrsa -out temp_private_key.pem 2048
    if [ $? -ne 0 ]; then
        echo "Failed to generate private key"
        exit 1
    fi

    echo "Creating CSR..."
    CSR_OUTPUT=$(./cli certs csr "$CSR_METADATA" "temp_private_key.pem" 2>&1)
    if [ $? -ne 0 ]; then
        echo "Failed to create CSR. Output: $CSR_OUTPUT"
        rm -f temp_private_key.pem
        exit 1
    fi
    echo "CSR Output: $CSR_OUTPUT"

    echo "Issuing certificate from CSR..."
    CLI_OUTPUT=$(./cli certs issue-csr-internal "1" "8760h" "file.csr" "12we12we12we12we12we12we12we12we12we" 2>&1)
    if [ $? -eq 0 ]; then
        echo "CLI Output: $CLI_OUTPUT"
        echo "Certificate issuing process completed successfully."
        ls
        
        echo "Moving certs to output directory: $OUTPUT_DIR"
        mkdir -p "$OUTPUT_DIR"
        
        if [ -f cert.pem ]; then
            cp cert.pem "$OUTPUT_DIR/prism-server.crt"
            echo "prism-server.crt updated from cert.pem"
        else
            echo "Error: cert.pem not found after issuing certificate"
            rm -f temp_private_key.pem file.csr
            exit 1
        fi
        
        # Use the generated private key
        cp temp_private_key.pem "$OUTPUT_DIR/prism-server.key"
        echo "prism-server.key updated from temp_private_key.pem"
        
        echo "Getting CA certificate..."
        CA_OUTPUT=$(./cli certs view-ca 2>&1)
        if [ $? -eq 0 ]; then
            echo "CA Output: $CA_OUTPUT"
            # Check if output is valid JSON before parsing
            if echo "$CA_OUTPUT" | jq empty 2>/dev/null; then
                CA_CERTIFICATE=$(echo "$CA_OUTPUT" | jq -r '.certificate')
                if [ "$CA_CERTIFICATE" != "null" ]; then
                    echo "$CA_CERTIFICATE" > "$OUTPUT_DIR/ca.crt"
                    echo "CA certificate saved successfully!"
                else
                    echo "Error: CA certificate not found in response"
                    rm -f temp_private_key.pem file.csr
                    exit 1
                fi
            else
                echo "CA output is not valid JSON: $CA_OUTPUT"
                rm -f temp_private_key.pem file.csr
                exit 1
            fi
        else
            echo "Failed to get CA certificate. Output: $CA_OUTPUT"
            rm -f temp_private_key.pem file.csr
            exit 1
        fi
        
        # Clean up temporary files
        rm -f temp_private_key.pem file.csr
        echo "Certificates written to $OUTPUT_DIR"
    else
        echo "Failed to issue certificates from CSR. Output: $CLI_OUTPUT"
        rm -f temp_private_key.pem file.csr
        exit 1
    fi
}

# Handle command line arguments for backup/restore
case "$1" in
    "restore")
        if restore_certificates restore; then
            exit 0
        else
            echo "No backup found to restore from"
            exit 1
        fi
        ;;
    "backup")
        backup_certificates
        exit 0
        ;;
esac

# Backup existing certificates before proceeding
backup_certificates

# Clean old clone if it exists
if [ -d "$REPO_NAME" ]; then
    echo "Removing existing $REPO_NAME folder..."
    rm -rf "$REPO_NAME"
    if [ $? -eq 0 ]; then
        echo "Existing $REPO_NAME folder removed successfully."
    else
        echo "Failed to remove existing $REPO_NAME folder. Exiting."
        exit 1
    fi
fi

echo "Cloning the repository from $REPO_URL..."
git clone "$REPO_URL"
cd "$REPO_NAME" || { echo "Failed to navigate to the repository directory."; exit 1; }

echo "Running 'make all' to build CLI..."
make all

# wait for certs to start
sleep 5

echo "'make all' completed successfully!"
cd build || { echo "Failed to navigate to the build directory."; exit 1; }

CONFIG_FILE="config.toml"

echo "Updating config.toml with certs service endpoints..."

cat <<EOF > "$CONFIG_FILE"
raw_output = "false"
user_token = ""

[filter]
  limit = "10"
  offset = "0"

[remotes]
  certs_url = "http://${CERTS_SERVICE_HOST}:${CERTS_SERVICE_PORT}"
  host_url = "http://${CERTS_SERVICE_HOST}"
  tls_verification = false
EOF

if [ ! -f "$CERT_PATH" ]; then
    issue_certificate
else
    # Check OCSP status and regenerate certificates if needed
    if ! check_ocsp_status; then
        issue_certificate
    else
        echo "Skipping certificate regeneration."
    fi
fi