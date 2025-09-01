# Variables
DOCKER_COMPOSE_FILE = infra/docker-compose.yml
DOCKER_COMPOSE = docker compose

.PHONY: help infra stop client server dev-all logs status clean backup-db \
	tf-import tf-regenerate \
	tf-sync-console-to-code tf-sync-code-to-console

# Default target
help:
	@echo "Available commands:"
	@echo "  make infra    - Start infrastructure containers (Postgres + Keycloak)"
	@echo "  make dev-all  - Start everything in background (experimental)"
	@echo "  make stop     - Stop all services"
	@echo "  make client   - Start React client"
	@echo "  make javaServer - Start Spring Boot server"
	@echo "  make tsServer - Start TypeScript server"
	@echo "  make logs     - Show container logs"
	@echo "  make status   - Show container status"
	@echo "  make clean    - Stop and clean everything"
	@echo "  make db-backup - Create database backup"
	@echo "  make tf-import - Import existing realm/clients into Terraform state"
	@echo "  make tf-sync-console-to-code - Console → Code: generate timestamped HCL under newly-generated-resources and show diff (no changes to generated-resources.tf)"
	@echo "  make tf-sync-code-to-console - Code → Console: init, plan, optional apply"

# Start infrastructure containers
infra:
	@echo "🚀 Starting Keycloak Demo Environment..."
	@echo "1. Starting containers (Postgres + Keycloak)..."
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d
	@echo "2. Waiting for services to be ready..."
	@sleep 15
	@echo "3. Checking container status..."
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) ps
	@echo ""
	@echo "✅ Containers are running!"
	@echo ""
	@echo "📋 Container logs (Press Ctrl+C to stop viewing logs):"
	@echo ""
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) logs -f

# Stop all services
stop:
	@echo "🛑 Stopping all services..."
	@pkill -f "npm run dev" || true
	@pkill -f "gradlew bootRun" || true
	@lsof -ti :8081 | xargs kill -9 || true
	@lsof -ti :8082 | xargs kill -9 || true
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down
	@echo "✅ All services stopped"

# Individual service commands
client:
	@echo "Starting React client..."
	cd client && npm run dev

javaServer:
	@echo "Starting Spring Boot server..."
	cd server && ./gradlew bootRun

tsServer:
	@echo "Starting TypeScript server..."
	cd server-ts && npm run dev

# Utility commands
logs:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) logs -f

status:
	@echo "Container Status:"
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) ps
	@echo ""
	@echo "Process Status:"
	@pgrep -f "npm run dev" > /dev/null && echo "✅ React client running" || echo "❌ React client not running"
	@pgrep -f "gradlew bootRun" > /dev/null && echo "✅ Spring Boot server running" || echo "❌ Spring Boot server not running"

clean:
	@echo "🧹 Cleaning up everything..."
	@pkill -f "npm run dev" || true
	@pkill -f "gradlew bootRun" || true
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down
	@rm -rf logs/
	docker system prune -f
	@echo "✅ Cleanup complete"

# Setup logs directory
setup-logs:
	@mkdir -p logs

# Backup database
db-backup:
	@echo "📦 Creating database backup..."
	@mkdir -p infra/db-backups
	@docker exec keycloak-postgres pg_dumpall -U keycloak > infra/db-backups/keycloak_backup_$(shell date +%Y%m%d_%H%M%S).sql
	@echo "✅ Database backup created in infra/db-backups/ folder"

# Import Terraform state for realm/clients using prepared scripts
tf-import:
	@echo "🔎 Fetching Keycloak IDs..."
	bash infra/keycloak-migration/get-keycloak-ids.sh | sed -n '1,120p'
	@echo "\n➡️  Running import template (edit if needed):"
	bash infra/keycloak-migration/import-skeleton.sh
	@echo "\n✅ Imports complete. To verify: terraform -chdir=infra/terraform plan"

# (Removed) tf-import-missing has been deprecated; use terraform import manually if adopting existing objects.

# Regenerate -> diff -> plan
tf-regenerate:
	@echo "🔁 Regenerating generated-resources.tf (to temp)"
	node infra/keycloak-migration/convert-export-official.js \
	  --input infra/keycloak-migration/keycloak-export/keycloak-demo-realm.json \
	  --output infra/terraform/generated-resources.tmp.tf \
	  --mappers true
	@echo "\n📋 Diff against committed generated-resources.tf"
	diff -u infra/terraform/generated-resources.tf infra/terraform/generated-resources.tmp.tf || true
	@echo "\n🧭 Running terraform plan (uses committed generated-resources.tf)"
	terraform -chdir=infra/terraform plan || true

# Split flows
tf-sync-console-to-code:
	@bash infra/keycloak-migration/tf-sync-console-to-code.sh

tf-sync-code-to-console:
	@bash infra/keycloak-migration/tf-sync-code-to-console.sh