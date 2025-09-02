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



