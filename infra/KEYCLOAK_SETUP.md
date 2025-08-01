# Keycloak Setup Guide

This guide will help you set up Keycloak for the demo application.

## Prerequisites

1. Docker and Docker Compose installed
2. Node.js and npm/yarn installed

## Keycloak Setup Steps

### 1. Start Keycloak

From the project root directory:

```bash
docker-compose up -d
```

This will start Keycloak on `http://localhost:8080` and PostgreSQL on port 5432.

### 2. Access Keycloak Admin Console

1. Open `http://localhost:8080` in your browser
2. Click on "Administration Console"
3. Login with:
   - Username: `admin`
   - Password: `admin`

### 3. Create a Realm

1. In the admin console, hover over "Master" in the top-left corner
2. Click "Create Realm"
3. Set the realm name to `keycloak-demo`
4. Click "Create"

### 4. Create a Client

1. In the `keycloak-demo` realm, go to "Clients" in the left sidebar
2. Click "Create client"
3. Set the following:
   - Client type: `OpenID Connect`
   - Client ID: `keycloak-demo-client`
   - Name: `Keycloak Demo Client`
4. Click "Next"
5. Configure capability config:
   - Client authentication: `Off` (public client for Frontend -> off. Private (confidential) for Backend -> on)
   - Authorization: `Off`
   - Standard flow: `On`
   - Direct access grants: `off`
   - Implicit flow: `Off`
   - Service accounts roles: `Off`
6. Click "Next"
7. Set Valid redirect URIs:
   - `http://localhost:3000/*`
   - `http://localhost:3000/silent-check-sso.html`
8. Set Valid post logout redirect URIs:
   - `http://localhost:3000/*`
9. Set Web origins:
   - `http://localhost:3000`
10. Click "Save"

### 4.1. Configure Client Settings (Important for CSP)

After creating the client, you need to configure additional settings:

1. Go to the client settings
2. Scroll down to "Advanced Settings"
3. Find "Web Origins" and ensure it includes:
   - `http://localhost:3000`

### 5. Create Roles

1. Go to "Realm roles" in the left sidebar
2. Create the following roles:
   - Click "Create role"
   - Role name: `admin`
   - Description: `Administrator role`
   - Click "Save"
   - Repeat for `user` role

### 6. Create Users

#### Admin User:
1. Go to "Users" in the left sidebar
2. Click "Create new user"
3. Set:
   - Username: `admin`
   - Email: `admin@example.com`
   - First name: `Admin`
   - Last name: `User`
   - Email verified: `On`
   - Enabled: `On`
4. Click "Create"
5. Go to the "Credentials" tab
6. Click "Set password"
7. Set password to `admin`
8. Set "Temporary": `Off`
9. Click "Save"
10. Go to "Role mapping" tab
11. Click "Assign role"
12. Select both `admin` and `user` roles
13. Click "Assign"

#### Regular User:
1. Create another user with:
   - Username: `user`
   - Email: `user@example.com`
   - First name: `Regular`
   - Last name: `User`
   - Password: `user`
2. Assign only the `user` role

### 7. Test the Setup

1. Start the client application:
   ```bash
   cd client
   npm install
   npm run dev
   ```

2. Open `http://localhost:3000` in your browser
3. Click "Login with Keycloak"
4. You should be redirected to Keycloak login page
5. Test with both users:
   - admin/admin (should have access to both user and admin dashboards)
   - user/user (should have access only to user dashboard)

## Troubleshooting

### Common Issues:

1. **CORS Errors**: Make sure Web origins is set to `http://localhost:3000` in the client configuration
2. **Redirect Errors**: Ensure all redirect URIs are properly configured
3. **Connection Refused**: Make sure Keycloak is running on port 8080
4. **Token Issues**: Check that the client is configured as a public client(Frontend only. Backend should be private(confidential))
5. **Content Security Policy (CSP) Errors**: 
   - If you see "Refused to frame" errors, this is due to Keycloak's CSP settings
   - The application is configured to work with iframe-based silent SSO checks, which may cause issues with certain flows
   - This is handled by setting `checkLoginIframe: false` in the Keycloak configuration in `client/src/services/keycloakService.ts`
6. **"Keycloak instance can only be initialized once" Error**:
   - This is handled by the initialization guards in the code
   - Should not occur in production builds, mainly affects development with React StrictMode

### Useful Commands:

```bash
# Check if containers are running
docker-compose ps

# View logs
docker-compose logs keycloak
docker-compose logs postgres

# Restart services
docker-compose restart

# Stop all services
docker-compose down
```

## Environment Variables

The client uses these environment variables (in `client/.env`):

```env
VITE_KEYCLOAK_URL=http://localhost:8080
VITE_KEYCLOAK_REALM=keycloak-demo
VITE_KEYCLOAK_CLIENT_ID=keycloak-demo-client
VITE_API_BASE_URL=http://localhost:8081/api
```

## Next Steps

- Configure the Spring Boot server to validate JWT tokens
- Set up additional roles and permissions
- Configure token lifetimes and refresh policies
- Set up production-ready configurations
