#!/usr/bin/env bash
set -euo pipefail

# Console → Code sync (Option 1 helper)
# - Generate HCL from Keycloak export into infra/terraform/newly-generated-resources/generated-resources.<timestamp>.tf
# - Find the current infra/terraform/generated-resources*.tf and show a read-only diff
# - Emit helper scripts for imports (create-import-script-official.js)
# - Does NOT modify existing files; adopt manually if desired.
# - No Terraform init/plan/apply here. See README Option 1 for follow-ups.
#
# Run from repo root.

ROOT_DIR=$(pwd)
TF_DIR="$ROOT_DIR/infra/terraform"
NEW_DIR="$TF_DIR/newly-generated-resources"
CONVERTER="$ROOT_DIR/infra/keycloak-migration/convert-export-official.js"
IMPORT_HELPER="$ROOT_DIR/infra/keycloak-migration/create-import-script-official.js"
EXPORT_JSON=${EXPORT_JSON:-"$ROOT_DIR/infra/keycloak-migration/keycloak-export/keycloak-demo-realm.json"}
REALM_NAME=${REALM_NAME:-keycloak-demo}
KEYCLOAK_URL=${KEYCLOAK_URL:-http://localhost:8080}
KEYCLOAK_ADMIN_USER=${KEYCLOAK_ADMIN:-${KEYCLOAK_ADMIN_USER:-admin}}
KEYCLOAK_ADMIN_PASSWORD=${KEYCLOAK_ADMIN_PASSWORD:-${KEYCLOAK_ADMIN_PASS:-admin}}
# When true, fetch the live realm JSON from the Admin API before converting (avoids stale exports)
# FETCH_FROM_API modes: true|false|auto (default). In auto, try API then fall back to file.
FETCH_FROM_API=${FETCH_FROM_API:-auto}

echo "Keycloak Terraform Sync: Console → Code"
echo "----------------------------------------"

if [ ! -f "$CONVERTER" ]; then
	echo "ERROR: Converter not found at $CONVERTER" >&2
	exit 1
fi

if [ "$FETCH_FROM_API" = "true" ] || [ "$FETCH_FROM_API" = "auto" ]; then
	echo "==> Fetching live realm JSON from Admin API ($REALM_NAME)"
	if ! command -v curl >/dev/null 2>&1; then
		if [ "$FETCH_FROM_API" = "true" ]; then
			echo "ERROR: curl is required to fetch from API. Install curl or set FETCH_FROM_API=false." >&2
			exit 1
		else
			echo "WARN: curl not found; will fall back to local export JSON."
			FETCH_FROM_API=fallback
		fi
	fi
	if [ "$FETCH_FROM_API" != "fallback" ]; then
		# Get admin token from master realm
		TOKEN=$(curl -s -X POST "$KEYCLOAK_URL/realms/master/protocol/openid-connect/token" \
		-H "Content-Type: application/x-www-form-urlencoded" \
		-d "username=$KEYCLOAK_ADMIN_USER&password=$KEYCLOAK_ADMIN_PASSWORD&grant_type=password&client_id=admin-cli" | \
		sed -n 's/.*"access_token":"\([^"]*\)".*/\1/p')
		if [ -z "$TOKEN" ]; then
			if [ "$FETCH_FROM_API" = "true" ]; then
				echo "ERROR: Failed to obtain access token. Check KEYCLOAK_URL/KEYCLOAK_ADMIN/KEYCLOAK_ADMIN_PASSWORD." >&2
				exit 1
			else
				echo "WARN: Could not obtain admin token; falling back to local export JSON."
				FETCH_FROM_API=fallback
			fi
		fi
	fi
		if [ "$FETCH_FROM_API" != "fallback" ]; then
			mkdir -p "$NEW_DIR"
			TS=$(date +%Y%m%d_%H%M%S)
			LIVE_EXPORT="$NEW_DIR/${REALM_NAME}-realm.$TS.json"
			# Try partial export first to include clients and roles
			if curl -s -X POST \
				-H "Authorization: Bearer $TOKEN" \
				-H "Content-Type: application/json" \
				"$KEYCLOAK_URL/admin/realms/$REALM_NAME/partial-export?exportClients=true&exportUsers=false" \
				-d '{}' -o "$LIVE_EXPORT" && [ -s "$LIVE_EXPORT" ]; then
				echo "Saved live partial export JSON to: $LIVE_EXPORT"
				EXPORT_JSON="$LIVE_EXPORT"
			else
				echo "WARN: Partial export failed; trying realm representation (clients may be missing)"
				if curl -s -H "Authorization: Bearer $TOKEN" "$KEYCLOAK_URL/admin/realms/$REALM_NAME" -o "$LIVE_EXPORT" && [ -s "$LIVE_EXPORT" ]; then
					echo "Saved live realm JSON to: $LIVE_EXPORT"
					EXPORT_JSON="$LIVE_EXPORT"
				else
					if [ "$FETCH_FROM_API" = "true" ]; then
						echo "ERROR: Failed to download realm/partial export from API." >&2
						exit 1
					else
						echo "WARN: Failed to fetch realm JSON; falling back to local export JSON."
						FETCH_FROM_API=fallback
					fi
				fi
			fi
		fi
fi

if [ ! -f "$EXPORT_JSON" ]; then
	echo "ERROR: Export JSON not found at $EXPORT_JSON" >&2
	echo "Hint: Export your realm JSON from Keycloak Console OR set FETCH_FROM_API=true with admin credentials (see README)." >&2
	exit 1
fi

echo "==> Generate timestamped HCL from export"
echo "Using export JSON: $EXPORT_JSON"
if command -v date >/dev/null 2>&1; then
	echo "Export last modified: $(date -r "$EXPORT_JSON" 2>/dev/null || echo N/A)"
fi
mkdir -p "$NEW_DIR"
TS=$(date +%Y%m%d_%H%M%S)
NEW_FILE="$NEW_DIR/generated-resources.$TS.tf"
node "$CONVERTER" --input "$EXPORT_JSON" --output "$NEW_FILE" --mappers true
echo "Generated Terraform written to: $NEW_FILE"

echo ""
echo "==> Locate current generated-resources.tf for diff"
# Prefer the newest matching file in infra/terraform (not in subfolders); portable for macOS bash 3.x
CURRENT_FILE=$(ls -t "$TF_DIR"/generated-resources.tf 2>/dev/null | grep -v "/newly-generated-resources/" | head -n1 || true)

if [ -n "$CURRENT_FILE" ]; then
	echo "Diff vs: $CURRENT_FILE"
	diff -u "$CURRENT_FILE" "$NEW_FILE" || true
else
	echo "No existing generated-resources*.tf found in $TF_DIR; this appears to be the first generation."
fi

echo ""
echo "==> Emit helper import scripts (ids + import skeleton)"
if [ -f "$IMPORT_HELPER" ]; then
	node "$IMPORT_HELPER" \
		--realm "$REALM_NAME" \
		--url "$KEYCLOAK_URL" \
		--admin "$KEYCLOAK_ADMIN_USER" \
		--password "$KEYCLOAK_ADMIN_PASSWORD"
	echo "Created helper scripts in: $ROOT_DIR/infra/keycloak-migration/"
	echo "- get-keycloak-ids.sh (lists UUIDs via Admin API)"
	echo "- import-skeleton.sh  (fill in resource names + IDs, then run)"
else
	echo "WARN: Import helper not found at $IMPORT_HELPER; skipping script emission"
fi

echo ""
echo "Done (Console → Code)."
echo "Next steps (README Option 1):"
echo "  1) Review the diff above. If acceptable, you can adopt it by copying:"
echo "     cp \"$NEW_FILE\" \"$TF_DIR/generated-resources.tf\""
echo "  2) Run: node infra/keycloak-migration/create-import-script-official.js --realm $REALM_NAME --url $KEYCLOAK_URL --admin \"$KEYCLOAK_ADMIN_USER\" --password \"$KEYCLOAK_ADMIN_PASSWORD\""
echo "  3) Run: infra/keycloak-migration/get-keycloak-ids.sh  # requires Keycloak running and correct creds"
echo "  4) Edit infra/keycloak-migration/import-skeleton.sh with resource names & IDs, then execute it"
echo "  5) Optionally: terraform -chdir=infra/terraform plan && terraform -chdir=infra/terraform apply"

