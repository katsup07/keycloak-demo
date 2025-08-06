package com.keycloakdemo.server.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.keycloakdemo.server.service.TokenBlacklistService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.JwtException;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.time.Instant;
import java.util.HashMap;
import java.util.Map;

/**
 * Filter to check if JWT tokens are revoked before processing authentication
 */
@Component
public class TokenRevocationFilter extends OncePerRequestFilter {

  private static final Logger logger = LoggerFactory.getLogger(TokenRevocationFilter.class);

  private final TokenBlacklistService tokenBlacklistService;
  private final JwtDecoder jwtDecoder;
  private final ObjectMapper objectMapper = new ObjectMapper();

  public TokenRevocationFilter(TokenBlacklistService tokenBlacklistService, JwtDecoder jwtDecoder) {
    this.tokenBlacklistService = tokenBlacklistService;
    this.jwtDecoder = jwtDecoder;
  }

  @Override
  protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
      FilterChain filterChain) throws ServletException, IOException {

    // Skip public endpoints
    String requestPath = request.getRequestURI();
    if (requestPath.startsWith("/api/public/")) {
      filterChain.doFilter(request, response);
      return;
    }

    String authHeader = request.getHeader("Authorization");
    if (authHeader != null && authHeader.startsWith("Bearer ")) {
      String token = authHeader.substring(7);

      try {
        Jwt jwt = jwtDecoder.decode(token);
        String jwtId = jwt.getClaimAsString("jti");

        if (jwtId != null && tokenBlacklistService.isTokenRevoked(jwtId)) {
          String subject = jwt.getClaimAsString("sub");

          logger.warn("Revoked token used - jwtId: {}..., userId: {}, path: {}",
              jwtId.substring(0, Math.min(8, jwtId.length())), subject, requestPath);

          sendRevokedTokenError(response, request);
          return;
        }
      } catch (JwtException e) {
        // Let Spring Security handle invalid JWT tokens
        logger.debug("JWT decode failed, letting Spring Security handle: {}", e.getMessage());
      }
    }

    filterChain.doFilter(request, response);
  }

  private void sendRevokedTokenError(HttpServletResponse response, HttpServletRequest request) throws IOException {
    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
    response.setContentType(MediaType.APPLICATION_JSON_VALUE);

    Map<String, Object> errorResponse = new HashMap<>();
    errorResponse.put("timestamp", Instant.now().toString());
    errorResponse.put("path", request.getRequestURI());
    errorResponse.put("method", request.getMethod());
    errorResponse.put("error", "Token Revoked");
    errorResponse.put("message", "The provided token has been revoked and is no longer valid");
    errorResponse.put("code", "TOKEN_REVOKED");
    errorResponse.put("details", Map.of(
        "reason", "Token was explicitly revoked (likely due to logout)",
        "action", "Please obtain a new token by logging in again"));

    response.getWriter().write(objectMapper.writeValueAsString(errorResponse));
  }
}