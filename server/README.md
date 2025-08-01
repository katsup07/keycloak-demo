# Keycloak Demo Server

This is a Spring Boot application demonstrating integration with Keycloak for OAuth2/JWT authentication and authorization.

## Prerequisites

- Java 17
- Gradle 7.x or higher
- Keycloak server running on port 8080 (via Docker Compose)

## Configuration

The application is configured to work with:
- Keycloak realm: `keycloak-demo`
- Server port: `8081`
- Keycloak server: `http://localhost:8080`

## API Endpoints

### Public Endpoints (No authentication required)
- `GET /api/public/info` - Returns public information

### User Endpoints (Requires `user` or `admin` role)
- `GET /api/user/data` - Returns user-specific data

### Admin Endpoints (Requires `admin` role)
- `GET /api/admin/data` - Returns admin-only data

## Running the Application

1. Make sure Keycloak is running via Docker Compose from the root directory:
   ```bash
   cd ..
   docker-compose up -d
   ```

2. Run the Spring Boot application:
   ```bash
   ./gradlew bootRun
   ```

The application will start on port 8081.

## Testing

Run tests with:
```bash
./gradlew test
```

## Keycloak Setup Required

Before using the application, you need to configure Keycloak:

1. Access Keycloak admin console at `http://localhost:8080`
2. Create a realm named `keycloak-demo`
3. Create a client named `spring-boot-client` with:
   - Client Type: `confidential`
   - Standard Flow: Enabled
   - Valid Redirect URIs: `http://localhost:8081/*`
4. Create roles: `admin`, `user`
5. Create test users and assign appropriate roles

## CORS Configuration

The application is configured to allow CORS requests from:
- `http://localhost:3000` (React frontend)
- `http://localhost:8081` (Self)
