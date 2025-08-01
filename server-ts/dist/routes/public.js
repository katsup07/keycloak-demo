"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const logger_1 = require("../utils/logger");
const router = (0, express_1.Router)();
router.get('/info', (req, res) => {
    logger_1.logger.info('Public info endpoint accessed', {
        ip: req.ip,
        userAgent: req.get('User-Agent')
    });
    res.json({
        message: 'This is public information - no authentication required',
        timestamp: new Date().toISOString(),
        version: '1.0.0',
        status: 'online',
        endpoints: {
            public: '/api/public/*',
            user: '/api/user/* (requires user or admin role)',
            admin: '/api/admin/* (requires admin role)'
        }
    });
});
exports.default = router;
//# sourceMappingURL=public.js.map