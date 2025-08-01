import { Request, Response } from 'express';

export const sendNotFoundError = (req: Request, res: Response) => res.status(404).json({
  error: 'Not Found',
  message: `Route ${req.originalUrl} not found`,
  timestamp: new Date().toISOString()
});