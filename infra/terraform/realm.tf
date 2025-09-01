resource "keycloak_realm" "keycloak_demo" {
  realm   = "keycloak-demo"
  enabled = true

  display_name             = ""
  login_with_email_allowed = true
  registration_allowed     = true
  reset_password_allowed   = true
  remember_me              = true
  verify_email             = false

  internationalization {
    supported_locales = ["en", "jp"]
    default_locale    = "jp"
  }

  # Pin themes to ones available on the server
  login_theme   = "custom-theme"
  account_theme = "base"
  email_theme   = "base"
  admin_theme   = "base"

  # Security
  ssl_required                = "none"
  default_signature_algorithm = "RS256"
  refresh_token_max_reuse     = 2
}
