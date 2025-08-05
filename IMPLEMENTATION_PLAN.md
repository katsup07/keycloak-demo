## Implementation Plan

## Phase 1: Infrastructure Setup

#### Step 1.1: Docker Environment Setup
- [done] Create `docker-compose.yml` with Keycloak and PostgreSQL
- [done] Configure environment variables for Keycloak
- [done] Set up persistent volumes for database
- [done] Test Keycloak admin console access
- [done] **Port Management**: 
  - Keycloak: 8080
  - Spring Boot: 8081
  - React: 3000
  - PostgreSQL: 5432
- [done] **Data Persistence**:
  - Named volumes for PostgreSQL data

#### Step 1.2: Keycloak Configuration
- [done] Create realm: `keycloak-demo`
- [done] Configure OAuth2 client: `react-client`
  - Client Type: Public
  - Valid Redirect URIs: `http://localhost:3000/*`
  - Web Origins: `http://localhost:3000`
- [done] Create roles: `admin`, `user`
- [done] Create test users:
  - `admin@test.com` with admin role
  - `user@test.com` with user role
- [done] Configure token settings (access token lifespan, refresh token settings)
- [done] **Security Configuration Details**:
  - Access Type: `confidential`
  - Standard Flow: Enabled
  - Direct Access Grants: Enabled
  - Valid Redirect URIs: `http://localhost:8081/*`
  - Token lifespans: Access token (15min), Refresh token (30 days)
  - CORS origins: Explicitly list allowed origins (`http://localhost:3000`, `http://localhost:8081`)

#### Database Backup Notes 
# Development Note: Run this whenever you want a new backup of the DB before making changes
docker exec keycloak-postgres pg_dump -U keycloak keycloak > keycloak_backup_$(date +%Y%m%d_%H%M%S).sql
# Production Note: Set up a cron job for automated daily backups in production
# Example cron job (runs daily at 2 AM):
# 0 2 * * * docker exec keycloak-postgres pg_dump -U keycloak keycloak > /path/to/backups/keycloak_backup_$(date +\%Y\%m\%d_\%H\%M\%S).sql


### Phase 2: Backend Development

#### Step 2.1: Spring Boot Project Setup
- [done] Initialize Spring Boot project with dependencies:
  - `spring-boot-starter-web`
  - `spring-boot-starter-security`
  - `spring-boot-starter-oauth2-resource-server`
  - `keycloak-spring-boot-starter`
- [done] Configure application properties for Keycloak integration
- [done] Set up CORS configuration

#### Step 2.2: Security Configuration
- [done] Configure OAuth2 resource server
- [done] Implement JWT token validation
- [done] Set up method-level security with role-based access
- [done] Configure Keycloak adapter properties

#### Step 2.3: API Endpoints Implementation
- [done] Create `AdminController` with `/api/admin/data` endpoint
- [done] Create `UserController` with `/api/user/data` endpoint  
- [done] Create `PublicController` with `/api/public/info` endpoint
- [done] Implement role-based authorization using `@PreAuthorize`
- [done] Add error handling for unauthorized access


### Phase 3: Frontend Development

#### Step 3.1: React Project Setup
- [done] Create React application using Vite with React 18 and set port to 3000
- [done] Install Keycloak JavaScript adapter: `keycloak-js@^24.0.0` (latest stable)
- [done] Install additional dependencies: 
  - `axios@^1.6.0` - HTTP client
  - `react-router-dom@^6.20.0` - routing
  - `react-toastify@^9.1.0` - notifications
  - `zustand@^4.4.0` - state management
- [done] **React Version Choice**: 
  - **Recommended**: React 18 (stable, production-ready, full ecosystem support)
- [done] **State Management Choice**: 
  - **Recommended for Demo**: Use Zustand (most flexible, easiest to understand, least boilerplate)
  - **Alternative**: Jotai for atomic state management or React Context API
- [done] Set up project structure with components, services, and utils folders
- [done] Configure routing with React Router

#### Step 3.2: Keycloak Integration
- [done] Configure Keycloak client in React app (realm: `keycloak-demo`, client: `react-client`)
- [done] Create functional Keycloak service module for initialization and token management:
  - `initializeKeycloak()` - initialize and configure Keycloak instance
  - `login()`, `logout()` - authentication methods
  - `getToken()`, `getUserInfo()` - token and user data access
  - `hasRole()` - role checking utility
- [done] Create authentication store using Zustand:
  - State: `{ user, isAuthenticated, roles, isLoading }`
  - Actions: `initializeAuth()`, `login()`, `logout()`
  - Selectors: `hasRole()`, `isAdmin()` 
- [done] Set up Keycloak initialization in app startup
- [done] Create protected route wrapper component with role-based access
- [done] Set up token refresh mechanism with automatic token renewal

