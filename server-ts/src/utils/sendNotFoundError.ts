import { Request, Response } from 'express';
import { sanitizeUrl } from './sanitizeUrl';

export const sendNotFoundError = (req: Request, res: Response) => res.status(404).json({
  error: 'Not Found',
  message: `Route ${sanitizeUrl(req.originalUrl)} not found`,
  timestamp: new Date().toISOString()
});