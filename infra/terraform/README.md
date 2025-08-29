# Terraform for Keycloak Demo
This folder manages Keycloak configuration using the official `keycloak/keycloak` Terraform provider.
The two options below allow for 1. Converting keycloak settings from Console to Code or 2. Code to Console. 
Run all commands from the repository root unless otherwise noted.
There are shortcuts in the Makefile since there are a number of commands to be run in either option.

## Shortcuts (Make targets)
- `make tf-import` — Lists IDs and runs the import skeleton (imports existing realm/clients into Terraform state).
- `make tf-regenerate` — Regenerates to a temp file, shows a diff vs committed `generated-resources.tf`, and runs `terraform plan`.
- `make tf-sync-console-to-code` — Console-first helper that generates a timestamped HCL file under `newly-generated-resources/` and shows a diff against `generated-resources.tf`. It does not modify `generated-resources.tf` or run plan/apply. 
  If adopting existing Console-configured resources, use `terraform import` manually as needed.

## Files
- `main.tf`: Provider configuration.
- `variables.tf`: Variable definitions. Sensitive values should be provided via environment variables or a local `terraform.tfvars` (gitignored).
- `generated-resources.tf`: GENERATED — do not edit. Produced by the Keycloak export → Terraform converter.
- `terraform.tfvars.example`: Example inputs. Copy to `terraform.tfvars` locally if preferred, but keep secrets uncommitted.

## Option 1 - Console First Workflow — Generate Settings from Keycloak Console (export → convert → import) - Console -> Code
Use this when you configured values in the Keycloak Console and want Terraform to adopt them.

1) Export realm and convert to HCL

```bash
# Export your realm from Keycloak Console (JSON file)
# Then convert it to HCL (overwrites generated-resources.tf)
node infra/keycloak-migration/convert-export-official.js \
  --input infra/keycloak-migration/keycloak-export/keycloak-demo-realm.json \
  --output infra/terraform/generated-resources.tf \
  --mappers true
```

2) Prepare imports

```bash
# Generate helper scripts
node infra/keycloak-migration/create-import-script-official.js \
  --realm keycloak-demo \
  --url http://localhost:8080 \
  --admin "$KEYCLOAK_ADMIN" \
  --password "$KEYCLOAK_ADMIN_PASSWORD"

# List UUIDs for clients, users, roles, mappers
infra/keycloak-migration/get-keycloak-ids.sh
```

Edit `infra/keycloak-migration/import-skeleton.sh` with the resource names from HCL and IDs from the listing, then import:

```bash
# Examples
terraform import keycloak_realm.keycloak_demo keycloak-demo
terraform import keycloak_openid_client.react_client keycloak-demo/<client_uuid>
# Mapper import format includes "/client/"
terraform import keycloak_openid_audience_protocol_mapper.react_client_aud_mapper_0 \
  keycloak-demo/client/<client_uuid>/<mapper_uuid>
```

## Option 2 - Code First Workflow — Plan and Apply - Code -> Console
Use this for day-to-day changes. You edit code in the terraform folder and let Terraform update Keycloak. 
This is the ideal way to make changes, but if unsure how to do so, the generated-resources.tf can generate from the console so you can see how to make the changes in code.

1) Make changes in code
- Prefer separate `.tf` files (e.g., `clients.tf`, `mappers.tf`) for hand-written changes.
- Avoid editing `generated-resources.tf` directly since regeneration will overwrite it.

2) Provide variables

```bash
export TF_VAR_keycloak_password=... 
export TF_VAR_spring_boot_client_secret=...
export TF_VAR_typescript_express_client_secret=...
```

Or create a local `terraform.tfvars` (gitignored) from `terraform.tfvars.example`.

3) Plan and apply

```bash
terraform -chdir=infra/terraform plan
terraform -chdir=infra/terraform apply
```

## Secrets
- Prefer environment variables (`TF_VAR_*`) or secure workspace variables. 
- Alternatively use a local, untracked `terraform.tfvars` based on `terraform.tfvars.example` (current local approach).

## Notes
- Keep hand-written/permanent resources in separate `.tf` files so regeneration doesn’t overwrite them.
- Some attributes can be noisy; we use `lifecycle { ignore_changes = [...] }` where needed.
