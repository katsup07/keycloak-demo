import { Router, Request, Response } from 'express';
import { logger } from '../utils/logger';

const router = Router();

// GET /api/public/info - パブリック・エンドポイント (認証不要)
router.get('/info', (req: Request, res: Response) => {
  logger.info('Public info endpoint accessed', {
    ip: req.ip,
    userAgent: req.get('User-Agent')
  });

  res.json({
  message: 'This is public information - no authentication required',
  timestamp: new Date().toISOString(),
  version: '1.0.0',
  status: 'online',
  endpoints: {
    public: '/api/public/*',
    user: '/api/user/* (requires user or admin role)',
    admin: '/api/admin/* (requires admin role)'
  }
});
});

export default router;