import { Request, Response, NextFunction } from 'express';
import jwt, { JwtPayload } from 'jsonwebtoken';
import jwksClient from 'jwks-rsa';
import { logger } from '../utils/logger';
import { createError } from './errorHandler';

// リクエストインターフェースを拡張してユーザー情報を含める
declare global {
  namespace Express {
    interface Request {
      user?: {
        sub: string;
        email?: string;
        preferred_username?: string;
        realm_access?: {
          roles: string[];
        };
        resource_access?: {
          [key: string]: {
            roles: string[];
          };
        };
      };
    }
  }
}

interface CustomJwtPayload extends JwtPayload {
  sub: string;
}

if(!process.env.JWK_SET_URI) 
  throw new Error("JWK_SET_URI is not defined");

// JSON Web Key Set client for Keycloak: JWKSエンドポイントからpublic keyを取得してキャッシュし、トークンを検証する
const TEN_MINUTES = 10 * 60 * 1000;
const client = jwksClient({
  jwksUri: process.env.JWK_SET_URI,
  cache: true,
  cacheMaxEntries: 5,
  cacheMaxAge: TEN_MINUTES,
  rateLimit: true,
  jwksRequestsPerMinute: 10,
});

// JWKSからsigning keyを取得する
const getPublicSigningKey = (header: any, callback: any) => {
   // kid means key identifier
  if (!header.kid) {
    logger.error('JWT header does not contain kid (key identifier)');
    return callback(new Error('Invalid JWT header'));
  }
 
  client.getSigningKey(header.kid, (err, key) => {
    if (err) {
      logger.error('Error getting public signing key:', err);
      return callback(err);
    }
    const publicSigningKey = key?.getPublicKey();
    callback(null, publicSigningKey);
  });
};

// JWT検証ミドルウェア
export const validateJWT = async (req: Request, _res: Response, next: NextFunction): Promise<void> => {
  if(!process.env.ISSUER_URI)
    throw new Error("ISSUER_URI is not defined");

  if(!process.env.KEYCLOAK_CLIENT_ID)
    throw new Error("KEYCLOAK_CLIENT_ID is not defined");
  
  try {
    const authHeader = req.headers.authorization;

    const token = extractToken(authHeader);

    jwt.verify(token, getPublicSigningKey, {
      audience: process.env.KEYCLOAK_CLIENT_ID,
      issuer: process.env.ISSUER_URI,
      algorithms: ['RS256']
    }, (err, decoded) => {
      if (err) {
        logger.error('JWT verification failed:', err);
        return next(createError('Invalid token', 401));
      }
      // ユーザー情報をリクエストに添付する
      req.user = decoded as CustomJwtPayload;

      next();
    });
  } catch (error) {
    next(error);
  }
};

// authHeader: "Bearer eyJhbGciOiJSUzI1..."
const extractToken = (authHeader?: string) => {
  if(!authHeader || !authHeader.startsWith("Bearer "))
    throw createError("Malformed auth header", 400);

  const [, token] = authHeader.split(' ');
  if (!token)
    throw createError("No token provided", 400);

  return token;
};

// ロールベースの認可ミドルウェア
const requireRole = (requiredRole: string) => {
  if(!process.env.KEYCLOAK_CLIENT_ID)
  throw new Error("KEYCLOAK_CLIENT_ID is not defined");

  return (req: Request, _: Response, next: NextFunction): void => {
    try {
      if (!req.user)
        throw createError('User not authenticated', 401);

      const userRoles = req.user.realm_access?.roles || [];
      const clientRoles = req.user.resource_access?.[process.env.KEYCLOAK_CLIENT_ID ?? '']?.roles || [];
      const allRoles = [...userRoles, ...clientRoles];

      if (!allRoles.includes(requiredRole)) {
        logger.warn('Access denied - insufficient permissions', {
          requiredRole,
          userRoles: allRoles
        });
        throw createError(`Access denied. Required role: ${requiredRole}`, 403);
      }

      logger.info('Role authorization successful', {
        requiredRole,
        userRoles: allRoles
      });

      next();
    } catch (error) {
      next(error);
    }
  };
};

// 一般的なロールのための便利なミドルウェア
export const requireAdmin = requireRole('admin');
export const requireUser = requireRole('user');