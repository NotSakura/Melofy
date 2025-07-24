// Route: PUT /api/moodboards/:id
// Purpose: Update an existing moodboard by its Firestore document ID
// Expects: Fields to update in req.body
// Returns: Updated moodboard object
const express = require('express');
const router = express.Router();
const { db } = require('../../../firebase/firebase');

router.put('/:id', async (req, res) => {
    try {
        const updates = req.body;
        await db.collection('moodboards').doc(req.params.id).update(updates);
        const updatedDoc = await db.collection('moodboards').doc(req.params.id).get();
        res.json({ id: updatedDoc.id, ...updatedDoc.data() });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;
