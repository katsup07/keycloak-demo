#!/usr/bin/env bash
set -euo pipefail

# Set your realm name
REALM=keycloak-demo

# Terraform directory (run this script from the repo root)
TF_DIR="infra/terraform"

# Import the realm itself
terraform -chdir="$TF_DIR" import keycloak_realm.keycloak_demo $REALM

# Import clients (replace CLIENT_UUID with actual UUIDs from get-keycloak-ids.sh)
# terraform -chdir="$TF_DIR" import keycloak_openid_client.<client_resource_name> $REALM/CLIENT_UUID

# Import roles (provider may allow role name; if UUID missing, use name)
# terraform -chdir="$TF_DIR" import keycloak_role.<role_resource_name> $REALM/<role_name_or_uuid>

# Import groups (top-level) by name
# terraform -chdir="$TF_DIR" import keycloak_group.<group_resource_name> $REALM/<group_name>

# Import client scopes (custom) by name
# terraform -chdir="$TF_DIR" import keycloak_openid_client_scope.<scope_resource_name> $REALM/<scope_name>

# Users are data and often not managed in Terraform. If you decide to, import by UUID and do NOT include credentials in code.
# terraform -chdir="$TF_DIR" import keycloak_user.<user_resource_name> $REALM/USER_UUID

echo "Edit this file with actual resource names and IDs from get-keycloak-ids.sh, then run it."
