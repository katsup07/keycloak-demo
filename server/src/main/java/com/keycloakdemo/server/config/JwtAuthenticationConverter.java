package com.keycloakdemo.server.config;

import com.keycloakdemo.server.service.TokenBlacklistService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.convert.converter.Converter;
import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.OAuth2Error;
import org.springframework.security.oauth2.jwt.Jwt;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.stereotype.Component;

import java.util.Collection;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * Custom JWT authentication converter that extracts Keycloak roles and checks
 * token blacklist
 */
@Component
public class JwtAuthenticationConverter implements Converter<Jwt, AbstractAuthenticationToken> {

  private static final Logger logger = LoggerFactory.getLogger(JwtAuthenticationConverter.class);
  private final TokenBlacklistService tokenBlacklistService;
  private final String clientId;

  public JwtAuthenticationConverter(TokenBlacklistService tokenBlacklistService,
      @Value("${keycloak.client-id}") String clientId) {
    this.tokenBlacklistService = tokenBlacklistService;
    this.clientId = clientId;
  }

  @Override
  public AbstractAuthenticationToken convert(Jwt jwt) {
    // Check if token is blacklisted
    String jwtId = jwt.getClaimAsString("jti");
    if (jwtId != null && tokenBlacklistService.isTokenRevoked(jwtId)) {
      String subject = jwt.getClaimAsString("sub");
      logger.warn("Attempted to use revoked token - jwtId: {}..., userId: {}",
          jwtId.substring(0, Math.min(8, jwtId.length())), subject);

      // Throw proper OAuth2 authentication exception instead of returning null
      OAuth2Error error = new OAuth2Error("token_revoked", "Token has been revoked", null);
      throw new OAuth2AuthenticationException(error);
    }

    // Extract authorities from JWT claims
    Collection<SimpleGrantedAuthority> authorities = extractAuthorities(jwt);

    return new JwtAuthenticationToken(jwt, authorities);
  }

  /**
   * Keycloak JWTトークンからロールを抽出するためのカスタムJWT認証コンバータ。
   * JWTからKeycloakロールを抽出し、それをSpring Securityの権限(SimpleGrantedAuthority)にマッピングする:
   * 1. レルムロール: "realm_access"クレームから抽出される。これはKeycloakのグローバルロール。
   * 2. クライアントロール:
   * "resource_access"クレームから"react-client"（または他のクライアント）に対して抽出される。これは特定のクライアント/アプリケーションに割り当てられたユーザーロール。
   * 3. 型の安全性: JWTが不正または誤設定されている場合にClassCastExceptionを回避するために型をチェックする。
   * 4. すべてのロールは、Spring
   * Securityのロールベースのアクセス制御で必要とされる"ROLE_"プレフィックスを付けてSimpleGrantedAuthorityにマッピングされる。
   * 5. 最終的にマッピングされた権限は、リストとして返される。
   *
   * @return Collection of SimpleGrantedAuthority objects representing the roles
   *         extracted from the JWT claims
   */
  private Collection<SimpleGrantedAuthority> extractAuthorities(Jwt jwt) {
    Set<SimpleGrantedAuthority> authorities = new HashSet<>();

    // Add realm roles
    Map<String, Object> realmAccess = jwt.getClaimAsMap("realm_access");
    if (realmAccess != null) {
      validateAndAddRoles(realmAccess.get("roles"), authorities);
    }

    // Add client/resource roles
    Map<String, Object> resourceAccess = jwt.getClaimAsMap("resource_access");
    if (resourceAccess != null) {
      Object clientAccessObj = resourceAccess.get(clientId);
      if (clientAccessObj instanceof Map) {
        Map<?, ?> clientAccess = (Map<?, ?>) clientAccessObj;
        validateAndAddRoles(clientAccess.get("roles"), authorities);
      }
    }

    return authorities.stream().collect(Collectors.toList());
  }

  /**
   * Validate and add roles from JWT claims to authorities
   */
  private void validateAndAddRoles(Object roles, Set<SimpleGrantedAuthority> authorities) {
    if (!(roles instanceof Collection))
      return;

    Collection<?> roleCollection = (Collection<?>) roles;
    roleCollection.stream()
        .filter(role -> role instanceof String)
        .map(role -> new SimpleGrantedAuthority("ROLE_" + role))
        .forEach(simpleGrantedAuthority -> authorities.add(simpleGrantedAuthority));
  }
}