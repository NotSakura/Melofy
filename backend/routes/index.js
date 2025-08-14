const express = require('express');
const router = express.Router();

// API Routes
router.use('/api/moodboards', require('./moodboards/moodboards'));
router.use('/api/posts', require('./posts/posts'));
router.use('/api/users', require('./users/users'));
router.use('/api/search', require('./search/search')); // New global search endpoint

module.exports = router;
