package com.keycloakdemo.server.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * OAuth2認証の失敗を処理し、一般的な401応答の代わりに構造化されたJSONエラー応答を返すカスタム認証エントリポイント。
 */
@Component
public class CustomAuthenticationEntryPoint implements AuthenticationEntryPoint {

  private static final Logger logger = LoggerFactory.getLogger(CustomAuthenticationEntryPoint.class);
  private final ObjectMapper objectMapper = new ObjectMapper();

  @Override
  public void commence(HttpServletRequest request, HttpServletResponse response,
      AuthenticationException authException) throws IOException, ServletException {

    logger.debug("Authentication failed: {}", authException.getMessage());

    response.setContentType(MediaType.APPLICATION_JSON_VALUE);
    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);

    Map<String, Object> errorResponse = new HashMap<>();
    errorResponse.put("timestamp", System.currentTimeMillis());

    // Handle specific OAuth2 authentication exceptions (like revoked tokens)
    if (authException instanceof OAuth2AuthenticationException oauth2Exception) {
      handleOAuth2Exception(oauth2Exception, errorResponse);
    } else {
      handleGenericAuthenticationException(errorResponse);
    }

    objectMapper.writeValue(response.getOutputStream(), errorResponse);
  }

  // Helper method for OAuth2 exceptions
private void handleOAuth2Exception(OAuth2AuthenticationException oauth2Exception, Map<String, Object> errorResponse) {
   String errorCode = oauth2Exception.getError().getErrorCode();
   String description = oauth2Exception.getError().getDescription();

   errorResponse.put("error", "Token Authentication Failed");

  if ("token_revoked".equals(errorCode)) {
    errorResponse.put("message", description != null ? description : "Token has been revoked. Please log in again.");
   } else {
    errorResponse.put("message", description != null ? description : "Invalid authentication token");
  }
}

// Helper method for generic authentication exceptions
private void handleGenericAuthenticationException(Map<String, Object> errorResponse) {
    errorResponse.put("error", "Authentication Failed");
    errorResponse.put("message", "Invalid or missing authentication token");
 }
  
}