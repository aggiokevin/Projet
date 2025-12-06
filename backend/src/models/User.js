const pool = require('../config/database');
const bcrypt = require('bcrypt');

class User {
    static async create(userData) {
        const hashedPassword = await bcrypt.hash(userData.password, 10);
        const [result] = await pool.execute(
            `INSERT INTO users (name, email, password_hash, role, bio) 
             VALUES (?, ?, ?, ?, ?)`,
            [userData.name, userData.email, hashedPassword, userData.role || 'TRAINEE', userData.bio || '']
        );
        return result.insertId;
    }
    
    static async findByEmail(email) {
        const [rows] = await pool.execute(
            'SELECT * FROM users WHERE email = ?',
            [email]
        );
        return rows[0];
    }
    
    static async findById(id) {
        const [rows] = await pool.execute(
            'SELECT id, name, email, role, bio, created_at FROM users WHERE id = ?',
            [id]
        );
        return rows[0];
    }
    
    static async update(id, updates) {
        const allowedFields = ['name', 'bio', 'role', 'is_active'];
        const fieldsToUpdate = {};
        
        Object.keys(updates).forEach(key => {
            if (allowedFields.includes(key)) {
                fieldsToUpdate[key] = updates[key];
            }
        });
        
        if (Object.keys(fieldsToUpdate).length === 0) {
            return false;
        }
        
        const setClause = Object.keys(fieldsToUpdate)
            .map(key => `${key} = ?`)
            .join(', ');
        const values = Object.values(fieldsToUpdate);
        values.push(id);
        
        const [result] = await pool.execute(
            `UPDATE users SET ${setClause} WHERE id = ?`,
            values
        );
        return result.affectedRows > 0;
    }
}

module.exports = User;
