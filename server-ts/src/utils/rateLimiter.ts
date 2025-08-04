import rateLimit from 'express-rate-limit';
import { logger } from './logger';
import { createError } from '../middleware/errorHandler';

const whitelist = ['127.0.0.1', '::1']; // local IPs or other trusted IPs
const FIFTEEN_MINUTES = 15 * 60 * 1000;
/**
 * Rate limiter middleware to limit the number of requests from a single IP address.
 * This is useful to prevent abuse and DoS attacks.
 */
export const rateLimiter = rateLimit({
  windowMs: FIFTEEN_MINUTES,
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