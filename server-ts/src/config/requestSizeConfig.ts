import express, { Express } from 'express';
import { getRequestSizeLimits, requestSizeErrorHandler } from '../middleware/requestSizeLimiter';
import { logger } from '../utils/logger';

/**
 * Apply request size limits and body parsing middleware to the Express app
 */
export const useRequestSizeLimits = (app: Express): void => {
 
  const sizeLimits = getRequestSizeLimits();

  // Body parsing middleware with configurable size limits
  app.use(express.json({ 
    limit: sizeLimits.json,
    verify: (req, res, buf) => {
      // Store raw body for potential debugging
      (req as any).rawBody = buf;
    }
  }));

  app.use(express.urlencoded({ 
    extended: true, 
    limit: sizeLimits.urlencoded 
  }));

  app.use(express.raw({ 
    limit: sizeLimits.raw,
    type: ['application/octet-stream', 'application/pdf', 'image/*']
  }));

  app.use(express.text({ 
    limit: sizeLimits.text,
    type: 'text/*'
  }));

  app.use(requestSizeErrorHandler);

  // Log the configured limits
  logger.info(`📏 Request size limits configured - JSON: ${sizeLimits.json}, URL-encoded: ${sizeLimits.urlencoded}, Raw: ${sizeLimits.raw}, Text: ${sizeLimits.text}`);
};