import rateLimit from 'express-rate-limit';
import { logger } from './logger';
import { createError } from '../middleware/errorHandler';

const whitelist = ['127.0.0.1', '::1']; // local IPs or other trusted IPs

export const rateLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100, // limit each IP to 100 requests per windowMs
  message: 'Too many requests from this IP, please try again later.',
  standardHeaders: true,
  legacyHeaders: false,
  skip: (req) => whitelist.includes(req.ip ?? ''), // Skip rate limiting for dev IPs
  handler: (req, _res, next, options) => {
    logger.warn(`Rate limit exceeded for IP: ${req.ip}`);
    const error = createError('Too many requests. Rate limit exceeded.', options.statusCode);
    next(error);
  }
});