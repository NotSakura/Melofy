// Route: POST /api/moodboards/create
// Purpose: Create a new moodboard document in Firestore
// Expects: creatorId, name, coverImage, postIds, isPublic, tags (in req.body)
// Returns: The created moodboard object with its Firestore ID

const express = require('express');
const router = express.Router();
const { db } = require('../../../firebase/firebase');

// Create Moodboard endpoint
router.post('/create', async (req, res) => {
    try {
        const { creatorId, name, coverImage, postIds, isPublic, tags } = req.body;
        // Build moodboard object
        const moodboard = {
            creatorId,
            name,
            coverImage,
            postIds,
            isPublic,
            tags: tags || [],
            createdAt: new Date()
        };
        // Add to Firestore
        const docRef = await db.collection('moodboards').add(moodboard);
        res.status(201).json({ id: docRef.id, ...moodboard });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;
