#!/usr/bin/env bash
set -euo pipefail

# Fetch a single Keycloak realm partial export and save as JSON
# Usage:
#   ./fetch-realm-export.sh [REALM_NAME]
# Or via env vars:
#   REALM_NAME=keycloak-demo KEYCLOAK_URL=http://localhost:8080 \
#     KEYCLOAK_ADMIN=admin KEYCLOAK_ADMIN_PASSWORD=admin \
#     ./fetch-realm-export.sh

REALM=${1:-${KEYCLOAK_REALM:-keycloak-demo}}
KEYCLOAK_URL=${KEYCLOAK_URL:-http://localhost:8080}
KEYCLOAK_ADMIN=${KEYCLOAK_ADMIN:-admin}
KEYCLOAK_ADMIN_PASSWORD=${KEYCLOAK_ADMIN_PASSWORD:-admin}
OUTPUT_DIR=${OUTPUT_DIR:-$(pwd)/infra/keycloak-migration/keycloak-export}
TIMESTAMP=${TIMESTAMP:-false} # set to true to append timestamp to filename

if ! command -v curl >/dev/null 2>&1; then
  echo "ERROR: curl is required" >&2
  exit 1
fi
if ! command -v jq >/dev/null 2>&1; then
  echo "ERROR: jq is required (brew install jq)" >&2
  exit 1
fi

mkdir -p "$OUTPUT_DIR"
TS=$(date +%Y%m%d_%H%M%S)
BASENAME="${REALM}-realm"
if [ "$TIMESTAMP" = "true" ]; then
  OUT_FILE="$OUTPUT_DIR/${BASENAME}.${TS}.json"
else
  OUT_FILE="$OUTPUT_DIR/${BASENAME}.json"
fi
OUT_TMP="$OUT_FILE.tmp"

# Get admin access token from master realm
echo "Requesting admin token from $KEYCLOAK_URL (master realm)..."
ACCESS_TOKEN=$(curl -s -X POST "$KEYCLOAK_URL/realms/master/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=${KEYCLOAK_ADMIN}&password=${KEYCLOAK_ADMIN_PASSWORD}&grant_type=password&client_id=admin-cli" \
  | jq -r '.access_token')

if [ -z "$ACCESS_TOKEN" ] || [ "$ACCESS_TOKEN" = "null" ]; then
  echo "ERROR: Failed to obtain access token. Check KEYCLOAK_URL, KEYCLOAK_ADMIN and KEYCLOAK_ADMIN_PASSWORD." >&2
  exit 1
fi

echo "Fetching partial export for realm: $REALM"
# Partial export includes clients; users excluded by default here
curl -s -X POST \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  "$KEYCLOAK_URL/admin/realms/$REALM/partial-export?exportClients=true&exportUsers=false" \
  -d '{}' -o "$OUT_TMP"

if [ ! -s "$OUT_TMP" ]; then
  echo "ERROR: Export request returned empty output. The realm may not exist or the request failed." >&2
  rm -f "$OUT_TMP" || true
  exit 1
fi

# Basic validation: ensure JSON parses and has a realm field
if ! jq -e '.realm' "$OUT_TMP" >/dev/null 2>&1; then
  echo "ERROR: Export JSON does not appear valid or doesn't contain 'realm' key." >&2
  rm -f "$OUT_TMP" || true
  exit 1
fi

mv "$OUT_TMP" "$OUT_FILE"
chmod 0644 "$OUT_FILE" || true

echo "Saved export to: $OUT_FILE"

echo "Next: run the converter to produce Terraform HCL, for example:"
echo "  node infra/keycloak-migration/convert-export-official.js --input $OUT_FILE --output infra/terraform/generated-resources.tf --mappers true"
