const express = require('express');
const router = express.Router();
const { verifyToken, checkRole } = require('../middleware/auth.middleware');
const pool = require('../config/database');

/**
 * POST /api/v1/companies
 * Create a new company
 */
router.post('/', verifyToken, async (req, res) => {
  try {
    const { name, description, logo, website } = req.body;

    const result = await pool.query(
      'INSERT INTO companies (name, description, logo, website, owner_id) VALUES ($1, $2, $3, $4, $5) RETURNING *',
      [name, description, logo, website, req.uid]
    );

    res.status(201).json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

/**
 * GET /api/v1/companies/:companyId
 * Get company profile
 */
router.get('/:companyId', verifyToken, async (req, res) => {
  try {
    const { companyId } = req.params;

    const result = await pool.query('SELECT * FROM companies WHERE id = $1', [companyId]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Company not found' });
    }

    res.json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

/**
 * PUT /api/v1/companies/:companyId
 * Update company profile
 */
router.put('/:companyId', verifyToken, checkRole(['admin', 'owner']), async (req, res) => {
  try {
    const { companyId } = req.params;
    const { name, description, logo, website } = req.body;

    const result = await pool.query(
      'UPDATE companies SET name = $1, description = $2, logo = $3, website = $4, updated_at = NOW() WHERE id = $5 RETURNING *',
      [name, description, logo, website, companyId]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Company not found' });
    }

    res.json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
