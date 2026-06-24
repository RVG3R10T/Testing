const express = require('express');
const router = express.Router();
const { verifyToken, checkRole } = require('../middleware/auth.middleware');
const pool = require('../config/database');

/**
 * GET /api/v1/users/:userId
 * Get user profile
 */
router.get('/:userId', verifyToken, async (req, res) => {
  try {
    const { userId } = req.params;

    const result = await pool.query('SELECT * FROM users WHERE id = $1', [userId]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

/**
 * PUT /api/v1/users/:userId
 * Update user profile
 */
router.put('/:userId', verifyToken, async (req, res) => {
  try {
    const { userId } = req.params;
    const { firstName, lastName, bio, avatar } = req.body;

    const result = await pool.query(
      'UPDATE users SET first_name = $1, last_name = $2, bio = $3, avatar = $4, updated_at = NOW() WHERE id = $5 RETURNING *',
      [firstName, lastName, bio, avatar, userId]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
