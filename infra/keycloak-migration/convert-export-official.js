#!/usr/bin/env node

/*
  convert-export-official.js
  - Generates Terraform for the official keycloak/keycloak provider (v5+)
  - Usage:
      node convert-export-official.js --realm <realmName>
      node convert-export-official.js --input ./keycloak-export/<realm>-realm.json --output ../terraform/generated-resources.tf
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

function ensureIdentifier(s) {
  const base = String(s).replace(/[^A-Za-z0-9_]/g, '_');
  return /^[A-Za-z_]/.test(base) ? base : `r_${base}`;
}

function esc(s) {
  if (s === null || s === undefined) return '';
  return JSON.stringify(String(s)).slice(1, -1);
}

// Escape Terraform interpolation sequences in strings (e.g., ${...} -> $${...})
function escHCL(s) {
  const e = esc(s);
  return e.replace(/\$\{/g, '$${');
}

function bool(v, d = false) {
  return (v === true || v === false) ? v : d;
}

function listBlock(name, arr) {
  if (!Array.isArray(arr) || arr.length === 0) {
    return `${name} = []`;
  }
  const items = arr.map((x) => `"${esc(x)}"`).join(',\n    ');
  return `${name} = [\n    ${items}\n  ]`;
}

function accessType(client) {
  if (client.publicClient) return 'PUBLIC';
  if (client.bearerOnly) return 'BEARER-ONLY';
  return 'CONFIDENTIAL';
}

function generateTerraformFromRealm(realm, opts = {}) {
  const includeMappers = !!opts.includeMappers;
  let out = '';

  const realmId = ensureIdentifier(realm.realm);

  out += `
resource "keycloak_realm" "${realmId}" {
  realm   = "${escHCL(realm.realm)}"
  enabled = ${bool(realm.enabled, true)}

  display_name              = "${escHCL(realm.displayName || '')}"
  login_with_email_allowed  = ${bool(realm.loginWithEmailAllowed)}
  registration_allowed      = ${bool(realm.registrationAllowed)}
  reset_password_allowed    = ${bool(realm.resetPasswordAllowed)}
  remember_me               = ${bool(realm.rememberMe)}
  verify_email              = ${bool(realm.verifyEmail)}

  ${realm.passwordPolicy ? `password_policy = "${escHCL(realm.passwordPolicy)}"` : ''}

  # Security
  ssl_required = "${escHCL(realm.sslRequired || 'external')}"
  ${realm.defaultSignatureAlgorithm !== undefined ? `default_signature_algorithm = "${escHCL(realm.defaultSignatureAlgorithm)}"` : ''}
  ${realm.refreshTokenMaxReuse !== undefined ? `refresh_token_max_reuse = ${realm.refreshTokenMaxReuse}` : ''}
}
`;

  // Clients
  const systemClients = new Set(['admin-cli', 'account', 'broker', 'security-admin-console', 'account-console', 'realm-management']);
  (realm.clients || []).forEach((client) => {
    if (!client || !client.clientId || systemClients.has(client.clientId)) return;
    const cid = ensureIdentifier(client.clientId);
  const clientRef = `keycloak_openid_client.${cid}`;

  out += `
resource "keycloak_openid_client" "${cid}" {
  realm_id  = keycloak_realm.${realmId}.id
  client_id = "${escHCL(client.clientId)}"
  name      = "${escHCL(client.name || client.clientId)}"

  enabled     = ${bool(client.enabled)}
  access_type = "${accessType(client)}"

  standard_flow_enabled         = ${bool(client.standardFlowEnabled)}
  implicit_flow_enabled         = ${bool(client.implicitFlowEnabled)}
  direct_access_grants_enabled  = ${bool(client.directAccessGrantsEnabled)}
  service_accounts_enabled      = ${bool(client.serviceAccountsEnabled)}

  ${listBlock('valid_redirect_uris', client.redirectUris)}
  ${listBlock('web_origins', client.webOrigins)}

  ${client.rootUrl ? `root_url = "${escHCL(client.rootUrl)}"` : ''}
  ${client.baseUrl ? `base_url = "${escHCL(client.baseUrl)}"` : ''}
  ${client.adminUrl ? `admin_url = "${escHCL(client.adminUrl)}"` : ''}
  ${client.secret && !client.publicClient && !client.bearerOnly ? (()=>{ const vname = ensureIdentifier(client.clientId) + '_secret'; return `client_secret = var.${vname}`; })() : ''}

  lifecycle {
    # This attribute isn't reliably present in exports; avoid noisy drift
    ignore_changes = [use_refresh_tokens]
  }
}
`;

    // Protocol mappers -> map known OIDC mapper types
    if (includeMappers) {
      const pms = client.protocolMappers || [];
      pms.forEach((pm, idx) => {
      if (pm.protocol !== 'openid-connect') return;
      const pmId = ensureIdentifier(`${client.clientId}_${pm.name || 'mapper'}_${idx}`);
      const cfg = pm.config || {};
      const base = `
resource "keycloak_openid_`;
  switch (pm.protocolMapper) {
        case 'oidc-user-attribute-mapper':
          out += `${base}user_attribute_protocol_mapper" "${pmId}" {
  realm_id  = keycloak_realm.${realmId}.id
  client_id = ${clientRef}.id
  name      = "${escHCL(pm.name || 'user-attribute')}"
  claim_name            = "${escHCL(cfg['claim.name'] || '')}"
  user_attribute        = "${escHCL(cfg['user.attribute'] || '')}"
  claim_value_type      = "${escHCL(cfg['jsonType.label'] || 'String')}"
  add_to_id_token       = ${cfg['id.token.claim'] === 'true'}
  add_to_access_token   = ${cfg['access.token.claim'] === 'true'}
  add_to_userinfo       = ${cfg['userinfo.token.claim'] === 'true'}
}
`;
          break;
        case 'oidc-usermodel-property-mapper':
          out += `${base}user_property_protocol_mapper" "${pmId}" {
  realm_id  = keycloak_realm.${realmId}.id
  client_id = ${clientRef}.id
  name      = "${escHCL(pm.name || 'user-property')}"
  claim_name            = "${escHCL(cfg['claim.name'] || '')}"
  user_property         = "${escHCL(cfg['user.attribute'] || '')}"
  claim_value_type      = "${escHCL(cfg['jsonType.label'] || 'String')}"
  add_to_id_token       = ${cfg['id.token.claim'] === 'true'}
  add_to_access_token   = ${cfg['access.token.claim'] === 'true'}
  add_to_userinfo       = ${cfg['userinfo.token.claim'] === 'true'}
}
`;
          break;
  case 'oidc-audience-mapper':
          out += `${base}audience_protocol_mapper" "${pmId}" {
  realm_id  = keycloak_realm.${realmId}.id
  client_id = ${clientRef}.id
  name      = "${escHCL(pm.name || 'audience')}"
  included_client_audience = "${escHCL(cfg['included.client.audience'] || '')}"
  add_to_id_token       = ${cfg['id.token.claim'] === 'true'}
  add_to_access_token   = ${cfg['access.token.claim'] === 'true'}
}
`;
          break;
        case 'oidc-audience-resolve-mapper':
          out += `${base}audience_resolve_protocol_mapper" "${pmId}" {
  realm_id  = keycloak_realm.${realmId}.id
  client_id = ${clientRef}.id
  name      = "${escHCL(pm.name || 'audience-resolve')}"
  add_to_access_token   = ${cfg['access.token.claim'] === 'true'}
}
`;
          break;
        case 'oidc-usersessionmodel-note-mapper':
          out += `${base}user_session_note_protocol_mapper" "${pmId}" {
  realm_id  = keycloak_realm.${realmId}.id
  client_id = ${clientRef}.id
  name      = "${escHCL(pm.name || 'session-note')}"
  claim_name            = "${escHCL(cfg['claim.name'] || '')}"
  claim_value_type      = "${escHCL(cfg['jsonType.label'] || 'String')}"
  user_session_note     = "${escHCL(cfg['user.session.note'] || '')}"
  add_to_id_token       = ${cfg['id.token.claim'] === 'true'}
  add_to_access_token   = ${cfg['access.token.claim'] === 'true'}
}
`;
          break;
        case 'oidc-allowed-origins-mapper':
          out += `${base}allowed_origins_protocol_mapper" "${pmId}" {
  realm_id  = keycloak_realm.${realmId}.id
  client_id = ${clientRef}.id
  name      = "${escHCL(pm.name || 'allowed-origins')}"
  add_to_access_token   = ${cfg['access.token.claim'] === 'true'}
}
`;
          break;
        case 'oidc-full-name-mapper':
          out += `${base}full_name_protocol_mapper" "${pmId}" {
  realm_id  = keycloak_realm.${realmId}.id
  client_id = ${clientRef}.id
  name      = "${escHCL(pm.name || 'full-name')}"
  add_to_id_token       = ${cfg['id.token.claim'] === 'true'}
  add_to_access_token   = ${cfg['access.token.claim'] === 'true'}
  add_to_userinfo       = ${cfg['userinfo.token.claim'] === 'true'}
}
`;
          break;
        default:
          // Fallback to generic client protocol mapper
          out += `
resource "keycloak_generic_client_protocol_mapper" "${pmId}" {
  realm_id  = keycloak_realm.${realmId}.id
  client_id = ${clientRef}.id
  name      = "${escHCL(pm.name || pm.protocolMapper)}"
  protocol  = "openid-connect"
  protocol_mapper = "${escHCL(pm.protocolMapper)}"
  config = {
${Object.entries(cfg).map(([k, v]) => `    "${escHCL(k)}" = "${escHCL(v)}"`).join('\n')}
  }
}
`;
          break;
      }
      });
    }

    // Attach default and optional client scopes for this client
    if (Array.isArray(client.defaultClientScopes) && client.defaultClientScopes.length) {
      const resId = ensureIdentifier(`${client.clientId}_default_scopes`);
      out += `
resource "keycloak_openid_client_default_scopes" "${resId}" {
  realm_id  = keycloak_realm.${realmId}.id
  client_id = ${clientRef}.id
  default_scopes = [${client.defaultClientScopes.map((s) => `"${escHCL(s)}"`).join(', ')}]
}
`;
    }
    if (Array.isArray(client.optionalClientScopes) && client.optionalClientScopes.length) {
      const resId = ensureIdentifier(`${client.clientId}_optional_scopes`);
      out += `
resource "keycloak_openid_client_optional_scopes" "${resId}" {
  realm_id  = keycloak_realm.${realmId}.id
  client_id = ${clientRef}.id
  optional_scopes = [${client.optionalClientScopes.map((s) => `"${escHCL(s)}"`).join(', ')}]
}
`;
    }
  });

  // Realm roles
  const skipRoles = new Set(['offline_access', 'uma_authorization']);
  ((realm.roles && realm.roles.realm) || []).forEach((role) => {
    if (!role || !role.name) return;
    if (role.name.startsWith('default-roles-') || skipRoles.has(role.name)) return;

    const rid = ensureIdentifier(role.name);
    out += `
resource "keycloak_role" "${rid}" {
  realm_id    = keycloak_realm.${realmId}.id
  name        = "${escHCL(role.name)}"
  description = "${escHCL(role.description || '')}"
}
`;
  });

  // Users (if present in realm export)
  (realm.users || []).forEach((user) => {
    if (!user || !user.username) return;
    if (user.username === 'admin') return;

    const uid = ensureIdentifier(user.username.replace(/[@.]/g, '_'));
    out += `
resource "keycloak_user" "${uid}" {
  realm_id = keycloak_realm.${realmId}.id
  username = "${escHCL(user.username)}"

  enabled        = ${bool(user.enabled)}
  email_verified = ${bool(user.emailVerified)}

  ${user.firstName ? `first_name = "${escHCL(user.firstName)}"` : ''}
  ${user.lastName ? `last_name = "${escHCL(user.lastName)}"` : ''}
  ${user.email ? `email = "${escHCL(user.email)}"` : ''}
}
`;
  });

  return out;
}

function main() {
  const args = parseArgs(process.argv);
  const realmName = args.realm;

  let inputPath = args.input;
  if (!inputPath) {
    const fileName = realmName ? `${realmName}-realm.json` : 'keycloak-demo-realm.json';
    inputPath = path.join(__dirname, 'keycloak-export', fileName);
  } else if (!path.isAbsolute(inputPath)) {
    inputPath = path.join(process.cwd(), inputPath);
  }

  let outputPath = args.output;
  if (!outputPath) {
    outputPath = path.join(__dirname, '..', 'terraform', 'generated-resources.tf');
  } else if (!path.isAbsolute(outputPath)) {
    outputPath = path.join(process.cwd(), outputPath);
  }

  if (!fs.existsSync(inputPath)) {
    console.error(`Input file not found: ${inputPath}`);
    process.exit(1);
  }

  const realmData = JSON.parse(fs.readFileSync(inputPath, 'utf8'));
  const includeMappers = args.mappers === true || String(args.mappers).toLowerCase() === 'true';
  const tf = generateTerraformFromRealm(realmData, { includeMappers });

  // Ensure output dir exists
  fs.mkdirSync(path.dirname(outputPath), { recursive: true });
  fs.writeFileSync(outputPath, tf);
  console.log(`Generated Terraform written to: ${outputPath}`);
}

if (require.main === module) {
  try { main(); } catch (e) { console.error(e); process.exit(1); }
}
