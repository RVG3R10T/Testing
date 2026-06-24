const express = require('express');
const router = express.Router();
const admin = require('firebase-admin');
const pool = require('../config/database');

/**
 * POST /api/v1/auth/register
 * Register a new user
 */
router.post('/register', async (req, res) => {
  try {
    const { email, password, firstName, lastName, companyId } = req.body;

    // Create Firebase user
    const userRecord = await admin.auth().createUser({
      email,
      password,
      displayName: `${firstName} ${lastName}`,
    });

    // Store user in PostgreSQL
    const result = await pool.query(
      'INSERT INTO users (uid, email, first_name, last_name, company_id, role) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *',
      [userRecord.uid, email, firstName, lastName, companyId, 'user']
    );

    res.status(201).json({
      message: 'User created successfully',
      user: result.rows[0],
    });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

/**
 * POST /api/v1/auth/login
 * Login user (Firebase handles this client-side)
 */
router.post('/login', async (req, res) => {
  try {
    const { idToken } = req.body;

    const decodedToken = await admin.auth().verifyIdToken(idToken);
    const user = await pool.query('SELECT * FROM users WHERE uid = $1', [decodedToken.uid]);

    if (user.rows.length === 0) {
      return res.status(404).json({ error: 'User not found' });
    }

    res.json({
      message: 'Login successful',
      user: user.rows[0],
      token: idToken,
    });
  } catch (error) {
    res.status(401).json({ error: error.message });
  }
});

module.exports = router;
