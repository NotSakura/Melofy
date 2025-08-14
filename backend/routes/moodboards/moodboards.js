
const express = require('express');
const router = express.Router();

// GET all moodboards (optionally filter by creator or public/private)
router.use('/', require('./views/getMoodboards')); // GET /api/moodboards

// GET personalized feed of moodboards based on user's liked genres
router.use('/feed', require('./views/getMoodboardFeed')); // GET /api/moodboards/feed

// CREATE a new moodboard
router.use('/create', require('./views/createMoodboard')); // POST /api/moodboards/create

// GET a single moodboard by ID
router.use('/:id', require('./views/getMoodboardById')); // GET /api/moodboards/:id

// UPDATE a moodboard by ID
router.use('/:id', require('./views/updateMoodboard')); // PUT /api/moodboards/:id

// DELETE a moodboard by ID
router.use('/:id', require('./views/deleteMoodboard')); // DELETE /api/moodboards/:id

module.exports = router;
