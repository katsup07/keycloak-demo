package com.keycloakdemo.server.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/public")
public class PublicController {

    @GetMapping("/info")
    public Map<String, Object> getPublicInfo() {
        Map<String, Object> response = new HashMap<>();
        response.put("message", "This is public information - no authentication required");
        response.put("timestamp", System.currentTimeMillis());
        response.put("version", "1.0.0");
        response.put("status", "online");
        response.put("endpoints", Map.of(
            "public", "/api/public/*",
            "user", "/api/user/* (requires user or admin role)",
            "admin", "/api/admin/* (requires admin role)"
        ));
        
        return response;
    }
}
