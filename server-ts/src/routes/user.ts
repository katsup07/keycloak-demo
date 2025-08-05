import { Router, Request, Response } from 'express';
import { validateJWT, requireUser } from '../middleware/auth';
import { logger } from '../utils/logger';

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

export default router;