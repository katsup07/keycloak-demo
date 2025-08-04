import winston from 'winston';

const logLevel = process.env.LOG_LEVEL || 'info';

export const logger = winston.createLogger({
  level: logLevel,
  format: winston.format.combine(
    winston.format.timestamp({
      format: 'YYYY-MM-DD HH:mm:ss'
    }),
    winston.format.errors({ stack: true }),
    winston.format.json()
  ),
  defaultMeta: { service: 'keycloak-demo-ts' },
  transports: [
    // 重要度が`error`以下のすべてのログを`error.log`に書き込む
    new winston.transports.File({ filename: 'logs/error.log', level: 'error' }),
    // 重要度が`info`以下のすべてのログを`combined.log`に書き込む
    new winston.transports.File({ filename: 'logs/combined.log' }),
  ],
});

// 本番環境でない場合はコンソールにログを出力する
if (process.env.NODE_ENV !== 'production') {
  logger.add(new winston.transports.Console({
    format: winston.format.combine(
      winston.format.colorize(),
      winston.format.simple()
    )
  }));
}