#!/bin/sh

set -e
echo "Starting cert provisioning"

REPO_URL="https://github.com/absmach/certs.git"
REPO_NAME=$(basename -s .git "$REPO_URL")
CERT_PATH="/etc/certs/prism-server.crt"
OUTPUT_DIR="/etc/certs"

echo "Am certs host $AM_CERTS_SERVICE_HOST"
echo "Am certs port $AM_CERTS_SERVICE_PORT"

CERTS_SERVICE_HOST="${AM_CERTS_SERVICE_HOST:-am-certs}"
CERTS_SERVICE_PORT="${AM_ERTS_SERVICE_PORT:-9010}"

check_ocsp_status() {
    echo "Checking OCSP status for $CERT_PATH"
    OCSP_OUTPUT=$(./cli certs ocsp "$CERT_PATH" 2>&1)

    if [ $? -eq 0 ]; then
        STATUS=$(echo "$OCSP_OUTPUT" | jq -r '.status')
        if [ "$STATUS" == "Valid" ]; then
            echo "Certificate is valid and does not need regeneration."
            return 0
        else
            echo "Certificate status is $STATUS. Regenerating certificates..."
            return 1
        fi
    else
        echo "Failed to check OCSP status. Output: $OCSP_OUTPUT"
        echo "Assuming certificates need regeneration."
        return 1
    fi
}

issue_certificate() {
    echo "Running the CLI tool to issue certificates..."
    CLI_OUTPUT=$(./cli certs issue "1" "Ultraviolet" '["192.168.100.4","164.90.178.85", "109.92.195.153", "192.168.1.8", "188.166.202.241"]' '{"organization":["ultraviolet"], "OrganizationalUnit":["prism"]}')

    if [ $? -eq 0 ]; then
        echo "Certificates issued successfully!"

        SERIAL_NUMBER=$(echo "$CLI_OUTPUT" | jq -r '.serial_number')
        echo "Serial Number: $SERIAL_NUMBER"

        echo "Fetching access token..."
        TOKEN=$(./cli certs token "$SERIAL_NUMBER" | jq -r '.token')
        CA_TOKEN=$(./cli certs token-ca | jq -r '.token')

        echo "Downloading certificates..."
        ./cli certs download "$SERIAL_NUMBER" "$TOKEN"
        ./cli certs download-ca "$CA_TOKEN"

        echo "Moving certs to output directory: $OUTPUT_DIR"
        mkdir -p "$OUTPUT_DIR"
        mv cert.pem "$OUTPUT_DIR/prism-server.crt"
        mv key.pem "$OUTPUT_DIR/prism-server.key"
        mv ca.pem "$OUTPUT_DIR/ca.crt"
        mv ca.key "$OUTPUT_DIR/ca.key"

        echo "Certificates written to $OUTPUT_DIR"
    else
        echo "Failed to issue certificates."
        exit 1
    fi
}

# Clean old clone if it exists
if [ -d "$REPO_NAME" ]; then
    echo "Removing existing $REPO_NAME folder..."
    rm -rf "$REPO_NAME"
fi

echo "Cloning the repository from $REPO_URL..."
git clone "$REPO_URL"
cd "$REPO_NAME" || { echo "Failed to navigate to the repository directory."; exit 1; }

echo "Running 'make all' to build CLI..."
make all

sleep 5  # Wait for certs service to start if needed

cd build || { echo "Failed to navigate to build directory."; exit 1; }

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
    echo "No existing cert found at $CERT_PATH. Issuing new certificate..."
    issue_certificate
else
    if ! check_ocsp_status; then
        issue_certificate
    else
        echo "Existing certificate is valid. No action needed."
    fi
fi
