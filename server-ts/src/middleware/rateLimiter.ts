import rateLimit from 'express-rate-limit';
import { logger } from '../utils/logger';
import { createError } from './errorHandler';

const whitelist = process.env.WHITELIST ? JSON.parse(process.env.WHITELIST) : []; // ローカルIPまたは他の信頼されたIP
const FIFTEEN_MINUTES = 15 * 60 * 1000;
/**
 * 単一のIPアドレスからのリクエスト数を制限するためのレートリミターミドルウェア。
 * これは濫用やDoS攻撃を防ぐのに役立つ。
 */
export const rateLimiter = rateLimit({
  windowMs: FIFTEEN_MINUTES,
  max: 100, // 各IPをwindowMsごとに100リクエストに制限する
  message: 'Too many requests from this IP, please try again later.',
  standardHeaders: true,
  legacyHeaders: false,
  skip: (req) => whitelist.includes(req.ip ?? ''), // 開発者IPのレート制限をスキップする
  handler: (req, _res, next, options) => {
    logger.warn(`Rate limit exceeded for IP: ${req.ip}`);
    const error = createError('Too many requests. Rate limit exceeded.', options.statusCode);
    next(error);
  }
});