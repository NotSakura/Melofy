// Route: GET /api/moodboards
// Purpose: Retrieve all moodboards, optionally filtered by creatorId or isPublic. 
// Returns: Array of moodboard objects


// This is a backup for feed getMoodboardsFeed.js

const express = require('express');
const router = express.Router();
const { db } = require('../../../firebase/firebase');

router.get('/', async (req, res) => {
    try {
        const { creatorId, isPublic } = req.query;
        let query = db.collection('moodboards');
        if (creatorId) query = query.where('creatorId', '==', creatorId);
        if (isPublic !== undefined) query = query.where('isPublic', '==', isPublic === 'true');
        const snapshot = await query.get();
        const moodboards = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
        res.json(moodboards);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;
