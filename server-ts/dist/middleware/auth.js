"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.requireUser = exports.requireAdmin = exports.validateJWT = void 0;
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const jwks_rsa_1 = __importDefault(require("jwks-rsa"));
const logger_1 = require("../utils/logger");
const errorHandler_1 = require("./errorHandler");
const TEN_MINUTES = 10 * 60 * 1000;
const client = (0, jwks_rsa_1.default)({
    jwksUri: process.env.JWK_SET_URI ?? "",
    cache: true,
    cacheMaxEntries: 5,
    cacheMaxAge: TEN_MINUTES,
});
const getKey = (header, callback) => {
    console.log("client: ", client);
    client.getSigningKey(header.kid, (err, key) => {
        if (err) {
            logger_1.logger.error('Error getting signing key:', err);
            return callback(err);
        }
        const signingKey = key?.getPublicKey();
        callback(null, signingKey);
    });
};
const validateJWT = async (req, _, next) => {
    try {
        const authHeader = req.headers.authorization;
        const token = extractToken(authHeader);
        jsonwebtoken_1.default.verify(token, getKey, {
            audience: process.env.KEYCLOAK_CLIENT_ID,
            issuer: process.env.ISSUER_URI,
            algorithms: ['RS256']
        }, (err, decoded) => {
            if (err) {
                logger_1.logger.error('JWT verification failed:', err);
                return next((0, errorHandler_1.createError)('Invalid token', 401));
            }
            req.user = decoded;
            logger_1.logger.info('JWT validated successfully', {
                userId: req.user?.sub,
                username: req.user?.preferred_username
            });
            next();
        });
    }
    catch (error) {
        next(error);
    }
};
exports.validateJWT = validateJWT;
const extractToken = (authHeader) => {
    if (!authHeader || !authHeader.startsWith("Bearer "))
        throw (0, errorHandler_1.createError)("Malformed auth header", 400);
    const [, token] = authHeader.split(' ');
    if (!token)
        throw (0, errorHandler_1.createError)("No token provided", 400);
    return token;
};
const requireRole = (requiredRole) => {
    return (req, res, next) => {
        try {
            if (!req.user) {
                throw (0, errorHandler_1.createError)('User not authenticated', 401);
            }
            const userRoles = req.user.realm_access?.roles || [];
            const clientRoles = req.user.resource_access?.[process.env.KEYCLOAK_CLIENT_ID || '']?.roles || [];
            const allRoles = [...userRoles, ...clientRoles];
            if (!allRoles.includes(requiredRole)) {
                logger_1.logger.warn('Access denied - insufficient permissions', {
                    userId: req.user.sub,
                    requiredRole,
                    userRoles: allRoles
                });
                throw (0, errorHandler_1.createError)(`Access denied. Required role: ${requiredRole}`, 403);
            }
            logger_1.logger.info('Role authorization successful', {
                userId: req.user.sub,
                requiredRole,
                userRoles: allRoles
            });
            next();
        }
        catch (error) {
            next(error);
        }
    };
};
exports.requireAdmin = requireRole('admin');
exports.requireUser = requireRole('user');
//# sourceMappingURL=auth.js.map