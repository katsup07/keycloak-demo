"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.sendNotFoundError = void 0;
const sendNotFoundError = (req, res) => res.status(404).json({
    error: 'Not Found',
    message: `Route ${req.originalUrl} not found`,
    timestamp: new Date().toISOString()
});
exports.sendNotFoundError = sendNotFoundError;
//# sourceMappingURL=sendNotFoundError.js.map