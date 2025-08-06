package com.keycloakdemo.server.controller;

import com.keycloakdemo.server.service.TokenBlacklistService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import java.util.Map;

@RestController
@RequestMapping("/api/admin")
public class AdminController {
    
    private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
    
    private final TokenBlacklistService tokenBlacklistService;
    
    public AdminController(TokenBlacklistService tokenBlacklistService) {
        this.tokenBlacklistService = tokenBlacklistService;
    }

    @GetMapping("/data")
    @PreAuthorize("hasRole('admin')")
    public Map<String, Object> getAdminData(Authentication authentication) {
        Jwt jwt = getJwtFromAuthentication(authentication);
        String username = jwt.getClaimAsString("preferred_username");
        
        logger.info("Admin data endpoint accessed by: {}", username);
        
        // Get blacklist statistics
        TokenBlacklistService.BlacklistStats blacklistStats = tokenBlacklistService.getBlacklistStats();
        
        Map<String, Object> response = new HashMap<>();
        response.put("message", "This is admin-only data");
        response.put("user", username);
        response.put("timestamp", Instant.now().toString());
        response.put("data", Map.of(
            "totalUsers", 160,
            "systemHealth", "Good",
            "lastBackup", "2025-07-24T10:30:00Z",
            "tokenBlacklist", Map.of(
                "totalBlacklistedTokens", blacklistStats.getTotalBlacklistedTokens(),
                "cleanupIntervalMs", blacklistStats.getCleanupIntervalMs()
            )
        ));
        
        return response;
    }
    
    @GetMapping("/blacklist/stats")
    @PreAuthorize("hasRole('admin')")
    public Map<String, Object> getBlacklistStats(Authentication authentication) {
        Jwt jwt = getJwtFromAuthentication(authentication);
        String username = jwt.getClaimAsString("preferred_username");
        
        logger.info("Blacklist stats requested by admin: {}", username);
        
        TokenBlacklistService.BlacklistStats stats = tokenBlacklistService.getBlacklistStats();
        
        Map<String, Object> response = new HashMap<>();
        response.put("message", "Token blacklist statistics");
        response.put("timestamp", Instant.now().toString());
        response.put("stats", Map.of(
            "totalBlacklistedTokens", stats.getTotalBlacklistedTokens(),
            "cleanupIntervalMs", stats.getCleanupIntervalMs()
        ));
        
        return response;
    }
    
    @PostMapping("/blacklist/clear")
    @PreAuthorize("hasRole('admin')")
    public Map<String, Object> clearBlacklist(Authentication authentication) {
        Jwt jwt = getJwtFromAuthentication(authentication);
        String username = jwt.getClaimAsString("preferred_username");
        
        logger.warn("Blacklist cleared by admin: {}", username);
        
        tokenBlacklistService.clearBlacklist();
        
        Map<String, Object> response = new HashMap<>();
        response.put("message", "Token blacklist cleared successfully");
        response.put("timestamp", Instant.now().toString());
        response.put("clearedBy", username);
        
        return response;
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
}
