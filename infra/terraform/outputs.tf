output "keycloak_demo_realm_id" {
  description = "ID of the keycloak-demo realm (if defined)"
  value       = try(keycloak_realm.keycloak_demo.id, null)
}
