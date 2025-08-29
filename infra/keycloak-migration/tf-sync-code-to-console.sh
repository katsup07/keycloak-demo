#!/usr/bin/env bash
set -euo pipefail

# Code → Console sync
# - terraform init
# - terraform plan
# - If adds are detected and objects already exist in Console, optionally import manually
# - Re-run plan
# - Optionally terraform apply
#
# Run from repo root.

ROOT_DIR=$(pwd)
TF_DIR="$ROOT_DIR/infra/terraform"

echo "Keycloak Terraform Sync: Code → Console"
echo "----------------------------------------"

echo "==> Step 1: terraform init (safe if already initialized)"
terraform -chdir="$TF_DIR" init -input=false -upgrade || true

echo ""
echo "==> Step 2: terraform plan"
PLAN_OUT=$(mktemp)
terraform -chdir="$TF_DIR" plan -no-color | tee "$PLAN_OUT" || true

SUMMARY=$(grep -E "^Plan: [0-9]+ to add, [0-9]+ to change, [0-9]+ to destroy\.$" "$PLAN_OUT" || true)
ADDS=$(echo "$SUMMARY" | sed -E 's/^Plan: ([0-9]+) to add, .*/\1/' || echo "0")

if [[ -n "$SUMMARY" ]]; then
	echo "-- $SUMMARY"
fi

if [[ "${ADDS:-0}" -gt 0 ]]; then
	echo ""
	echo "Detected resources to add. If these already exist in Keycloak, import them into Terraform state first using 'terraform import'."
	echo "After importing, re-run 'terraform -chdir=$TF_DIR plan' to verify a clean plan."
fi

read -r -p "Apply Terraform configuration to Keycloak now? [y/N] " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
	terraform -chdir="$TF_DIR" apply
else
	echo "Skipped apply."
fi

echo "Done (Code → Console)."

