variable "keycloak_username" {
  description = "Keycloak admin username"
  type        = string
  default     = "admin"
}

variable "keycloak_password" {
  description = "Keycloak admin password"
  type        = string
  sensitive   = true
}

variable "keycloak_url" {
  description = "Keycloak URL"
  type        = string
  default     = "http://localhost:8080"
}

variable "keycloak_realm" {
  description = "Keycloak realm for authentication"
  type        = string
  default     = "master"
}

variable "keycloak_client_id" {
  description = "Keycloak client ID for Terraform"
  type        = string
  default     = "admin-cli"
}

variable "keycloak_client_secret" {
  description = "Keycloak client secret (if using confidential client)"
  type        = string
  sensitive   = true
  default     = null
}

# TODO(prod): Supply these via secure workspace variables or a secrets manager, like AWS Secrets Manager
variable "spring_boot_client_secret" {
  description = "Secret for spring-boot-client"
  type        = string
  sensitive   = true
}

variable "typescript_express_client_secret" {
  description = "Secret for typescript-express-client"
  type        = string
  sensitive   = true
}

# Aliases to keep generator output stable if it uses ID-based variable names
