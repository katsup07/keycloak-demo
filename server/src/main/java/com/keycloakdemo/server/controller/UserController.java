package com.keycloakdemo.server.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/user")
public class UserController {

    @GetMapping("/data")
    @PreAuthorize("hasAnyRole('user', 'admin')")
    public Map<String, Object> getUserData(Principal principal) {
        Map<String, Object> response = new HashMap<>();
        response.put("message", "This is user data");
        response.put("user", principal.getName());
        response.put("timestamp", System.currentTimeMillis());
        response.put("data", Map.of(
            "profile", Map.of(
                "name", principal.getName(),
                "lastLogin", "2025-07-24T09:15:00Z"
            ),
            "preferences", Map.of(
                "theme", "light",
                "notifications", true
            )
        ));
        return response;
    }

    @GetMapping("/profile")
    @PreAuthorize("hasAnyRole('user', 'admin')")
    public Map<String, Object> getUserProfile(Principal principal) {
        Map<String, Object> response = new HashMap<>();
        response.put("message", "This is user profile data");
        response.put("user", principal.getName());
        response.put("profile", Map.of(
            "name", principal.getName(),
            "email", principal.getName() + "@example.com",
            "roles", "user"
        ));
        
        return response;
      }
    }
