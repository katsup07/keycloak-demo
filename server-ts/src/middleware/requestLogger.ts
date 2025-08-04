import { Request, Response, NextFunction } from 'express';
import { logger } from '../utils/logger';
import { sanitizeUrl } from '@/utils/sanitizeUrl';

export const requestLogger = (req: Request, res: Response, next: NextFunction): void => {
  const start = Date.now();

  logger.info('Incoming request', {
    method: req.method,
    url: sanitizeUrl(req.url),
    ip: req.ip,
    userAgent: req.get('User-Agent'),
    timestamp: new Date().toISOString()
  });

  // res.endをオーバーライドして、送信前にレスポンスをログに記録する
  const originalEnd = res.end.bind(res);
  res.end = function(chunk?: any, encoding?: any, cb?: () => void) {
    const duration = Date.now() - start;
    
    logger.info('Request completed', {
      method: req.method,
      url: sanitizeUrl(req.url),
      statusCode: res.statusCode,
      duration: `${duration}ms`,
      timestamp: new Date().toISOString()
    });

    return originalEnd(chunk, encoding, cb);
  };

  next();
};