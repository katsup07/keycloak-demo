import { Request, Response, NextFunction } from 'express';
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
export declare const validateJWT: (req: Request, _: Response, next: NextFunction) => Promise<void>;
export declare const requireAdmin: (req: Request, res: Response, next: NextFunction) => void;
export declare const requireUser: (req: Request, res: Response, next: NextFunction) => void;
//# sourceMappingURL=auth.d.ts.map