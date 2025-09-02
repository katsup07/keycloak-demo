resource "keycloak_role" "uma_authorization" {
  realm_id = keycloak_realm.keycloak_demo.id
  name     = "uma_authorization"
  lifecycle {
    ignore_changes = [composite_roles]
  }
}

resource "keycloak_role" "offline_access" {
  realm_id = keycloak_realm.keycloak_demo.id
  name     = "offline_access"
  lifecycle {
    ignore_changes = [composite_roles]
  }
}

resource "keycloak_role" "default-roles-keycloak-demo" {
  realm_id = keycloak_realm.keycloak_demo.id
  name     = "default-roles-keycloak-demo"
  # Use the role IDs to match console state exactly (avoids plan diffs)
  composite_roles = [
    "20ea1859-5ec2-4cf7-84c5-f8d272acb7c6",
    "3ac9f814-6a94-4afb-b743-d6ad10aa222d",
    "79f5f91f-6637-4eb8-88ea-da262bd17796",
    "d7582648-81b4-4fe0-8589-09c245142f21",
  ]
  lifecycle {
    ignore_changes = [composite_roles]
  }
}
