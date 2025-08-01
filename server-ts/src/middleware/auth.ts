import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';
import jwksClient from 'jwks-rsa';
import { logger } from '../utils/logger';
import { createError } from './errorHandler';

// Extend Request interface to include user info
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

// JWKS(JSON Web Key Set) client for Keycloak
// the jwksUri points to the JWKS endpoint of the Keycloak server. This endpoint provides the public keys that correspond to the private keys used by Keycloak to sign JWTs. The jwksClient library fetches these keys and caches them for efficient token verification.
const TEN_MINUTES = 10 * 60 * 1000;
const client = jwksClient({
  jwksUri: process.env.JWK_SET_URI ?? "",
  cache: true,
  cacheMaxEntries: 5,
  cacheMaxAge: TEN_MINUTES,
});

// Get signing key from JWKS
const getKey = (header: any, callback: any) => {
  console.log("client: ", client);
  // kid means key identifier, used to find the correct key
  client.getSigningKey(header.kid, (err, key) => {
    if (err) {
      logger.error('Error getting signing key:', err);
      return callback(err);
    }
    const signingKey = key?.getPublicKey();
    callback(null, signingKey);
  });
};

// JWT validation middleware
export const validateJWT = async (req: Request, _: Response, next: NextFunction): Promise<void> => {
  try {
    const authHeader = req.headers.authorization;

    const token = extractToken(authHeader);

    console.log("token", token);
    console.log("audience:", process.env.KEYCLOAK_CLIENT_ID);
    // Verify JWT token
    jwt.verify(token, getKey, {
      audience: process.env.KEYCLOAK_CLIENT_ID,
      issuer: process.env.ISSUER_URI,
      algorithms: ['RS256']
    }, (err, decoded) => {
      console.log("decoded", decoded);
      if (err) {
        logger.error('JWT verification failed:', err);
        return next(createError('Invalid token', 401));
      }
      // Attach user info to request
      req.user = decoded as any;
      
      logger.info('JWT validated successfully', {
        userId: req.user?.sub,
        username: req.user?.preferred_username
      });

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

// Role-based authorization middleware
const requireRole = (requiredRole: string) => {
  return (req: Request, res: Response, next: NextFunction): void => {
    try {
      if (!req.user) {
        throw createError('User not authenticated', 401);
      }

      const userRoles = req.user.realm_access?.roles || [];
      const clientRoles = req.user.resource_access?.[process.env.KEYCLOAK_CLIENT_ID || '']?.roles || [];
      const allRoles = [...userRoles, ...clientRoles];

      if (!allRoles.includes(requiredRole)) {
        logger.warn('Access denied - insufficient permissions', {
          userId: req.user.sub,
          requiredRole,
          userRoles: allRoles
        });
        throw createError(`Access denied. Required role: ${requiredRole}`, 403);
      }

      logger.info('Role authorization successful', {
        userId: req.user.sub,
        requiredRole,
        userRoles: allRoles
      });

      next();
    } catch (error) {
      next(error);
    }
  };
};

// Convenience middleware for common roles
export const requireAdmin = requireRole('admin');
export const requireUser = requireRole('user');