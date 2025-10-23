#!/bin/bash
# Copyright (c) Abstract Machines
# SPDX-License-Identifier: Apache-2.0
#
# Manual OpenBao Setup Script
# This script can be run locally after port-forwarding the OpenBao service
# Usage: ./manual-openbao-setup.sh

set -euo pipefail

scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$scriptdir"

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration defaults
OPENBAO_DATA_PATH="${OPENBAO_DATA_PATH:-./openbao-data}"
OPENBAO_BASE_URL="${AM_CERTS_OPENBAO_HOST:-http://127.0.0.1:8200}"
OPENBAO_ROOT_CA_TTL="${OPENBAO_ROOT_CA_TTL:-87600h}"
OPENBAO_INTERMEDIATE_CA_TTL="${OPENBAO_INTERMEDIATE_CA_TTL:-87600h}"
OPENBAO_MAX_LEASE_TTL="${OPENBAO_MAX_LEASE_TTL:-720h}"
OPENBAO_TOKEN_TTL="${OPENBAO_TOKEN_TTL:-1h}"
OPENBAO_TOKEN_MAX_TTL="${OPENBAO_TOKEN_MAX_TTL:-4h}"
OPENBAO_SERVICE_TOKEN_TTL="${OPENBAO_SERVICE_TOKEN_TTL:-24h}"

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_prerequisites() {
    log_info "Checking prerequisites..."
    
    # Check for required tools
    local missing_tools=()
    
    if ! command -v bao &> /dev/null; then
        missing_tools+=("bao")
    fi
    
    if ! command -v jq &> /dev/null; then
        missing_tools+=("jq")
    fi
    
    if [ ${#missing_tools[@]} -ne 0 ]; then
        log_error "Missing required tools: ${missing_tools[*]}"
        log_info "Please install the missing tools and try again."
        log_info "OpenBao CLI: https://github.com/openbao/openbao/releases"
        log_info "jq: On macOS: brew install jq, On Ubuntu/Debian: sudo apt-get install jq"
        exit 1
    fi
    
    log_success "All prerequisites satisfied"
}

readDotEnv() {
    set -o allexport
    if [ -f "$scriptdir/.env" ]; then
        source "$scriptdir/.env"
        log_info "Loaded environment variables from .env file"
    else
        log_warning ".env file not found. Will use defaults and prompt for missing values."
    fi
    set +o allexport
}

update_env_var() {
    local key="$1"
    local value="$2"
    local env_file="$scriptdir/.env"

    if [ -f "$env_file" ]; then
        # Check if key exists in file
        if grep -q "^${key}=" "$env_file"; then
            # Update existing key
            sed -i.bak "s|^${key}=.*|${key}=${value}|" "$env_file"
            rm -f "${env_file}.bak"
        else
            # Add new key to file
            echo "${key}=${value}" >> "$env_file"
        fi
    else
        # Create new file with key
        echo "${key}=${value}" > "$env_file"
    fi
}

write_env() {
    if [ -e "$OPENBAO_DATA_PATH/init.json" ]; then
        log_info "Updating .env file with new keys from init.json..."
        
        # Extract values from JSON
        local UNSEAL_KEY_1 UNSEAL_KEY_2 UNSEAL_KEY_3 ROOT_TOKEN
        UNSEAL_KEY_1=$(jq -r '.unseal_keys_b64[0] // .unseal_keys_hex[0] // .keys_base64[0] // .keys[0] // empty' "$OPENBAO_DATA_PATH/init.json")
        UNSEAL_KEY_2=$(jq -r '.unseal_keys_b64[1] // .unseal_keys_hex[1] // .keys_base64[1] // .keys[1] // empty' "$OPENBAO_DATA_PATH/init.json")
        UNSEAL_KEY_3=$(jq -r '.unseal_keys_b64[2] // .unseal_keys_hex[2] // .keys_base64[2] // .keys[2] // empty' "$OPENBAO_DATA_PATH/init.json")
        ROOT_TOKEN=$(jq -r '.root_token // .initial_root_token // empty' "$OPENBAO_DATA_PATH/init.json")
        
        # Update or add keys to .env file without overwriting the entire file
        update_env_var "AM_CERTS_OPENBAO_HOST" "$OPENBAO_BASE_URL"
        update_env_var "AM_CERTS_OPENBAO_UNSEAL_KEY_1" "$UNSEAL_KEY_1"
        update_env_var "AM_CERTS_OPENBAO_UNSEAL_KEY_2" "$UNSEAL_KEY_2"
        update_env_var "AM_CERTS_OPENBAO_UNSEAL_KEY_3" "$UNSEAL_KEY_3"
        update_env_var "AM_CERTS_OPENBAO_ROOT_TOKEN" "$ROOT_TOKEN"
        
        log_success "Environment variables updated in .env file"
    else
        log_error "Source file '$OPENBAO_DATA_PATH/init.json' not found for writing to .env."
        exit 1
    fi
}

# Main execution starts here
print_banner() {
    echo "================================"
    echo "OpenBao Manual Setup Script"
    echo "================================"
    echo "OpenBao Address: $OPENBAO_BASE_URL"
    echo "Data Path: $OPENBAO_DATA_PATH"
    echo "================================"
}

initialize_openbao() {
    log_info "Checking OpenBao initialization status..."
    
    local INIT_STATUS=0
    bao operator init -status -address="$OPENBAO_BASE_URL" || INIT_STATUS=$?
    
    if [ "$INIT_STATUS" -eq 2 ]; then
        log_info "OpenBao is not initialized. Initializing now..."
        bao operator init -address="$OPENBAO_BASE_URL" -key-shares=5 -key-threshold=3 -format=json > "$OPENBAO_DATA_PATH/init.json"
        
        write_env
        readDotEnv
        
        log_success "OpenBao initialization complete. Secrets stored in $OPENBAO_DATA_PATH/init.json"
    elif [ "$INIT_STATUS" -eq 0 ]; then
        log_info "OpenBao is already initialized. Using existing keys from .env file."
    else
        log_error "An error occurred while checking OpenBao initialization status. Exit status: $INIT_STATUS"
        exit 1
    fi
}

unseal_openbao() {
    log_info "Checking if OpenBao needs to be unsealed..."
    
    # Check for required environment variables
    if [ -z "${AM_CERTS_OPENBAO_UNSEAL_KEY_1:-}" ]; then
        log_error "AM_CERTS_OPENBAO_UNSEAL_KEY_1 is empty. Please check your .env file."
        exit 1
    fi
    
    log_info "Unsealing OpenBao..."
    bao operator unseal -address="$OPENBAO_BASE_URL" "${AM_CERTS_OPENBAO_UNSEAL_KEY_1}"
    bao operator unseal -address="$OPENBAO_BASE_URL" "${AM_CERTS_OPENBAO_UNSEAL_KEY_2}"
    bao operator unseal -address="$OPENBAO_BASE_URL" "${AM_CERTS_OPENBAO_UNSEAL_KEY_3}"
    
    log_success "Unseal complete"
}

login_openbao() {
    log_info "Logging in with root token..."
    bao login -address="$OPENBAO_BASE_URL" "$AM_CERTS_OPENBAO_ROOT_TOKEN"
    log_success "Login successful"
}

create_namespace() {
    if [ -n "${AM_CERTS_OPENBAO_NAMESPACE:-}" ]; then
        log_info "Creating OpenBao namespace: ${AM_CERTS_OPENBAO_NAMESPACE}"
        if ! bao namespace create -address="$OPENBAO_BASE_URL" "${AM_CERTS_OPENBAO_NAMESPACE}" 2>/tmp/ns_error; then
            if grep -q "namespace already exists" /tmp/ns_error; then
                log_warning "Namespace already exists: ${AM_CERTS_OPENBAO_NAMESPACE}"
            else
                log_error "Failed to create namespace ${AM_CERTS_OPENBAO_NAMESPACE}:"
                cat /tmp/ns_error >&2
                exit 1
            fi
        else
            log_success "Created namespace: ${AM_CERTS_OPENBAO_NAMESPACE}"
        fi
        rm -f /tmp/ns_error
        export BAO_NAMESPACE="${AM_CERTS_OPENBAO_NAMESPACE}"
        echo "${AM_CERTS_OPENBAO_NAMESPACE}" > "$OPENBAO_DATA_PATH/namespace"
    fi
}

configure_pki_and_approle() {
  if [ -f "$OPENBAO_DATA_PATH/configured" ]; then
    log_info "OpenBao already configured, skipping PKI and AppRole setup..."
    return 0
  fi

  log_info "Configuring OpenBao PKI and AppRole..."

  # Enable authentication methods and secrets engines
  if ! bao auth enable -address="$OPENBAO_BASE_URL" approle > /tmp/auth_success 2>/tmp/auth_error; then
    if ! grep -q "already in use" /tmp/auth_error; then
      log_error "Failed to enable AppRole auth method:"
      cat /tmp/auth_error >&2
      exit 1
    fi
    log_info "AppRole already enabled"
  fi
  rm -f /tmp/auth_error /tmp/auth_success

  # Enable PKI secrets engine
  if ! bao secrets enable -address="$OPENBAO_BASE_URL" -path=pki pki > /tmp/pki_success 2>/tmp/pki_error; then
    # If the failure wasn't because the mount already exists, abort
    if ! grep -q "already in use" /tmp/pki_error; then
      log_error "Failed to enable PKI secrets engine:"
      cat /tmp/pki_error >&2
      exit 1
    fi
    log_info "PKI already enabled"
  fi
  rm -f /tmp/pki_error /tmp/pki_success

  # Configure PKI engine
  bao secrets tune -address="$OPENBAO_BASE_URL" -max-lease-ttl="$OPENBAO_ROOT_CA_TTL" pki > /dev/null

  # Set default PKI values if not provided (match staging-values.yaml)
  AM_CERTS_OPENBAO_PKI_CA_CN="${AM_CERTS_OPENBAO_PKI_CA_CN:-Abstract Machines Certificate Authority}"
  AM_CERTS_OPENBAO_PKI_CA_OU="${AM_CERTS_OPENBAO_PKI_CA_OU:-Abstract Machines}"
  AM_CERTS_OPENBAO_PKI_CA_O="${AM_CERTS_OPENBAO_PKI_CA_O:-AbstractMachines}"
  AM_CERTS_OPENBAO_PKI_CA_C="${AM_CERTS_OPENBAO_PKI_CA_C:-FRANCE}"
  AM_CERTS_OPENBAO_PKI_CA_L="${AM_CERTS_OPENBAO_PKI_CA_L:-PARIS}"
  AM_CERTS_OPENBAO_PKI_CA_ST="${AM_CERTS_OPENBAO_PKI_CA_ST:-PARIS}"
  AM_CERTS_OPENBAO_PKI_CA_ADDR="${AM_CERTS_OPENBAO_PKI_CA_ADDR:-5 Av. Anatole}"
  AM_CERTS_OPENBAO_PKI_CA_PO="${AM_CERTS_OPENBAO_PKI_CA_PO:-75007}"
  AM_CERTS_OPENBAO_PKI_CA_DNS_NAMES="${AM_CERTS_OPENBAO_PKI_CA_DNS_NAMES:-localhost}"
  AM_CERTS_OPENBAO_PKI_CA_IP_ADDRESSES="${AM_CERTS_OPENBAO_PKI_CA_IP_ADDRESSES:-127.0.0.1,::1}"
  AM_CERTS_OPENBAO_PKI_CA_EMAIL_ADDRESSES="${AM_CERTS_OPENBAO_PKI_CA_EMAIL_ADDRESSES:-info@abstractmachines.rs}"
  AM_CERTS_OPENBAO_PKI_ROLE="${AM_CERTS_OPENBAO_PKI_ROLE:-absmach}"
  AM_CERTS_OPENBAO_APP_ROLE="${AM_CERTS_OPENBAO_APP_ROLE:-absmach}"
  AM_CERTS_OPENBAO_APP_SECRET="${AM_CERTS_OPENBAO_APP_SECRET:-absmach}"

  PKI_CMD="bao write -address=\"$OPENBAO_BASE_URL\" -field=certificate pki/root/generate/internal"
  PKI_CMD="$PKI_CMD common_name=\"$AM_CERTS_OPENBAO_PKI_CA_CN\""
  PKI_CMD="$PKI_CMD organization=\"$AM_CERTS_OPENBAO_PKI_CA_O\""
  PKI_CMD="$PKI_CMD country=\"$AM_CERTS_OPENBAO_PKI_CA_C\""
  PKI_CMD="$PKI_CMD ttl=\"$OPENBAO_ROOT_CA_TTL\""
  PKI_CMD="$PKI_CMD key_bits=2048"
  PKI_CMD="$PKI_CMD exclude_cn_from_sans=false"

  [ -n "${AM_CERTS_OPENBAO_PKI_CA_OU:-}" ] && PKI_CMD="$PKI_CMD ou=\"$AM_CERTS_OPENBAO_PKI_CA_OU\""
  [ -n "${AM_CERTS_OPENBAO_PKI_CA_L:-}" ] && PKI_CMD="$PKI_CMD locality=\"$AM_CERTS_OPENBAO_PKI_CA_L\""
  [ -n "${AM_CERTS_OPENBAO_PKI_CA_ST:-}" ] && PKI_CMD="$PKI_CMD province=\"$AM_CERTS_OPENBAO_PKI_CA_ST\""
  [ -n "${AM_CERTS_OPENBAO_PKI_CA_ADDR:-}" ] && PKI_CMD="$PKI_CMD street_address=\"$AM_CERTS_OPENBAO_PKI_CA_ADDR\""
  [ -n "${AM_CERTS_OPENBAO_PKI_CA_PO:-}" ] && PKI_CMD="$PKI_CMD postal_code=\"$AM_CERTS_OPENBAO_PKI_CA_PO\""
  
  [ -n "${AM_CERTS_OPENBAO_PKI_CA_DNS_NAMES:-}" ] && PKI_CMD="$PKI_CMD alt_names=\"$AM_CERTS_OPENBAO_PKI_CA_DNS_NAMES\""
  [ -n "${AM_CERTS_OPENBAO_PKI_CA_IP_ADDRESSES:-}" ] && PKI_CMD="$PKI_CMD ip_sans=\"$AM_CERTS_OPENBAO_PKI_CA_IP_ADDRESSES\""
  [ -n "${AM_CERTS_OPENBAO_PKI_CA_URI_SANS:-}" ] && PKI_CMD="$PKI_CMD uri_sans=\"$AM_CERTS_OPENBAO_PKI_CA_URI_SANS\""
  [ -n "${AM_CERTS_OPENBAO_PKI_CA_EMAIL_ADDRESSES:-}" ] && PKI_CMD="$PKI_CMD email_sans=\"$AM_CERTS_OPENBAO_PKI_CA_EMAIL_ADDRESSES\""

  eval $PKI_CMD > /dev/null

  if [ $? -eq 0 ]; then
    log_success "OpenBao root CA certificate generated successfully!"
  else
    log_error "Failed to generate OpenBao root CA certificate"
    exit 1
  fi

  if ! bao secrets enable -address="$OPENBAO_BASE_URL" -path=pki_int pki > /tmp/pki_int_success 2>/tmp/pki_int_error; then
    if ! grep -q "already in use" /tmp/pki_int_error; then
      log_error "Failed to enable intermediate PKI secrets engine:"
      cat /tmp/pki_int_error >&2
      exit 1
    fi
    log_info "Intermediate PKI already enabled"
  fi
  rm -f /tmp/pki_int_error /tmp/pki_int_success

  bao secrets tune -address="$OPENBAO_BASE_URL" -max-lease-ttl="$OPENBAO_INTERMEDIATE_CA_TTL" pki_int > /dev/null

  INTERMEDIATE_CN="${AM_CERTS_OPENBAO_PKI_CA_CN} Intermediate"
  INTERMEDIATE_CSR_CMD="bao write -address=\"$OPENBAO_BASE_URL\" -field=csr pki_int/intermediate/generate/internal"
  INTERMEDIATE_CSR_CMD="$INTERMEDIATE_CSR_CMD common_name=\"$INTERMEDIATE_CN\""
  INTERMEDIATE_CSR_CMD="$INTERMEDIATE_CSR_CMD organization=\"$AM_CERTS_OPENBAO_PKI_CA_O\""
  INTERMEDIATE_CSR_CMD="$INTERMEDIATE_CSR_CMD country=\"$AM_CERTS_OPENBAO_PKI_CA_C\""
  INTERMEDIATE_CSR_CMD="$INTERMEDIATE_CSR_CMD ttl=\"$OPENBAO_INTERMEDIATE_CA_TTL\""
  INTERMEDIATE_CSR_CMD="$INTERMEDIATE_CSR_CMD key_bits=2048"

  [ -n "${AM_CERTS_OPENBAO_PKI_CA_OU:-}" ] && INTERMEDIATE_CSR_CMD="$INTERMEDIATE_CSR_CMD ou=\"$AM_CERTS_OPENBAO_PKI_CA_OU\""
  [ -n "${AM_CERTS_OPENBAO_PKI_CA_L:-}" ] && INTERMEDIATE_CSR_CMD="$INTERMEDIATE_CSR_CMD locality=\"$AM_CERTS_OPENBAO_PKI_CA_L\""
  [ -n "${AM_CERTS_OPENBAO_PKI_CA_ST:-}" ] && INTERMEDIATE_CSR_CMD="$INTERMEDIATE_CSR_CMD province=\"$AM_CERTS_OPENBAO_PKI_CA_ST\""
  [ -n "${AM_CERTS_OPENBAO_PKI_CA_ADDR:-}" ] && INTERMEDIATE_CSR_CMD="$INTERMEDIATE_CSR_CMD street_address=\"$AM_CERTS_OPENBAO_PKI_CA_ADDR\""
  [ -n "${AM_CERTS_OPENBAO_PKI_CA_PO:-}" ] && INTERMEDIATE_CSR_CMD="$INTERMEDIATE_CSR_CMD postal_code=\"$AM_CERTS_OPENBAO_PKI_CA_PO\""
  
  [ -n "${AM_CERTS_OPENBAO_PKI_CA_DNS_NAMES:-}" ] && INTERMEDIATE_CSR_CMD="$INTERMEDIATE_CSR_CMD alt_names=\"$AM_CERTS_OPENBAO_PKI_CA_DNS_NAMES\""
  [ -n "${AM_CERTS_OPENBAO_PKI_CA_IP_ADDRESSES:-}" ] && INTERMEDIATE_CSR_CMD="$INTERMEDIATE_CSR_CMD ip_sans=\"$AM_CERTS_OPENBAO_PKI_CA_IP_ADDRESSES\""
  [ -n "${AM_CERTS_OPENBAO_PKI_CA_URI_SANS:-}" ] && INTERMEDIATE_CSR_CMD="$INTERMEDIATE_CSR_CMD uri_sans=\"$AM_CERTS_OPENBAO_PKI_CA_URI_SANS\""
  [ -n "${AM_CERTS_OPENBAO_PKI_CA_EMAIL_ADDRESSES:-}" ] && INTERMEDIATE_CSR_CMD="$INTERMEDIATE_CSR_CMD email_sans=\"$AM_CERTS_OPENBAO_PKI_CA_EMAIL_ADDRESSES\""

  INTERMEDIATE_CSR=$(eval $INTERMEDIATE_CSR_CMD)

  if [ $? -ne 0 ] || [ -z "$INTERMEDIATE_CSR" ]; then
    log_error "Failed to generate intermediate CA CSR"
    exit 1
  fi

  log_success "Intermediate CA CSR generated successfully!"

  INTERMEDIATE_CERT=$(bao write -address="$OPENBAO_BASE_URL" -field=certificate pki/root/sign-intermediate csr="$INTERMEDIATE_CSR" format=pem_bundle ttl="$OPENBAO_INTERMEDIATE_CA_TTL" use_csr_values=true)

  if [ $? -ne 0 ] || [ -z "$INTERMEDIATE_CERT" ]; then
    log_error "Failed to sign intermediate CA certificate"
    exit 1
  fi

  log_success "Intermediate CA certificate signed successfully!"

  bao write -address="$OPENBAO_BASE_URL" pki_int/intermediate/set-signed certificate="$INTERMEDIATE_CERT" > /dev/null

  if [ $? -eq 0 ]; then
    log_success "Intermediate CA setup completed successfully!"
  else
    log_error "Failed to set signed intermediate certificate"
    exit 1
  fi

  echo "$INTERMEDIATE_CERT" > "$OPENBAO_DATA_PATH/intermediate_ca.pem"

  bao write -address="$OPENBAO_BASE_URL" pki/config/urls issuing_certificates="$OPENBAO_BASE_URL/v1/pki/ca" crl_distribution_points="$OPENBAO_BASE_URL/v1/pki/crl" ocsp_servers="$OPENBAO_BASE_URL/v1/pki/ocsp" > /dev/null

  bao write -address="$OPENBAO_BASE_URL" pki_int/config/urls issuing_certificates="$OPENBAO_BASE_URL/v1/pki_int/ca" crl_distribution_points="$OPENBAO_BASE_URL/v1/pki_int/crl" ocsp_servers="$OPENBAO_BASE_URL/v1/pki_int/ocsp" > /dev/null

  ROLE_CMD="bao write -address=\"$OPENBAO_BASE_URL\" pki_int/roles/${AM_CERTS_OPENBAO_PKI_ROLE}"
  ROLE_CMD="$ROLE_CMD allow_any_name=true"
  ROLE_CMD="$ROLE_CMD enforce_hostnames=false"
  ROLE_CMD="$ROLE_CMD allow_ip_sans=true"
  ROLE_CMD="$ROLE_CMD allow_localhost=true"
  ROLE_CMD="$ROLE_CMD allow_bare_domains=true"
  ROLE_CMD="$ROLE_CMD allow_subdomains=true"
  ROLE_CMD="$ROLE_CMD allow_glob_domains=true"
  ROLE_CMD="$ROLE_CMD allowed_domains=\"*\""
  ROLE_CMD="$ROLE_CMD allowed_uri_sans=\"*\""
  ROLE_CMD="$ROLE_CMD allowed_other_sans=\"*\""
  ROLE_CMD="$ROLE_CMD server_flag=true"
  ROLE_CMD="$ROLE_CMD client_flag=true"
  ROLE_CMD="$ROLE_CMD code_signing_flag=false"
  ROLE_CMD="$ROLE_CMD email_protection_flag=false"
  ROLE_CMD="$ROLE_CMD key_type=rsa"
  ROLE_CMD="$ROLE_CMD key_bits=2048"
  ROLE_CMD="$ROLE_CMD key_usage=\"DigitalSignature,KeyEncipherment,KeyAgreement\""
  ROLE_CMD="$ROLE_CMD ext_key_usage=\"ServerAuth,ClientAuth,OCSPSigning\""
  ROLE_CMD="$ROLE_CMD use_csr_common_name=true"
  ROLE_CMD="$ROLE_CMD use_csr_sans=true"
  ROLE_CMD="$ROLE_CMD copy_extensions=true"
  ROLE_CMD="$ROLE_CMD allowed_extensions=\"*\""
  ROLE_CMD="$ROLE_CMD basic_constraints_valid_for_non_ca=true"
  ROLE_CMD="$ROLE_CMD max_ttl=\"$OPENBAO_MAX_LEASE_TTL\""
  ROLE_CMD="$ROLE_CMD ttl=\"$OPENBAO_MAX_LEASE_TTL\""

  eval "$ROLE_CMD" > /dev/null

  # Create PKI policy
  cat > "$OPENBAO_DATA_PATH/pki-policy.hcl" << EOF
path "pki_int/issue/${AM_CERTS_OPENBAO_PKI_ROLE}" {
  capabilities = ["create", "update"]
}
path "pki_int/sign/${AM_CERTS_OPENBAO_PKI_ROLE}" {
  capabilities = ["create", "update"]
}
path "pki_int/sign-verbatim/${AM_CERTS_OPENBAO_PKI_ROLE}" {
  capabilities = ["create", "update"]
}
path "pki_int/certs" {
  capabilities = ["list"]
}
path "pki_int/cert/*" {
  capabilities = ["read"]
}
path "pki_int/revoke" {
  capabilities = ["create", "update"]
}
path "pki_int/ca" {
  capabilities = ["read"]
}
path "pki_int/ca_chain" {
  capabilities = ["read"]
}
path "pki_int/crl" {
  capabilities = ["read"]
}
path "pki/ca" {
  capabilities = ["read"]
}
path "pki/ca_chain" {
  capabilities = ["read"]
}
path "pki/crl" {
  capabilities = ["read"]
}
# Token management
path "auth/token/renew-self" {
  capabilities = ["update"]
}
path "auth/token/lookup-self" {
  capabilities = ["read"]
}
# System lease renewal
path "sys/renew/*" {
  capabilities = ["update"]
}
EOF

  bao policy write -address="$OPENBAO_BASE_URL" pki-policy "$OPENBAO_DATA_PATH/pki-policy.hcl" > /dev/null

  # Create AppRole
  SECRET_ID_TTL="${AM_CERTS_OPENBAO_SECRET_ID_TTL:-87600h}"
  bao write -address="$OPENBAO_BASE_URL" auth/approle/role/"${AM_CERTS_OPENBAO_PKI_ROLE}" token_policies=pki-policy token_ttl="$OPENBAO_TOKEN_TTL" token_max_ttl="$OPENBAO_TOKEN_MAX_TTL" bind_secret_id=true secret_id_ttl="$SECRET_ID_TTL" > /dev/null

  # Set custom role ID if provided
  if [ -n "${AM_CERTS_OPENBAO_APP_ROLE:-}" ]; then
    bao write -address="$OPENBAO_BASE_URL" auth/approle/role/"${AM_CERTS_OPENBAO_PKI_ROLE}"/role-id role_id="$AM_CERTS_OPENBAO_APP_ROLE" > /dev/null
  fi

  # Set custom secret ID if provided
  if [ -n "${AM_CERTS_OPENBAO_APP_SECRET:-}" ]; then
    bao write -address="$OPENBAO_BASE_URL" auth/approle/role/"${AM_CERTS_OPENBAO_PKI_ROLE}"/custom-secret-id secret_id="$AM_CERTS_OPENBAO_APP_SECRET" > /dev/null
  fi

  # Generate service token for additional access
  SERVICE_TOKEN=$(bao write -address="$OPENBAO_BASE_URL" -field=token auth/token/create policies=pki-policy ttl="$OPENBAO_SERVICE_TOKEN_TTL" renewable=true display_name="certs-service" 2>/dev/null)

  echo "SERVICE_TOKEN=$SERVICE_TOKEN" > "$OPENBAO_DATA_PATH/service_token"
  
  # Mark configuration as complete
  touch "$OPENBAO_DATA_PATH/configured"
  log_success "OpenBao PKI and AppRole configuration completed successfully!"
}

verify_existing_setup() {
  # Restore namespace if it exists
  if [ -f "$OPENBAO_DATA_PATH/namespace" ] && [ -n "${AM_CERTS_OPENBAO_NAMESPACE:-}" ]; then
    SAVED_NAMESPACE=$(cat "$OPENBAO_DATA_PATH/namespace")
    if [ "$SAVED_NAMESPACE" = "$AM_CERTS_OPENBAO_NAMESPACE" ]; then
      export BAO_NAMESPACE="$AM_CERTS_OPENBAO_NAMESPACE"
    fi
  fi
  
  if [ -n "${AM_CERTS_OPENBAO_APP_SECRET:-}" ]; then
    log_info "Verifying existing secret ID validity..."
    if ! bao write -address="$OPENBAO_BASE_URL" -field=client_token auth/approle/login role_id="${AM_CERTS_OPENBAO_APP_ROLE:-}" secret_id="$AM_CERTS_OPENBAO_APP_SECRET" > /dev/null 2>&1; then
      log_warning "Secret ID has expired!"
      log_warning "Please regenerate AM_CERTS_OPENBAO_APP_SECRET and update your environment configuration"
    else
      log_success "Existing secret ID is valid"
    fi
  fi
}

# Create required directories
mkdir -p "$OPENBAO_DATA_PATH" ./openbao-logs

# Execute main workflow
print_banner
check_prerequisites
readDotEnv
initialize_openbao
unseal_openbao
login_openbao
create_namespace
configure_pki_and_approle
verify_existing_setup

echo "================================"
echo "OpenBao Manual Setup Complete"
echo "================================"
echo "OpenBao Address: $OPENBAO_BASE_URL"
echo "UI Available at: $OPENBAO_BASE_URL/ui"
echo "================================"
echo "IMPORTANT: Store the init.json file securely!"
echo "It contains unseal keys and root token!"
echo "================================"

echo "OpenBao is ready for certs service!"

# Clean up temporary files
rm -f /tmp/ns_error /tmp/auth_error /tmp/auth_success /tmp/pki_error /tmp/pki_success /tmp/pki_int_error /tmp/pki_int_success