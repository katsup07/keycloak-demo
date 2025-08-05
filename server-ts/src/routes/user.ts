import { Router, Request, Response } from 'express';
import { validateJWT, requireUser } from '../middleware/auth';
import { logger } from '../utils/logger';
import { revokeToken } from '../services/tokenBlacklist';

const router = Router();

router.use(validateJWT);
// GET /api/user/data - ユーザーロールが必要
router.get('/data', requireUser, (req: Request, res: Response) => {
  logger.info('User data endpoint accessed', {
    userId: req.user?.sub,
    username: req.user?.preferred_username
  });

  res.json({
    message: 'This is user specific data',
    timestamp: new Date().toISOString(),
    user: {
      id: req.user?.sub,
      username: req.user?.preferred_username,
      email: req.user?.email,
      roles: req.user?.realm_access?.roles || []
    },
  });
});
// GET /api/user/profile - ユーザーロールが必要
router.get('/profile', requireUser, (req: Request, res: Response) => {
  logger.info('User profile endpoint accessed', {
    userId: req.user?.sub,
    username: req.user?.preferred_username
  });

  res.json({
    message: 'This is a user profile',
    timestamp: new Date().toISOString(),
    data: {
      userDashboard: 'Welcome to your user dashboard',
      features: [
        'View personal profile',
        'Access user-specific content',
        'Manage account settings'
      ],
      lastLogin: "10 minutes ago",
      permissions: ['read:profile', 'update:profile']
    }
  });
});

router.post('/data', requireUser, (req: Request, res: Response) => {
  logger.info('User data update endpoint accessed', {
    userId: req.user?.sub,
    username: req.user?.preferred_username
  });
  res.json({
    message: 'POST request was sent to /api/user/data',
    timestamp: new Date().toISOString(),
    data: req.body || "NO DATA WAS PASSED"
  });

});

// POST /api/user/logout - ユーザーロールが必要
router.post('/logout', requireUser, (req: Request, res: Response) => {
  try {
    const user = req.user;
    
    if (!user) {
      return res.status(401).json({
        error: 'User not authenticated',
        timestamp: new Date().toISOString()
      });
    }

    if (user.jwtId && user.expiresAt) {
      revokeToken(user.jwtId, user.expiresAt);
      
      logger.info('User logged out successfully', {
        userId: user.sub,
        username: user.preferred_username,
        jwtId: user.jwtId.substring(0, 8) + '...'
      });

      return res.json({
        message: 'Logout successful',
        timestamp: new Date().toISOString(),
        user: {
          id: user.sub,
          username: user.preferred_username
        }
      });
    } else {
      logger.warn('Token missing JWT ID or expiration, cannot revoke', {
        userId: user.sub,
        hasJwtId: !!user.jwtId,
        hasExpiration: !!user.expiresAt
      });

      return res.json({
        message: 'Logout processed (token could not be revoked)',
        timestamp: new Date().toISOString(),
        warning: 'Token revocation not available for this token type'
      });
    }
  } catch (error) {
    logger.error('Logout failed', { error: error instanceof Error ? error.message : error });
    return res.status(500).json({
      error: 'Logout failed',
      timestamp: new Date().toISOString()
    });
  }
});

export default router;