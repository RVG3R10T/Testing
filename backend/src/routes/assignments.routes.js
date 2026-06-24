const express = require('express');
const router = express.Router();
const { verifyToken, checkRole } = require('../middleware/auth.middleware');
const pool = require('../config/database');

/**
 * POST /api/v1/assignments
 * Assign course to user(s)
 */
router.post('/', verifyToken, checkRole(['admin', 'instructor']), async (req, res) => {
  try {
    const { courseId, userId, dueDate } = req.body;

    const result = await pool.query(
      'INSERT INTO assignments (course_id, user_id, due_date, assigned_by) VALUES ($1, $2, $3, $4) RETURNING *',
      [courseId, userId, dueDate, req.uid]
    );

    res.status(201).json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

/**
 * GET /api/v1/assignments/user/:userId
 * Get assignments for a user
 */
router.get('/user/:userId', verifyToken, async (req, res) => {
  try {
    const { userId } = req.params;

    const result = await pool.query(
      'SELECT a.*, c.title as course_title FROM assignments a JOIN courses c ON a.course_id = c.id WHERE a.user_id = $1 ORDER BY a.created_at DESC',
      [userId]
    );

    res.json(result.rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

/**
 * PUT /api/v1/assignments/:assignmentId/progress
 * Update assignment progress
 */
router.put('/:assignmentId/progress', verifyToken, async (req, res) => {
  try {
    const { assignmentId } = req.params;
    const { completionPercentage, isCompleted } = req.body;

    const result = await pool.query(
      'UPDATE assignments SET completion_percentage = $1, is_completed = $2, completed_at = CASE WHEN $2 = true THEN NOW() ELSE NULL END WHERE id = $3 RETURNING *',
      [completionPercentage, isCompleted, assignmentId]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Assignment not found' });
    }

    res.json(result.rows[0]);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
