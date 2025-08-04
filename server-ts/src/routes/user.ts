import { Router, Request, Response } from 'express';
import { validateJWT, requireUser } from '../middleware/auth';
import { logger } from '../utils/logger';

const router = Router();

// Apply JWT validation to all user routes
router.use(validateJWT);

// GET /api/user/data - User role required
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

export default router;