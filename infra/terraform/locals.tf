locals {
  default_scopes  = ["web-origins", "acr", "profile", "roles", "basic", "email"]
  optional_scopes = ["address", "phone", "offline_access", "microprofile-jwt"]
}

