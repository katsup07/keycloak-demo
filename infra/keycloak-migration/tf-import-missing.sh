#!/usr/bin/env bash
set -euo pipefail
echo "tf-import-missing.sh has been removed. Use 'terraform import' directly for adopting existing resources." >&2
exit 1

echo "This script is no longer available. Please refer to the documentation for more information."
#!/usr/bin/env bash
set -euo pipefail

# Imports only resources missing from Terraform state, with confirmation prompts.
# Supports: realm, clients, client_default_scopes, client_optional_scopes.
# Run from repo root.

TF_DIR="infra/terraform"
GEN_FILE="$TF_DIR/generated-resources.tf"
IDS_SCRIPT="infra/keycloak-migration/get-keycloak-ids.sh"

if [ ! -f "$GEN_FILE" ]; then
  echo "ERROR: $GEN_FILE not found." >&2
  exit 1
fi

if ! command -v terraform >/dev/null 2>&1; then
  echo "ERROR: terraform not found in PATH" >&2
  exit 1
fi

# Grab realm name from generated file (first realm block)
REALM=$(awk '/resource "keycloak_realm"/{in=1} in&&/realm *=/{match($0,/"[^"]+"/,a); if(a[0]!=""){gsub(/"/,"",a[0]); print a[0]; exit}}' "$GEN_FILE")
REALM=${REALM:-keycloak-demo}

echo "Realm detected: $REALM"

# Build current state list
STATE_LIST=$(terraform -chdir="$TF_DIR" state list 2>/dev/null || true)

have_state() {
  # $1 = address
  grep -qx "$1" <<<"$STATE_LIST"
}

# Fetch clientId -> UUID map via Admin API
echo "Fetching client UUIDs via $IDS_SCRIPT ..."
IDS_OUTPUT=$("$IDS_SCRIPT")
declare -A CLIENT_UUID
while IFS= read -r line; do
  if [[ "$line" =~ ^([^[:space:]]+)\ \-\>\ ([a-f0-9-]+)$ ]]; then
    cid="${BASH_REMATCH[1]}"; uuid="${BASH_REMATCH[2]}"
    CLIENT_UUID["$cid"]="$uuid"
  fi
done < <(echo "$IDS_OUTPUT" | awk '/^# Clients:/ {flag=1; next} /^$/ && flag==1 {flag=0} flag==1 {print}')

# 1) Realm
REALM_ADDR=$(awk '/resource "keycloak_realm" "[^"]+"/ {match($0,/resource "keycloak_realm" "([^"]+)"/,m); if(m[1]!=""){print "keycloak_realm." m[1]; exit}}' "$GEN_FILE")
if [ -n "$REALM_ADDR" ] && ! have_state "$REALM_ADDR"; then
  read -r -p "Import $REALM_ADDR with ID '$REALM'? [y/N] " ans
  if [[ "$ans" =~ ^[Yy]$ ]]; then
    terraform -chdir="$TF_DIR" import "$REALM_ADDR" "$REALM"
  fi
fi

# Helper: parse client terraform name -> client_id
declare -A TFCLIENT_TO_ID
awk '
  /resource "keycloak_openid_client" "[^"]+"/ {if(name!=""&&cid==""){name=""; cid=""} match($0,/resource "keycloak_openid_client" "([^"]+)"/,m); name=m[1]; in=1; next}
  in && /client_id *=/ {match($0,/"[^"]+"/,a); cid=a[0]; gsub(/"/,"",cid); print name "\t" cid; name=""; cid=""; in=0}
' "$GEN_FILE" | while IFS=$'\t' read -r tfname cid; do
  TFCLIENT_TO_ID["$tfname"]="$cid"
done

# 2) Clients
awk '/resource "keycloak_openid_client" "[^"]+"/ {match($0,/resource "keycloak_openid_client" "([^"]+)"/,m); if(m[1]!=""){print "keycloak_openid_client." m[1]}}' "$GEN_FILE" | while read -r addr; do
  if have_state "$addr"; then continue; fi
  tfname=${addr#keycloak_openid_client.}
  cid=${TFCLIENT_TO_ID[$tfname]:-}
  uuid=${CLIENT_UUID[$cid]:-}
  if [ -z "$cid" ] || [ -z "$uuid" ]; then
    echo "Skipping $addr (missing client_id or UUID)." >&2
    continue
  fi
  read -r -p "Import $addr (client_id=$cid) with ID '$REALM/$uuid'? [y/N] " ans
  if [[ "$ans" =~ ^[Yy]$ ]]; then
    terraform -chdir="$TF_DIR" import "$addr" "$REALM/$uuid"
  fi
done

# 3) Client default/optional scopes (import id = realm/clientUUID)
import_scopes_type() {
  local type="$1" # keycloak_openid_client_default_scopes or _optional_scopes
  awk -v t="$type" '
    $0 ~ "resource \"" t "\" \"[^"]+\"" {match($0,/resource \"[^\"]+\" \"([^\"]+)\"/,m); name=m[1]; in=1; next}
    in && /client_id *= *keycloak_openid_client\.[A-Za-z0-9_]+\.id/ {match($0,/client_id *= *keycloak_openid_client\.([A-Za-z0-9_]+)\.id/,m); ctf=m[1]; print name "\t" ctf; in=0}
  ' "$GEN_FILE" | while IFS=$'\t' read -r rname ctf; do
    local addr="$type.$rname"
    if have_state "$addr"; then continue; fi
    local cid="${TFCLIENT_TO_ID[$ctf]:-}"
    local uuid="${CLIENT_UUID[$cid]:-}"
    if [ -z "$uuid" ]; then
      echo "Skipping $addr (missing UUID for client tf=$ctf cid=$cid)." >&2
      continue
    fi
    read -r -p "Import $addr for client '$ctf' with ID '$REALM/$uuid'? [y/N] " ans
    if [[ "$ans" =~ ^[Yy]$ ]]; then
      terraform -chdir="$TF_DIR" import "$addr" "$REALM/$uuid"
    fi
  done
}

import_scopes_type "keycloak_openid_client_default_scopes"
import_scopes_type "keycloak_openid_client_optional_scopes"

echo "Done. Note: protocol mappers are not auto-imported here; import them explicitly if needed."
