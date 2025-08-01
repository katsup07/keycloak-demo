"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const auth_1 = require("../middleware/auth");
const logger_1 = require("../utils/logger");
const router = (0, express_1.Router)();
router.use(auth_1.validateJWT);
router.get('/data', auth_1.requireUser, (req, res) => {
    logger_1.logger.info('User data endpoint accessed', {
        userId: req.user?.sub,
        username: req.user?.preferred_username
    });
    res.json({
        message: 'This is user-specific data',
        timestamp: new Date().toISOString(),
        user: {
            id: req.user?.sub,
            username: req.user?.preferred_username,
            email: req.user?.email,
            roles: req.user?.realm_access?.roles || []
        },
        data: {
            userDashboard: 'Welcome to your user dashboard',
            features: [
                'View personal profile',
                'Access user-specific content',
                'Manage account settings'
            ],
            lastLogin: "10 minutes ago",
            permissions: ['read:profile', 'update:profile']
        }
    });
});
exports.default = router;
//# sourceMappingURL=user.js.map