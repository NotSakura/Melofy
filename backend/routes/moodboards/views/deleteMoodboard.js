const express = require('express');
const router = express.Router();
const { db } = require('../../../firebase/firebase');

router.delete('/:id', async (req, res) => {
// Route: DELETE /api/moodboards/:id
// Purpose: Delete a moodboard by its Firestore document ID
// Returns: Success status
    try {
        await db.collection('moodboards').doc(req.params.id).delete();
        res.json({ success: true });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
});

module.exports = router;
