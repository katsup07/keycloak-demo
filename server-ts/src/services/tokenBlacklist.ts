import { logger } from '../utils/logger';

type BlacklistedToken = {
  jwtId: string; // JWT ID(jti)
  expiresAt: number; // トークン有効期限(exp)
  revokedAt: number; // 無効化時刻
}

type BlacklistStats = {
  totalBlacklistedTokens: number;
  cleanupIntervalMs: number;
}

const TIME_DRIFT_BUFFER = 5 * 60; // 5分バッファ(秒)
const CLEANUP_INTERVAL_MS = 5 * 60 * 1000; // 5分(ミリ秒)

// ブラックリスト用メモリ保存
const blacklistedTokens = new Map<string, BlacklistedToken>();

let cleanupInterval: NodeJS.Timeout | null = null;

// トークンをBL追加
export function revokeToken(jwtId: string, expiresAt: number): void {
  if (!jwtId) {
    logger.warn('Attempted to revoke token without JWT ID');
    return;
  }

  const blacklistedToken: BlacklistedToken = {
    jwtId,
    expiresAt,
    revokedAt: Date.now()
  };

  blacklistedTokens.set(jwtId, blacklistedToken);
  
  logger.info('Token revoked', { 
    jwtId: jwtId.substring(0, 8) + '...', // JWT一部のみ記録
    expiresAt: new Date(expiresAt * 1000).toISOString()
  });
}

// トークンBL判定
export function isTokenRevoked(jwtId: string): boolean {
  if (!jwtId)
    return false;

  return blacklistedTokens.has(jwtId);
}

// 期限切れBL削除
function cleanupExpiredTokens(): void {
  const currentTimeInSeconds = Math.floor(Date.now() / 1000);
  let removedCount = 0;

  // 時刻ズレ防止バッファ
  for (const [jwtId, token] of blacklistedTokens.entries()) {
    if ((token.expiresAt + TIME_DRIFT_BUFFER) < currentTimeInSeconds) {
      blacklistedTokens.delete(jwtId);
      removedCount++;
    }
  }

  if (removedCount > 0)
    logger.info(`Cleaned up ${removedCount} expired tokens from blacklist`);
}

// BL統計取得
export function getBlacklistStats(): BlacklistStats {
  return {
    totalBlacklistedTokens: blacklistedTokens.size,
    cleanupIntervalMs: CLEANUP_INTERVAL_MS
  };
}

// BL全消去(テスト用)
export function clearBlacklist(): void {
  blacklistedTokens.clear();
  logger.info('Token blacklist cleared');
}

// クリーンアップ初期化
export function initializeTokenBlacklist(): void {
  if (cleanupInterval)
    return; // 初期化済

  cleanupInterval = setInterval(cleanupExpiredTokens, CLEANUP_INTERVAL_MS);
  logger.info('Token blacklist service initialized with cleanup interval');
}

// シャットダウン時リソース解放
export function destroyTokenBlacklist(): void {
  clearCleanupInterval();

  blacklistedTokens.clear();
  logger.info('Token blacklist service destroyed');
}

const clearCleanupInterval = () => {
  if (!cleanupInterval) return;

  clearInterval(cleanupInterval);
  cleanupInterval = null;
}