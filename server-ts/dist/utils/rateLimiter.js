"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.rateLimiter = void 0;
const express_rate_limit_1 = __importDefault(require("express-rate-limit"));
const logger_1 = require("./logger");
const errorHandler_1 = require("../middleware/errorHandler");
const whitelist = ['127.0.0.1', '::1'];
exports.rateLimiter = (0, express_rate_limit_1.default)({
    windowMs: 15 * 60 * 1000,
    max: 100,
    message: 'Too many requests from this IP, please try again later.',
    standardHeaders: true,
    legacyHeaders: false,
    skip: (req) => whitelist.includes(req.ip ?? ''),
    handler: (req, _res, next, options) => {
        logger_1.logger.warn(`Rate limit exceeded for IP: ${req.ip}`);
        const error = (0, errorHandler_1.createError)('Too many requests. Rate limit exceeded.', options.statusCode);
        next(error);
    }
});
//# sourceMappingURL=rateLimiter.js.map