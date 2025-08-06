# JWT Token Blacklisting Implementation

This Spring Boot server now includes a comprehensive JWT token blacklisting/revocation system similar to the TypeScript server implementation.

## Components

### 1. TokenBlacklistService
- **Location**: `src/main/java/com/keycloakdemo/server/service/TokenBlacklistService.java`
- **Purpose**: Manages revoked JWT tokens in memory with automatic cleanup
- **Features**:
  - In-memory storage using `ConcurrentHashMap` for thread safety
  - Automatic cleanup of expired tokens every 5 minutes
  - Time drift buffer (5 minutes) to handle clock skew
  - Statistics tracking and management methods

### 2. Custom JwtAuthenticationConverter
- **Location**: `src/main/java/com/keycloakdemo/server/config/JwtAuthenticationConverter.java`
- **Purpose**: Extends JWT authentication to check token blacklist
- **Features**:
  - Extracts Keycloak roles (realm and client roles)
  - Checks if token is blacklisted before authentication
  - Returns null for revoked tokens (causes authentication failure)

### 3. Updated Controllers

#### UserController
- **New endpoint**: `POST /api/user/logout`
  - Revokes the current JWT token
  - Extracts JWT ID and expiration from token
  - Adds token to blacklist
  - Returns logout confirmation

#### AdminController  
- **New endpoint**: `GET /api/admin/blacklist/stats`
  - Returns blacklist statistics (admin only)
- **New endpoint**: `POST /api/admin/blacklist/clear`
  - Clears all blacklisted tokens (admin only)

## API Endpoints

### User Endpoints
```http
POST /api/user/logout
Authorization: Bearer <jwt_token>
```

Response:
```json
{
  "message": "Logout successful",
  "timestamp": "2025-01-08T10:30:00Z",
  "user": {
    "id": "user-uuid",
    "username": "john.doe"
  }
}
```

### Admin Endpoints
```http
GET /api/admin/blacklist/stats
Authorization: Bearer <admin_jwt_token>
```

Response:
```json
{
  "message": "Token blacklist statistics",
  "timestamp": "2025-01-08T10:30:00Z",
  "stats": {
    "totalBlacklistedTokens": 5,
    "cleanupIntervalMs": 300000
  }
}
```

```http
POST /api/admin/blacklist/clear
Authorization: Bearer <admin_jwt_token>
```

## How It Works

1. **Token Revocation**: When a user logs out, their JWT ID (`jti` claim) and expiration time (`exp` claim) are stored in the blacklist.

2. **Authentication Check**: Every incoming request with a JWT token is checked against the blacklist before authentication proceeds.

3. **Automatic Cleanup**: A scheduled task runs every 5 minutes to remove expired tokens from the blacklist, preventing memory leaks.

4. **Thread Safety**: Uses `ConcurrentHashMap` to ensure thread-safe operations in a multi-threaded environment.

## Configuration

The implementation requires:
- `@EnableScheduling` annotation on the main application class
- Keycloak client ID configured in `application.properties`
- JWT tokens must include `jti` (JWT ID) and `exp` (expiration) claims

## Security Considerations

- Tokens are stored in memory only (not persisted)
- Blacklist is cleared on application restart
- Time drift buffer prevents issues with clock synchronization
- Admin-only endpoints for blacklist management
- Comprehensive logging for security auditing

## Comparison with TypeScript Implementation

This Java implementation mirrors the TypeScript server's functionality:
- ✅ In-memory token storage
- ✅ Automatic cleanup of expired tokens  
- ✅ JWT ID-based revocation
- ✅ Time drift buffer handling
- ✅ Statistics and management endpoints
- ✅ Comprehensive logging
- ✅ Thread-safe operations