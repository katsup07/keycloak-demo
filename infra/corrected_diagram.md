```plaintext
+----------------+       +----------------+       +----------------+       +----------------+
|   React App   |       | Spring Boot    |       |   Keycloak     |       |   PostgreSQL    |
| (OAuth Client)|       | (Resource      |       | (Auth Server)  |       | (Keycloak DB)   |
|                |       | Server)        |       |                |       |                |
+----------------+       +----------------+       +----------------+       +----------------+
        |                        |                        |                        |
        |------------------------|                        |------------------------|
                 Direct API Calls                          Direct DB Interaction

Explanation:
- React App interacts directly with Keycloak for authentication and token management.
- React App interacts with Spring Boot for API calls, attaching Keycloak-issued tokens.
- Spring Boot interacts with its own database (if configured) for application-specific data.
- Keycloak interacts directly with its own database (PostgreSQL) to manage realms, users, roles, etc.
```
