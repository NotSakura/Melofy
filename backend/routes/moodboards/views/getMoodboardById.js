// Route: GET /api/moodboards/:id
// Purpose: Retrieve a single moodboard by its Firestore document ID
// Returns: Moodboard object or 404 if not found
const express = require('express');
const router = express.Router();
const { db } = require('../../../firebase/firebase');

router.get('/:id', async (req, res) => {
// Route: GET /api/moodboards/:id
// Purpose: Retrieve a single moodboard by its Firestore document ID
// Returns: Moodboard object or 404 if not found
    try {
        const doc = await db.collection('moodboards').doc(req.params.id).get();
        if (!doc.exists) return res.status(404).json({ error: 'Moodboard not found' });
        res.json({ id: doc.id, ...doc.data() });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;
