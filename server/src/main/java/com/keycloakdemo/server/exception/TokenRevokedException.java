package com.keycloakdemo.server.exception;

import org.springframework.security.core.AuthenticationException;

/**
 * Exception thrown when a revoked JWT token is used for authentication
 */
public class TokenRevokedException extends AuthenticationException {

  private final String jwtId;
  private final String userId;

  public TokenRevokedException(String message, String jwtId, String userId) {
    super(message);
    this.jwtId = jwtId;
    this.userId = userId;
  }

  public String getJwtId() {
    return jwtId;
  }

  public String getUserId() {
    return userId;
  }
}