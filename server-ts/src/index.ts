// 環境変数を最初に読み込む
import dotenv from 'dotenv';
dotenv.config();

import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import { logger } from './utils/logger';
import { errorHandler } from './middleware/errorHandler';
import { requestLogger } from './middleware/requestLogger';

// ルート
import publicRoutes from './routes/public';
import userRoutes from './routes/user';
import adminRoutes from './routes/admin';
import { rateLimiter } from './middleware/rateLimiter';
import { sendNotFoundError } from './utils/sendNotFoundError';



const app = express();
const PORT = process.env.PORT || 8082;

// セキュリティミドルウェア
app.use(helmet());

// CORS設定
app.use(cors({
  origin: process.env.CORS_ORIGIN || 'http://localhost:3000',
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization', 'Accept', 'Origin', 'X-Requested-With', 'Cache-Control'],
  exposedHeaders: ['Authorization', 'Content-Disposition']
}));

app.use(rateLimiter);

// Body parsing middleware
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true }));

app.use(requestLogger);

// ヘルスチェックエンドポイント
app.get('/health', (_req, res) => {
  res.status(200).json({
    status: 'OK',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    environment: process.env.NODE_ENV || 'development'
  });
});

// APIルート
app.use('/api/public', publicRoutes);
app.use('/api/user', userRoutes);
app.use('/api/admin', adminRoutes);

// 404ハンドラー
app.use(sendNotFoundError);

app.use(errorHandler);

// 未処理のプロミス拒否を処理する
process.on('unhandledRejection', (reason, promise) => {
  logger.error('Unhandled Rejection at:', promise, 'reason:', reason);
  // アプリケーション固有のロギング、エラーのスロー、または他のロジックなど
});

// 処理されていないexceptionsを処理する
process.on('uncaughtException', (error) => {
  logger.error('Uncaught Exception thrown:', error);
  process.exit(1);
});

app.listen(PORT, () => {
  logger.info(`🚀 TypeScript Express server running on port ${PORT}`);
  logger.info(`📊 Health check available at http://localhost:${PORT}/health`);
  logger.info(`🔒 Keycloak URL: ${process.env.KEYCLOAK_URL}`);
  logger.info(`🌐 CORS origin: ${process.env.CORS_ORIGIN}`);
});

export default app;