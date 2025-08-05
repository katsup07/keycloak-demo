import { Router, Request, Response } from 'express';
import { logger } from '../utils/logger';
import { getSizeLimitInfo } from '../utils/sizeUtils';

const router = Router();

// GET /api/public/health - ヘルスチェックエンドポイント (認証不要)
router.get('/health', (req: Request, res: Response) => {
  logger.info('Health check endpoint accessed', {
    ip: req.ip,
    userAgent: req.get('User-Agent')
  });

  res.status(200).json({
    status: 'OK',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    environment: process.env.NODE_ENV || 'development',
    requestSizeLimits: getSizeLimitInfo()
  });
});

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