#### Step 3.3: UI Components Development
- [done] Create Landing/Home component with login button (redirects to Keycloak)
- [done] Create Admin Dashboard component:
  - Display admin-specific data from `/api/admin/data` endpoint
  - Show user management interface (if desired)
  - Include role indicator and user info
- [done] Create User Dashboard component:
  - Display user-specific data from `/api/user/data` endpoint
  - Show user profile information
  - Include role indicator
- [done] Create Navigation component with role-based menu items
- [done] Implement logout functionality with proper cleanup
- [done] Add loading states and error boundaries

#### Step 3.4: API Integration & Error Handling
- [done] Set up Axios interceptors for automatic token attachment
- [done] Implement automatic token refresh on 401 responses
- [done] Create API service methods for all backend endpoints:
  - `getPublicInfo()` - calls `/api/public/info`
  - `getAdminData()` - calls `/api/admin/data`
  - `getUserData()` - calls `/api/user/data`
- [done] Handle edge cases:
  - Token expiration during app usage
  - Network connectivity issues
  - Keycloak server unavailability

#### Step 3.5: User Experience Enhancements
- [done] Add role-based conditional rendering throughout the app
- [done] Implement automatic redirection after login based on user role
- [done] Create a "unauthorized access" page for 403 errors
- [done] Add loading spinners for API calls
- [done] Implement proper error messaging with user-friendly text
- [done] Add logout confirmation dialog
- [] Implement toast notifications for:
  - Login success/failure
  - API errors (403 Forbidden, 401 Unauthorized)
  - Network errors
  - Token refresh failures

## Phase 4: Alternative TypeScript Backend

#### Step 4.1: TypeScript/Express Project Setup
- [done] Create `server-ts` directory with TypeScript/Express project
- [done] Initialize with dependencies:
  - `express`, `typescript`, `@types/node`, `@types/express`
  - `jsonwebtoken`, `jwks-rsa` - JWT validation with Keycloak
  - `cors`, `helmet` - Security middleware
  - `express-rate-limit` - Rate limiting
  - `dotenv` - Environment configuration
  - `winston` - Logging
- [done] Configure TypeScript build setup with `tsconfig.json`
- [done] Set up development scripts with `nodemon` and `ts-node`
- [done] Configure environment variables for Keycloak integration

#### Step 4.2: Security & Middleware Configuration
- [done] Implement JWT validation middleware using Keycloak's JWKS endpoint
- [done] Create role-based authorization middleware (`requireRole('admin')`, `requireRole('user')`)
- [done] Configure CORS for React frontend (`http://localhost:3000`)
- [done] Set up security headers with Helmet
- [done] Implement rate limiting for API endpoints
- [done] Add request logging middleware with Winston
- [done] Create centralized error handling middleware for consistent API responses
- [done] Set up automatic promise rejection handling (Express 5.x feature)

#### Step 4.3: API Endpoints Implementation
- [done] Create identical endpoint structure to Java backend:
  - `GET /api/public/info` - Public endpoint (no auth required)
  - `GET /api/user/data` - User role required
  - `GET /api/admin/data` - Admin role required
- [done] Implement same response format as Java backend for compatibility
- [done] Add proper error responses (401, 403, 500) with consistent format
- [done] Include request validation and sanitization

### TODO
### Improvements for Typescript and Java Servers
## Critical Security Improvements

### TypeScript Express
優先度高
1. **Token blacklisting/revocation** - if users can logout. Without this, logged-out tokens remain valid until expiration
優先度中
2. **Input validation middleware** - to prevent injection attacks

### Java Spring Boot
優先度中
1. **Request size limits** - for production. Prevents simple DoS attacks

## Nice to Have (But Not Urgent)
### Both Platforms
- **JWKS retry logic** - Keycloak is usually stable, this is more about resilience
- **Enhanced logging** - Good for debugging, not security-critical
- **Security headers** - HTTPS + CORS usually covers most needs
- **IP blocking** - Rate limiting handles most abuse cases
- **Rate limiting** - Your API is vulnerable to abuse without it in some cases

## Probably Overkill for Most Apps

### Low Priority Items
- Request/response encryption beyond HTTPS
- Geolocation controls
- API versioning for security (unless you're planning breaking changes)
- Token caching (performance optimization, not security)

### Must
- Implement rate limiting and request size limits.

### Considerations to adjust in Server-TS
- Memory-only storage: This works for single-instance deployments but won't scale across multiple server instances. Consider Redis for production.

- Race condition potential: The cleanup function could theoretically have race conditions with concurrent revocations, though unlikely in practice.

- No token validation in revoke: Might want to validate that the token being revoked actually belongs to the requesting user.