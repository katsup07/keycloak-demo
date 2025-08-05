import { logger } from '../utils/logger';

/**
 * Handles graceful shutdown of the application.
 * @param signal - The signal received (e.g., SIGTERM, SIGINT).
 * @param cleanup - A callback function to perform cleanup tasks.
 */
export const gracefulShutdown = (signal: string, cleanup: () => void) => {
  logger.info(`${signal} received. Starting graceful shutdown...`);
  cleanup();
  process.exit(0);
};
