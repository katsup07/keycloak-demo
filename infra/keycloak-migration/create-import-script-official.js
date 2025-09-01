#!/usr/bin/env node

/*
  create-import-script-official.js
  - Emits helper shell scripts:
    - get-keycloak-ids.sh: fetch UUIDs/names for import using Admin API
    - import-skeleton.sh: template terraform import commands
  - Usage:
      node create-import-script-official.js --realm <realmName> \
        --url http://localhost:8080 \
        --admin ${KEYCLOAK_ADMIN} --password ${KEYCLOAK_ADMIN_PASSWORD}
*/

const fs = require('fs');
const path = require('path');

function parseArgs(argv) {
  const args = {};
  for (let i = 2; i < argv.length; i++) {
    const a = argv[i];
    if (a.startsWith('--')) {
      const [k, v] = a.includes('=') ? a.slice(2).split('=') : [a.slice(2), argv[i + 1]];
      if (!a.includes('=') && v && !v.startsWith('--')) i++;
      args[k] = v ?? true;
    }
  }
  return args;
}

function main() {
  const args = parseArgs(process.argv);
  const realm = args.realm || 'keycloak-demo';
  const url = (args.url || 'http://localhost:8080').replace(/\/$/, '');
  const admin = args.admin || 'admin';
  const password = args.password || 'admin';

  const dir = __dirname;

  const getIds = `#!/usr/bin/env bash
set -euo pipefail
REALM=${realm}
KEYCLOAK_URL=${url}
KEYCLOAK_ADMIN=${admin}
KEYCLOAK_ADMIN_PASSWORD=${password}

if ! command -v jq >/dev/null 2>&1; then
  echo "jq is required (brew install jq)" >&2
  exit 1
fi

ACCESS_TOKEN=$(curl -s -X POST "$KEYCLOAK_URL/realms/master/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=$KEYCLOAK_ADMIN&password=$KEYCLOAK_ADMIN_PASSWORD&grant_type=password&client_id=admin-cli" | jq -r '.access_token')

if [[ -z "$ACCESS_TOKEN" || "$ACCESS_TOKEN" == "null" ]]; then
  echo "Failed to obtain access token" >&2
  exit 1
fi

echo "# Keycloak Resource IDs for realm: $REALM"
echo ""
echo "# Clients:"
curl -s -X GET "$KEYCLOAK_URL/admin/realms/$REALM/clients" \
  -H "Authorization: Bearer $ACCESS_TOKEN" | jq -r '.[] | (.clientId + " -> " + .id)'

echo ""
echo "# Roles:"
curl -s -X GET "$KEYCLOAK_URL/admin/realms/$REALM/roles" \
  -H "Authorization: Bearer $ACCESS_TOKEN" | jq -r '.[] | (.name + " -> " + (.id // "(no-uuid-use-name)"))'

echo ""
echo "# Users:"
curl -s -X GET "$KEYCLOAK_URL/admin/realms/$REALM/users" \
  -H "Authorization: Bearer $ACCESS_TOKEN" | jq -r '.[] | (.username + " -> " + .id)'
`;

  const importTemplate = `#!/usr/bin/env bash
set -euo pipefail

# Set your realm name
REALM=${realm}

# Terraform directory (run this script from the repo root)
TF_DIR="infra/terraform"

# Import the realm itself
terraform -chdir="$TF_DIR" import keycloak_realm.${realm.replace(/[^A-Za-z0-9_]/g, '_')} $REALM

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
`;

  const getIdsPath = path.join(dir, 'get-keycloak-ids.sh');
  const importPath = path.join(dir, 'import-skeleton.sh');

  fs.writeFileSync(getIdsPath, getIds, { mode: 0o755 });
  fs.writeFileSync(importPath, importTemplate, { mode: 0o755 });

  console.log(`Created: ${getIdsPath}`);
  console.log(`Created: ${importPath}`);
}

if (require.main === module) {
  try { main(); } catch (e) { console.error(e); process.exit(1); }
}
