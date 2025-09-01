resource "keycloak_openid_client" "typescript_express_client" {
  realm_id  = keycloak_realm.keycloak_demo.id
  client_id = "typescript-express-client"
  name      = "typescript-express-client"

  enabled     = true
  access_type = "CONFIDENTIAL"

  standard_flow_enabled         = true
  implicit_flow_enabled         = false
  direct_access_grants_enabled  = false
  service_accounts_enabled      = false

  valid_redirect_uris = [
    "http://localhost:8082/*"
  ]
  web_origins = [
    "http://localhost:8082"
  ]

  root_url = "http://localhost:8082"
  
  admin_url = "http://localhost:8082"
  client_secret = var.typescript_express_client_secret

  lifecycle {
    # This attribute isn't reliably present in exports; avoid noisy drift
    ignore_changes = [use_refresh_tokens]
  }
}

resource "keycloak_openid_client_default_scopes" "typescript_express_client_default_scopes" {
  realm_id  = keycloak_realm.keycloak_demo.id
  client_id = keycloak_openid_client.typescript_express_client.id
  default_scopes = local.default_scopes
}

resource "keycloak_openid_client_optional_scopes" "typescript_express_client_optional_scopes" {
  realm_id  = keycloak_realm.keycloak_demo.id
  client_id = keycloak_openid_client.typescript_express_client.id
  optional_scopes = local.optional_scopes
}

