package com.keycloakdemo.server.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.Arrays;
import java.util.Collection;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity(prePostEnabled = true)
public class SecurityConfig {
    private static final long CORS_MAX_AGE = 3600L; // 1 hour

    @Value("${keycloak.client-name}")
    private String clientName;

    @Value("${cors.allowed-origins}")
    private String[] allowedOrigins;


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
                .anyRequest().authenticated()
            )
            .oauth2ResourceServer(oauth2 -> oauth2
                .jwt(jwt -> jwt.jwtAuthenticationConverter(jwtAuthenticationConverter()))
            );
        
        return http.build();
    }

    /**
     * Keycloak JWTトークンからロールを抽出するためのカスタムJWT認証コンバータ。
     *   JWTからKeycloakロールを抽出し、それをSpring Securityの権限(SimpleGrantedAuthority)にマッピングする:
        1. レルムロール: "realm_access"クレームから抽出される。これはKeycloakのグローバルロール。
        2. クライアントロール: "resource_access"クレームから"react-client"（または他のクライアント）に対して抽出される。これは特定のクライアント/アプリケーションに割り当てられたユーザーロール。
        3. 型の安全性: JWTが不正または誤設定されている場合にClassCastExceptionを回避するために型をチェックする。
        4. すべてのロールは、Spring Securityのロールベースのアクセス制御で必要とされる"ROLE_"プレフィックスを付けてSimpleGrantedAuthorityにマッピングされる。
        5. 最終的にマッピングされた権限は、リストとして返される。
     *
     * @return ロールを抽出するように設定されたJwtAuthenticationConverter
     */
    @Bean
    public JwtAuthenticationConverter jwtAuthenticationConverter() {
        JwtAuthenticationConverter converter = new JwtAuthenticationConverter();
        converter.setJwtGrantedAuthoritiesConverter(jwt -> {
            Set<SimpleGrantedAuthority> authorities = new HashSet<>();
            // Add realm roles
            Map<String, Object> realmAccess = jwt.getClaimAsMap("realm_access");
            if (realmAccess != null)
                validateAndAddRoles(realmAccess.get("roles"), authorities);
            // Add client/resource roles (if any are assigned to the react-client)
            Map<String, Object> resourceAccess = jwt.getClaimAsMap("resource_access");
            if (resourceAccess != null) {
                Object clientAccessObj = resourceAccess.get(clientName);
                if (clientAccessObj instanceof Map) {
                    Map<?, ?> clientAccess = (Map<?, ?>) clientAccessObj;
                    validateAndAddRoles(clientAccess.get("roles"), authorities);
                }
            }

            return authorities.stream().collect(Collectors.toList());
        });

        return converter;
    }

    /**
     * JWTクレームからロールを検証し、Spring Securityの権限に変換する。
     * 
     * @param roles JWTクレームから取得したロール（Stringのコレクションである必要がある）
     * @param authorities 検証済みの権限を追加するためのセット
     */
    private void validateAndAddRoles(Object roles, Set<SimpleGrantedAuthority> authorities) {
        if (!(roles instanceof Collection)) return;

        Collection<?> roleCollection = (Collection<?>) roles;
        roleCollection.stream()
            .filter(role -> role instanceof String)
            .map(role -> new SimpleGrantedAuthority("ROLE_" + role))
            .forEach(simpleGrantedAuthority -> authorities.add(simpleGrantedAuthority));
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(Arrays.asList(allowedOrigins));
        configuration.setAllowedMethods(Arrays.asList("GET", "POST", "PUT", "PATCH","DELETE", "OPTIONS"));
         configuration.setAllowedHeaders(Arrays.asList(
        "Authorization", 
        "Content-Type", 
        "Accept", 
        "Origin", 
        "X-Requested-With",
        "Cache-Control"
    ));
        configuration.setExposedHeaders(Arrays.asList(
        "Authorization",
        "Content-Disposition"
    ));
        configuration.setAllowCredentials(true);
        // CORSプリフライトレスポンスをキャッシュすることでパフォーマンスを向上させる
        configuration.setMaxAge(CORS_MAX_AGE);
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);

        return source;
    }
}
