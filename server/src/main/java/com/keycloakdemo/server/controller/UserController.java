package com.keycloakdemo.server.controller;

import com.keycloakdemo.server.service.TokenBlacklistService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/user")
public class UserController {
    
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);
    private final TokenBlacklistService tokenBlacklistService;
    
    public UserController(TokenBlacklistService tokenBlacklistService) {
        this.tokenBlacklistService = tokenBlacklistService;
    }

    @GetMapping("/data")
    @PreAuthorize("hasAnyRole('user', 'admin')")
    public Map<String, Object> getUserData(Authentication authentication) {
        Jwt jwt = getJwtFromAuthentication(authentication);
        
        String userId = jwt.getClaimAsString("sub");
        String username = jwt.getClaimAsString("preferred_username");
        String email = jwt.getClaimAsString("email");
        List<String> roles = extractRoles(jwt);
        
        logger.info("User data endpoint accessed - userId: {}, username: {}", userId, username);
        
        Map<String, Object> response = new HashMap<>();
        response.put("message", "This is user specific data");
        response.put("timestamp", Instant.now().toString());
        response.put("user", Map.of(
            "id", userId != null ? userId : "",
            "username", username != null ? username : "",
            "email", email != null ? email : "",
            "roles", roles
        ));
        
        return response;
    }

    @GetMapping("/profile")
    @PreAuthorize("hasAnyRole('user', 'admin')")
    public Map<String, Object> getUserProfile(Authentication authentication) {
        Jwt jwt = getJwtFromAuthentication(authentication);
        
        String userId = jwt.getClaimAsString("sub");
        String username = jwt.getClaimAsString("preferred_username");
        
        logger.info("User profile endpoint accessed - userId: {}, username: {}, email: {}", userId, username);
        
        Map<String, Object> response = new HashMap<>();
        response.put("message", "This is a user profile");
        response.put("timestamp", Instant.now().toString());
        response.put("data", Map.of(
            "userDashboard", "Welcome to your user dashboard",
            "features", List.of(
                "View personal profile",
                "Access user-specific content", 
                "Manage account settings"
            ),
            "lastLogin", "10 minutes ago",
            "permissions", List.of("read:profile", "update:profile")
        ));
        
        return response;
    }
    
    @PostMapping("/logout")
    @PreAuthorize("hasAnyRole('user', 'admin')")
    public ResponseEntity<Map<String, Object>> logout(Authentication authentication) {
        try {
            Jwt jwt = getJwtFromAuthentication(authentication);
            
            String jwtId = jwt.getClaimAsString("jti");
            Long expiresAt = jwt.getClaimAsInstant("exp").getEpochSecond();
            String userId = jwt.getClaimAsString("sub");
            String username = jwt.getClaimAsString("preferred_username");
            
            if (jwtId != null && expiresAt != null) {
                tokenBlacklistService.revokeToken(jwtId, expiresAt);
                
                logger.info("User logged out successfully - userId: {}, username: {}, jwtId: {}...", 
                    userId, username, jwtId.substring(0, Math.min(8, jwtId.length())));
                
                Map<String, Object> response = new HashMap<>();
                response.put("message", "Logout successful");
                response.put("timestamp", Instant.now().toString());
                response.put("user", Map.of(
                    "id", userId != null ? userId : "",
                    "username", username != null ? username : ""
                ));
                
                return ResponseEntity.ok(response);
            } else {
                logger.warn("Token missing JWT ID or expiration, cannot revoke - userId: {}, hasJwtId: {}, hasExpiration: {}", 
                    userId, jwtId != null, expiresAt != null);
                
                Map<String, Object> response = new HashMap<>();
                response.put("message", "Logout processed (token could not be revoked)");
                response.put("timestamp", Instant.now().toString());
                response.put("warning", "Token revocation not available for this token type");
                
                return ResponseEntity.ok(response);
            }
        } catch (Exception error) {
            logger.error("Logout failed", error);
            
            Map<String, Object> response = new HashMap<>();
            response.put("error", "Logout failed");
            response.put("timestamp", Instant.now().toString());
            
            return ResponseEntity.status(500).body(response);
        }
    }
    
    /**
     * Extract JWT from Spring Security Authentication
     */
    private Jwt getJwtFromAuthentication(Authentication authentication) {
        if (authentication instanceof JwtAuthenticationToken) {
            return ((JwtAuthenticationToken) authentication).getToken();
        }
        throw new IllegalArgumentException("Authentication is not a JWT token");
    }
    
    /**
     * Extract roles from JWT claims for display purposes
     */
    private List<String> extractRoles(Jwt jwt) {
        List<String> roles = new java.util.ArrayList<>();
        
        // Extract realm roles
        Map<String, Object> realmAccess = jwt.getClaimAsMap("realm_access");
        if (realmAccess != null && realmAccess.get("roles") instanceof List) {
            @SuppressWarnings("unchecked")
            List<String> realmRoles = (List<String>) realmAccess.get("roles");
            roles.addAll(realmRoles);
        }
        
        return roles;
    }
}
