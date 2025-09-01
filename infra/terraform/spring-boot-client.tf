resource "keycloak_openid_client" "spring_boot_client" {
  realm_id  = keycloak_realm.keycloak_demo.id
  client_id = "spring-boot-client"
  name      = "resource server"

  enabled     = true
  access_type = "CONFIDENTIAL"

  standard_flow_enabled         = true
  implicit_flow_enabled         = false
  direct_access_grants_enabled  = true
  service_accounts_enabled      = false

  valid_redirect_uris = [
    "http://localhost:8081/*"
  ]
  web_origins = [
    "http://localhost:8081"
  ]

  client_secret = var.spring_boot_client_secret

  lifecycle {
    # This attribute isn't reliably present in exports; avoid noisy drift
    ignore_changes = [use_refresh_tokens]
  }
}

resource "keycloak_openid_audience_protocol_mapper" "spring_boot_client_audience_mapper_0" {
  realm_id  = keycloak_realm.keycloak_demo.id
  client_id = keycloak_openid_client.spring_boot_client.id
  name      = "audience-mapper"
  included_client_audience = "spring-boot-client"
  add_to_id_token       = true
  add_to_access_token   = true
}

resource "keycloak_openid_client_default_scopes" "spring_boot_client_default_scopes" {
  realm_id  = keycloak_realm.keycloak_demo.id
  client_id = keycloak_openid_client.spring_boot_client.id
  default_scopes = local.default_scopes
}

resource "keycloak_openid_client_optional_scopes" "spring_boot_client_optional_scopes" {
  realm_id  = keycloak_realm.keycloak_demo.id
  client_id = keycloak_openid_client.spring_boot_client.id
  optional_scopes = local.optional_scopes
}

