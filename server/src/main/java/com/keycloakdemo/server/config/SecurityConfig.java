package com.keycloakdemo.server.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity(prePostEnabled = true)
public class SecurityConfig {
  private static final long CORS_MAX_AGE = 3600L; // 1 hour

  @Value("${cors.allowed-origins}")
  private String[] allowedOrigins;

  private final JwtAuthenticationConverter jwtAuthenticationConverter;
  private final AuthenticationEntryPoint customAuthenticationEntryPoint;

  public SecurityConfig(JwtAuthenticationConverter jwtAuthenticationConverter,
      AuthenticationEntryPoint customAuthenticationEntryPoint) {
    this.jwtAuthenticationConverter = jwtAuthenticationConverter;
    this.customAuthenticationEntryPoint = customAuthenticationEntryPoint;
  }

  // CSRFは、ステートレスセッション（クッキーなし）とトークンベースの認証を使用しているため、保護が不要
  @Bean
  public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
    http
        .cors(cors -> cors.configurationSource(corsConfigurationSource()))
        .csrf(csrf -> csrf.disable())
        .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
        .authorizeHttpRequests(authz -> authz
            .requestMatchers("/api/public/**").permitAll()
            .requestMatchers("/api/admin/**").hasRole("admin")
            .requestMatchers("/api/user/**").hasAnyRole("user", "admin")
            .anyRequest().authenticated())
        .oauth2ResourceServer(oauth2 -> oauth2
            .jwt(jwt -> jwt.jwtAuthenticationConverter(jwtAuthenticationConverter))
            .authenticationEntryPoint(customAuthenticationEntryPoint));

    return http.build();
  }

  @Bean
  public CorsConfigurationSource corsConfigurationSource() {
    CorsConfiguration configuration = new CorsConfiguration();
    configuration.setAllowedOrigins(Arrays.asList(allowedOrigins));
    configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"));
    configuration.setAllowedHeaders(Arrays.asList(
        "Authorization",
        "Content-Type",
        "Accept",
        "Origin",
        "X-Requested-With",
        "Cache-Control"));
    configuration.setExposedHeaders(Arrays.asList(
        "Authorization",
        "Content-Disposition"));
    configuration.setAllowCredentials(true);
    // CORSプリフライトレスポンスをキャッシュすることでパフォーマンスを向上させる
    configuration.setMaxAge(CORS_MAX_AGE);
    UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
    source.registerCorsConfiguration("/**", configuration);

    return source;
  }
}
