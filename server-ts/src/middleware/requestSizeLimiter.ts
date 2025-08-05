import { Request, Response, NextFunction } from 'express';
import { logger } from '../utils/logger';

export type RequestSizeLimits = {
  json: string;
  urlencoded: string;
  raw: string;
  text: string;
}

export const getRequestSizeLimits = (): RequestSizeLimits => {
  return {
    json: process.env.REQUEST_SIZE_LIMIT_JSON || '10mb',
    urlencoded: process.env.REQUEST_SIZE_LIMIT_URLENCODED || '10mb',
    raw: process.env.REQUEST_SIZE_LIMIT_RAW || '100mb',
    text: process.env.REQUEST_SIZE_LIMIT_TEXT || '1mb'
  };
};

export const requestSizeErrorHandler = (
  error: any,
  req: Request,
  res: Response,
  next: NextFunction
) => {
  if (error && error.type === 'entity.too.large') {
    logger.warn(`Request size limit exceeded for ${req.method} ${req.path}`, {
      contentLength: req.get('content-length'),
      userAgent: req.get('user-agent'),
      ip: req.ip
    });

    return res.status(413).json({
      error: 'Request Entity Too Large',
      message: 'The request payload is too large. Please reduce the size of your request.',
      code: 'PAYLOAD_TOO_LARGE',
      timestamp: new Date().toISOString()
    });
  }

  if (error && error.type === 'entity.parse.failed') {
    logger.warn(`Request parsing failed for ${req.method} ${req.path}`, {
      error: error.message,
      userAgent: req.get('user-agent'),
      ip: req.ip
    });

    return res.status(400).json({
      error: 'Bad Request',
      message: 'Failed to parse request body.',
      code: 'PARSE_ERROR',
      timestamp: new Date().toISOString()
    });
  }

  return next(error);
};