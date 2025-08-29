terraform {
  required_version = ">= 1.0"
  required_providers {
    keycloak = {
      source  = "keycloak/keycloak"
      version = ">= 5.0.0"
    }
  }
}

provider "keycloak" {
  client_id      = "admin-cli"
  username       = var.keycloak_username
  password       = var.keycloak_password
  url            = var.keycloak_url
  realm          = "master"
  client_timeout = 60
}