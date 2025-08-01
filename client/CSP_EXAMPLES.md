# Content Security Policy (CSP) Examples

## For Nginx
```nginx
server {
    # ... other config
    add_header Content-Security-Policy "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; connect-src 'self' http://localhost:8080 https://your-keycloak-domain; frame-src 'self' http://localhost:8080 https://your-keycloak-domain; img-src 'self' data:; font-src 'self';" always;
}
```

## For Apache
```apache
Header always set Content-Security-Policy "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; connect-src 'self' http://localhost:8080 https://your-keycloak-domain; frame-src 'self' http://localhost:8080 https://your-keycloak-domain; img-src 'self' data:; font-src 'self';"
```

## CSP Directives Explained

- `default-src 'self'`: Only allow resources from the same origin by default
- `script-src 'self' 'unsafe-inline'`: Allow scripts from same origin and inline scripts (needed for Vite development)
- `style-src 'self' 'unsafe-inline'`: Allow styles from same origin and inline styles (needed for CSS-in-JS)
- `connect-src 'self' http://localhost:8080 ws://localhost:3000`: Allow connections to same origin, Keycloak server, and Vite HMR
- `frame-src 'self' http://localhost:8080`: Allow frames from same origin and Keycloak (for silent SSO)
- `img-src 'self' data:`: Allow images from same origin and data URLs
- `font-src 'self'`: Allow fonts from same origin

## Production Considerations

For production, make these changes:
1. Replace `http://localhost:8080` with your actual Keycloak domain
2. Remove `ws://localhost:3000` (Vite HMR WebSocket)
3. Consider removing `'unsafe-inline'` and `'unsafe-eval'` by using nonces or hashes
4. Add your CDN domains if using external resources

## Testing CSP

Use browser developer tools to check for CSP violations:
1. Open DevTools → Console
2. Look for CSP violation messages
3. Adjust the policy based on legitimate violations
