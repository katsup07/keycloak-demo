#!/usr/bin/env bash
set -euo pipefail

# Imports existing Keycloak objects into local Terraform state.
# Pre-reqs: Keycloak running, infra/.env or TF_VAR_* present for provider auth.
# This script assumes you're running from the repo root.

TF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Using terraform dir: $TF_DIR"

cd "$TF_DIR"

echo "Initializing terraform..."
terraform init -input=false

echo "Backing up terraform.tfstate to terraform.tfstate.pre-import.bak"
cp terraform.tfstate terraform.tfstate.pre-import.bak || true

echo "Importing realm..."
# Import realm by name (resource address is keycloak_realm.keycloak_demo in this repo)
terraform import keycloak_realm.keycloak_demo keycloak-demo

echo "Importing clients..."
# Replace the right-hand UUIDs below with the output of infra/keycloak-migration/get-keycloak-ids.sh if different.
terraform import keycloak_openid_client.react_client a188eeeb-f839-4e00-8e1c-0318d2c6cd47
terraform import keycloak_openid_client.typescript_express_client eb655986-9bbe-4fee-989f-f414bce735ff
terraform import keycloak_openid_client.spring_boot_client d2d514c2-d51d-4665-a3f7-42b3517261cd

echo "Importing client default/optional scopes and audience/protocol mappers may require additional IDs; skipping automated mapper imports."

echo "Listing terraform state resources..."
terraform state list

echo "Done. Run 'terraform plan' to inspect drift and import any remaining resources (protocol mappers, roles)."
