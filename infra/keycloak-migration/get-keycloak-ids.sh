#!/usr/bin/env bash
set -euo pipefail
REALM=keycloak-demo
KEYCLOAK_URL=http://localhost:8080
KEYCLOAK_ADMIN=admin
KEYCLOAK_ADMIN_PASSWORD=admin

if ! command -v jq >/dev/null 2>&1; then
  echo "jq is required (brew install jq)" >&2
  exit 1
fi

ACCESS_TOKEN=$(curl -s -X POST "$KEYCLOAK_URL/realms/master/protocol/openid-connect/token"   -H "Content-Type: application/x-www-form-urlencoded"   -d "username=$KEYCLOAK_ADMIN&password=$KEYCLOAK_ADMIN_PASSWORD&grant_type=password&client_id=admin-cli" | jq -r '.access_token')

if [[ -z "$ACCESS_TOKEN" || "$ACCESS_TOKEN" == "null" ]]; then
  echo "Failed to obtain access token" >&2
  exit 1
fi

echo "# Keycloak Resource IDs for realm: $REALM"
echo ""
echo "# Clients:"
curl -s -X GET "$KEYCLOAK_URL/admin/realms/$REALM/clients"   -H "Authorization: Bearer $ACCESS_TOKEN" | jq -r '.[] | (.clientId + " -> " + .id)'

echo ""
echo "# Roles:"
curl -s -X GET "$KEYCLOAK_URL/admin/realms/$REALM/roles"   -H "Authorization: Bearer $ACCESS_TOKEN" | jq -r '.[] | (.name + " -> " + (.id // "(no-uuid-use-name)"))'

echo ""
echo "# Users:"
curl -s -X GET "$KEYCLOAK_URL/admin/realms/$REALM/users"   -H "Authorization: Bearer $ACCESS_TOKEN" | jq -r '.[] | (.username + " -> " + .id)'
