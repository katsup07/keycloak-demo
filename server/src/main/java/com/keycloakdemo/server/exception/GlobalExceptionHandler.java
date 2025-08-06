package com.keycloakdemo.server.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.HashMap;
import java.util.Map;

@RestControllerAdvice
public class GlobalExceptionHandler {

  @ExceptionHandler(OAuth2AuthenticationException.class)
  public ResponseEntity<Map<String, Object>> handleOAuth2AuthenticationException(OAuth2AuthenticationException ex) {
    Map<String, Object> error = new HashMap<>();
    error.put("error", "Token Authentication Failed");

    // Provide specific message for revoked tokens
    if ("token_revoked".equals(ex.getError().getErrorCode())) {
      error.put("message", "Token has been revoked. Please log in again.");
    } else {
      error.put("message",
          ex.getError().getDescription() != null ? ex.getError().getDescription() : "Invalid authentication token");
    }

    error.put("timestamp", System.currentTimeMillis());
    return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(error);
  }

  @ExceptionHandler(AuthenticationException.class)
  public ResponseEntity<Map<String, Object>> handleAuthenticationException(AuthenticationException ex) {
    Map<String, Object> error = new HashMap<>();
    error.put("error", "Authentication Failed");
    error.put("message", "Invalid or missing authentication token");
    error.put("timestamp", System.currentTimeMillis());
    return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(error);
  }

  @ExceptionHandler(AccessDeniedException.class)
  public ResponseEntity<Map<String, Object>> handleAccessDeniedException(AccessDeniedException ex) {
    Map<String, Object> error = new HashMap<>();
    error.put("error", "Access Denied");
    error.put("message", "You don't have sufficient permissions to access this resource");
    error.put("timestamp", System.currentTimeMillis());
    return ResponseEntity.status(HttpStatus.FORBIDDEN).body(error);
  }

  @ExceptionHandler(AuthenticationCredentialsNotFoundException.class)
  public ResponseEntity<Map<String, Object>> handleAuthenticationCredentialsNotFoundException(
      AuthenticationCredentialsNotFoundException ex) {
    Map<String, Object> error = new HashMap<>();
    error.put("error", "Authentication Required");
    error.put("message", "Authentication credentials are required to access this resource");
    error.put("timestamp", System.currentTimeMillis());
    return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(error);
  }

  @ExceptionHandler(Exception.class)
  public ResponseEntity<Map<String, Object>> handleGenericException(Exception ex) {
    Map<String, Object> error = new HashMap<>();
    error.put("error", "Internal Server Error");
    error.put("message", "An unexpected error occurred");
    error.put("timestamp", System.currentTimeMillis());
    return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(error);
  }
}
