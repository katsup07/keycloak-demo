import { Router, Request, Response } from 'express';
import { validateJWT, requireAdmin } from '../middleware/auth';
import { logger } from '../utils/logger';
import { getBlacklistStats } from '../services/tokenBlacklist';

const router = Router();

router.use(validateJWT);

// GET /api/admin/data - 管理者ロールが必要
router.get('/data', requireAdmin, (req: Request, res: Response) => {
  logger.info('Admin data endpoint accessed', {
    userId: req.user?.sub,
    username: req.user?.preferred_username
  });

  // トークンBL統計取得
  const tokenStats = getBlacklistStats();

  res.json({
    message: 'This is admin-only data',
    timestamp: new Date().toISOString(),
    admin: {
      id: req.user?.sub,
      username: req.user?.preferred_username,
      email: req.user?.email,
      roles: req.user?.realm_access?.roles || []
    },
    data: {
      totalUsers: 150,
      systemHealth: 'Good',
      lastBackup: '2025-07-24T10:30:00Z',
      tokenSecurity: {
        blacklistedTokens: tokenStats.totalBlacklistedTokens,
        cleanupIntervalMinutes: tokenStats.cleanupIntervalMs / (60 * 1000),
        status: tokenStats.totalBlacklistedTokens > 0 ? 'Active revocations' : 'No revoked tokens'
      }
    },
    features: [
      'User management',
      'System configuration',
      'Security monitoring',
      'Analytics and reporting',
      'Token revocation management'
    ],
    permissions: ['read:all', 'write:all', 'delete:all', 'admin:system']
  });
});

// GET /api/admin/token-stats - 管理者ロールが必要
router.get('/token-stats', requireAdmin, (req: Request, res: Response) => {
  logger.info('Admin token stats endpoint accessed', {
    userId: req.user?.sub,
    username: req.user?.preferred_username
  });

  const stats = getBlacklistStats();

  res.json({
    message: 'Token blacklist statistics',
    timestamp: new Date().toISOString(),
    tokenBlacklist: {
      totalBlacklistedTokens: stats.totalBlacklistedTokens,
      cleanupIntervalMs: stats.cleanupIntervalMs,
      cleanupIntervalMinutes: stats.cleanupIntervalMs / (60 * 1000)
    }
  });
});

export default router;