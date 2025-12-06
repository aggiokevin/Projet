const jwt = require('jsonwebtoken');
const pool = require('../config/database');

const authenticateToken = async (req, res, next) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];
    
    if (!token) {
        return res.status(401).json({ error: 'Token manquant' });
    }
    
    try {
        const decoded = jwt.verify(token, process.env.JWT_SECRET);
        const [users] = await pool.execute(
            'SELECT id, email, name, role, is_active FROM users WHERE id = ?',
            [decoded.userId]
        );
        
        if (users.length === 0 || !users[0].is_active) {
            return res.status(401).json({ error: 'Utilisateur non autorisé' });
        }
        
        req.user = users[0];
        next();
    } catch (error) {
        return res.status(403).json({ error: 'Token invalide' });
    }
};

const authorizeRoles = (...roles) => {
    return (req, res, next) => {
        if (!req.user || !roles.includes(req.user.role)) {
            return res.status(403).json({ error: 'Accès interdit: rôle insuffisant' });
        }
        next();
    };
};

module.exports = { authenticateToken, authorizeRoles };
