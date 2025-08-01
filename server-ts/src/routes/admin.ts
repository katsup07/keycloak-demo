import { Router, Request, Response } from 'express';
import { validateJWT, requireAdmin } from '../middleware/auth';
import { logger } from '../utils/logger';

const router = Router();

// Apply JWT validation to all admin routes
router.use(validateJWT);

// GET /api/admin/data - Admin role required
router.get('/data', requireAdmin, (req: Request, res: Response) => {
  logger.info('Admin data endpoint accessed', {
    userId: req.user?.sub,
    username: req.user?.preferred_username
  });

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
    lastBackup: '2025-07-24T10:30:00Z'
  },
      
        features: [
        'User management',
        'System configuration',
        'Security monitoring',
        'Analytics and reporting'
      ],
      permissions: ['read:all', 'write:all', 'delete:all', 'admin:system']
    
  });
});

export default router;