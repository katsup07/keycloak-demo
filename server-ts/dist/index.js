"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const dotenv_1 = __importDefault(require("dotenv"));
dotenv_1.default.config();
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const helmet_1 = __importDefault(require("helmet"));
const logger_1 = require("./utils/logger");
const errorHandler_1 = require("./middleware/errorHandler");
const requestLogger_1 = require("./middleware/requestLogger");
const public_1 = __importDefault(require("./routes/public"));
const user_1 = __importDefault(require("./routes/user"));
const admin_1 = __importDefault(require("./routes/admin"));
const rateLimiter_1 = require("./utils/rateLimiter");
const sendNotFoundError_1 = require("./utils/sendNotFoundError");
const app = (0, express_1.default)();
const PORT = process.env.PORT || 8082;
app.use((0, helmet_1.default)());
app.use((0, cors_1.default)({
    origin: process.env.CORS_ORIGIN || 'http://localhost:3000',
    credentials: true,
    methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE', 'OPTIONS'],
    allowedHeaders: ['Content-Type', 'Authorization', 'Accept', 'Origin', 'X-Requested-With', 'Cache-Control'],
    exposedHeaders: ['Authorization', 'Content-Disposition']
}));
app.use(rateLimiter_1.rateLimiter);
app.use(express_1.default.json({ limit: '10mb' }));
app.use(express_1.default.urlencoded({ extended: true }));
app.use(requestLogger_1.requestLogger);
app.get('/health', (_req, res) => {
    res.status(200).json({
        status: 'OK',
        timestamp: new Date().toISOString(),
        uptime: process.uptime(),
        environment: process.env.NODE_ENV || 'development'
    });
});
app.use('/api/public', public_1.default);
app.use('/api/user', user_1.default);
app.use('/api/admin', admin_1.default);
app.use(sendNotFoundError_1.sendNotFoundError);
app.use(errorHandler_1.errorHandler);
process.on('unhandledRejection', (reason, promise) => {
    logger_1.logger.error('Unhandled Rejection at:', promise, 'reason:', reason);
});
process.on('uncaughtException', (error) => {
    logger_1.logger.error('Uncaught Exception thrown:', error);
    process.exit(1);
});
app.listen(PORT, () => {
    logger_1.logger.info(`🚀 TypeScript Express server running on port ${PORT}`);
    logger_1.logger.info(`📊 Health check available at http://localhost:${PORT}/health`);
    logger_1.logger.info(`🔒 Keycloak URL: ${process.env.KEYCLOAK_URL}`);
    logger_1.logger.info(`🌐 CORS origin: ${process.env.CORS_ORIGIN}`);
});
exports.default = app;
//# sourceMappingURL=index.js.map