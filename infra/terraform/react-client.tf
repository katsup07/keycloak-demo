resource "keycloak_openid_client" "react_client" {
  realm_id  = keycloak_realm.keycloak_demo.id
  client_id = "react-client"
  name      = "react-client"

  enabled     = true
  access_type = "PUBLIC"

  standard_flow_enabled         = true
  implicit_flow_enabled         = false
  direct_access_grants_enabled  = false
  service_accounts_enabled      = false

  valid_redirect_uris = [
    "http://localhost:3000/*",
    "http://localhost:3001/*"
  ]
  web_origins = [
    "http://localhost:3001",
    "http://localhost:3000"
  ]

  lifecycle {
    # This attribute isn't reliably present in exports; avoid noisy drift
    ignore_changes = [use_refresh_tokens]
  }
}

resource "keycloak_openid_audience_protocol_mapper" "react_client_aud_mapper_0" {
  realm_id  = keycloak_realm.keycloak_demo.id
  client_id = keycloak_openid_client.react_client.id
  name      = "aud-mapper"
  included_client_audience = "react-client"
  add_to_id_token       = true
  add_to_access_token   = true
}

resource "keycloak_openid_client_default_scopes" "react_client_default_scopes" {
  realm_id  = keycloak_realm.keycloak_demo.id
  client_id = keycloak_openid_client.react_client.id
  default_scopes = local.default_scopes
}

resource "keycloak_openid_client_optional_scopes" "react_client_optional_scopes" {
  realm_id  = keycloak_realm.keycloak_demo.id
  client_id = keycloak_openid_client.react_client.id
  optional_scopes = local.optional_scopes
}

