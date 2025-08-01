package com.keycloakdemo.server.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/admin")
public class AdminController {

    @GetMapping("/data")
    @PreAuthorize("hasRole('admin')")
    public Map<String, Object> getAdminData(Principal principal) {
        Map<String, Object> response = new HashMap<>();
        response.put("message", "This is admin-only data");
        response.put("user", principal.getName());
        response.put("timestamp", System.currentTimeMillis());
        response.put("data", Map.of(
            "totalUsers", 150,
            "systemHealth", "Good",
            "lastBackup", "2025-07-24T10:30:00Z"
        ));
        
        return response;
    }
}
