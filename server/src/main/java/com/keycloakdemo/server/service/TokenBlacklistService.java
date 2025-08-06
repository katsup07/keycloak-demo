package com.keycloakdemo.server.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * JWTトークンのブラックリスト/無効化を管理するサービス。
 * 期限切れトークンの自動クリーンアップを備えたインメモリストレージを提供します。
 */
@Service
public class TokenBlacklistService {
    private static final long CLEANUP_INTERVAL_MS = 5 * 60 * 1000;
    private static final Logger logger = LoggerFactory.getLogger(TokenBlacklistService.class);
    
    // サーバー間の時計のずれ（5分間）を処理するための時間ドリフトバッファ（秒単位）
    private static final long TIME_DRIFT_BUFFER_SECONDS = 5 * 60;
    
    // ブラックリストに登録されたトークンのインメモリストレージ
    private final ConcurrentHashMap<String, BlacklistedToken> blacklistedTokens = new ConcurrentHashMap<>();
    
    /**
     * Represents a blacklisted JWT token
     */
    public static class BlacklistedToken {
        private final String jwtId;
        private final long expiresAt;
        private final long revokedAt;
        
        public BlacklistedToken(String jwtId, long expiresAt, long revokedAt) {
            this.jwtId = jwtId;
            this.expiresAt = expiresAt;
            this.revokedAt = revokedAt;
        }
        
        public String getJwtId() { return jwtId; }
        public long getExpiresAt() { return expiresAt; }
        public long getRevokedAt() { return revokedAt; }
    }
    
    /**
     * Statistics about the blacklist
     */
    public static class BlacklistStats {
        private final int totalBlacklistedTokens;
        private final long cleanupIntervalMs;
        
        public BlacklistStats(int totalBlacklistedTokens, long cleanupIntervalMs) {
            this.totalBlacklistedTokens = totalBlacklistedTokens;
            this.cleanupIntervalMs = cleanupIntervalMs;
        }
        
        public int getTotalBlacklistedTokens() { return totalBlacklistedTokens; }
        public long getCleanupIntervalMs() { return cleanupIntervalMs; }
    }
    
    /**
     * Revoke a JWT token by adding it to the blacklist
     * 
     * @param jwtId The JWT ID (jti claim)
     * @param expiresAt The token expiration time (exp claim) in seconds since epoch
     */
    public void revokeToken(String jwtId, long expiresAt) {
        if (jwtId == null || jwtId.trim().isEmpty()) {
            logger.warn("Attempted to revoke token without JWT ID");
            return;
        }
        
        BlacklistedToken blacklistedToken = new BlacklistedToken(
            jwtId, 
            expiresAt, 
            Instant.now().getEpochSecond()
        );
        
        blacklistedTokens.put(jwtId, blacklistedToken);
        
        logger.info("Token revoked - jwtId: {}..., expiresAt: {}", 
            jwtId.substring(0, Math.min(8, jwtId.length())), 
            Instant.ofEpochSecond(expiresAt));
    }
    
    /**
     * Check if a token is revoked (blacklisted)
     * 
     * @param jwtId The JWT ID to check
     * @return true if the token is revoked, false otherwise
     */
    public boolean isTokenRevoked(String jwtId) {
        if (jwtId == null || jwtId.trim().isEmpty()){
            logger.debug("isTokenRevoked called with null or empty jwtId");
            return false;
        }
        
        
        return blacklistedTokens.containsKey(jwtId);
    }
    
    /**
     * Get statistics about the blacklist
     * 
     * @return BlacklistStats containing current statistics
     */
    public BlacklistStats getBlacklistStats() {
        return new BlacklistStats(blacklistedTokens.size(), CLEANUP_INTERVAL_MS);
    }
    
    /**
     * Clear all tokens from the blacklist (primarily for testing)
     */
    public void clearBlacklist() {
        blacklistedTokens.clear();
        logger.info("Token blacklist cleared");
    }
    
    /**
     * Scheduled cleanup of expired tokens from the blacklist.
     * Runs every 5 minutes to remove tokens that have already expired.
     */
    @Scheduled(fixedRate = CLEANUP_INTERVAL_MS)
    public void cleanupExpiredTokens() {
        long currentTimeInSeconds = Instant.now().getEpochSecond();
        AtomicInteger removedCount = new AtomicInteger(0);
        
        // Remove expired tokens with time drift buffer
        blacklistedTokens.entrySet().removeIf(entry -> {
            BlacklistedToken token = entry.getValue();
            if ((token.getExpiresAt() + TIME_DRIFT_BUFFER_SECONDS) < currentTimeInSeconds) {
                removedCount.incrementAndGet();
                return true;
            }

            return false;
        });
        
        if (removedCount.get() > 0) {
            logger.info("Cleaned up {} expired tokens from blacklist", removedCount.get());
        } else {
            logger.debug("No expired tokens found during cleanup");
        }
    }
}