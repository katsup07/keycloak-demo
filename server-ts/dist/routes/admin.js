"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const auth_1 = require("../middleware/auth");
const logger_1 = require("../utils/logger");
const router = (0, express_1.Router)();
router.use(auth_1.validateJWT);
router.get('/data', auth_1.requireAdmin, (req, res) => {
    logger_1.logger.info('Admin data endpoint accessed', {
        userId: req.user?.sub,
        username: req.user?.preferred_username
    });
    res.json({
        message: 'This is admin-only data',
        timestamp: new Date().toISOString(),
        admin: {
            id: req.user?.sub,
            username: req.user?.preferred_username,
            email: req.user?.email,
            roles: req.user?.realm_access?.roles || []
        },
        data: {
            totalUsers: 150,
            systemHealth: 'Good',
            lastBackup: '2025-07-24T10:30:00Z'
        },
        features: [
            'User management',
            'System configuration',
            'Security monitoring',
            'Analytics and reporting'
        ],
        permissions: ['read:all', 'write:all', 'delete:all', 'admin:system']
    });
});
exports.default = router;
//# sourceMappingURL=admin.js.map