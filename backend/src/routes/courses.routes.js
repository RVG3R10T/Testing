const express = require('express');
const router = express.Router();
const { verifyToken, checkRole } = require('../middleware/auth.middleware');
const pool = require('../config/database');

/**
 * POST /api/v1/courses
 * Create a new course
 */
router.post('/', verifyToken, checkRole(['admin', 'instructor']), async (req, res) => {
  try {
    const { title, description, companyId, thumbnail } = req.body;

    const result = await pool.query(
      'INSERT INTO courses (title, description, company_id, thumbnail, creator_id) VALUES ($1, $2, $3, $4, $5) RETURNING *',
      [title, description, companyId, thumbnail, req.uid]
    );

    res.status(201).json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

/**
 * GET /api/v1/courses/:courseId
 * Get course details
 */
router.get('/:courseId', verifyToken, async (req, res) => {
  try {
    const { courseId } = req.params;

    const result = await pool.query('SELECT * FROM courses WHERE id = $1', [courseId]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Course not found' });
    }

    // Get modules
    const modulesResult = await pool.query(
      'SELECT * FROM course_modules WHERE course_id = $1 ORDER BY order_index ASC',
      [courseId]
    );

    res.json({
      ...result.rows[0],
      modules: modulesResult.rows,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

/**
 * POST /api/v1/courses/:courseId/modules
 * Add module to course
 */
router.post('/:courseId/modules', verifyToken, checkRole(['admin', 'instructor']), async (req, res) => {
  try {
    const { courseId } = req.params;
    const { title, content, contentType, orderIndex } = req.body;

    const result = await pool.query(
      'INSERT INTO course_modules (course_id, title, content, content_type, order_index) VALUES ($1, $2, $3, $4, $5) RETURNING *',
      [courseId, title, content, contentType, orderIndex]
    );

    res.status(201).json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
