// Route: GET /api/moodboards/feed
// Purpose: Get moodboards based on user's liked genres/tags
// Returns: Array of moodboard objects that match user's interests

const express = require('express');
const router = express.Router();
const { db } = require('../../../firebase/firebase');
// const verifyToken = require('../../auth/verifyToken');  // Will be used later for auth

router.get('/feed', /* verifyToken, */ async (req, res) => {
    try {
        // TODO: Will be used later for personalization
        // const userDoc = await db.collection('users').doc(req.user.uid).get();
        // if (!userDoc.exists) {
        //     return res.status(404).json({ error: 'User not found' });
        // }
        // const userData = userDoc.data();
        // const userLikedGenres = userData.likedGenres || [];
        
        // For prototype: use some default genres
        const userLikedGenres = ['pop', 'rock', 'indie'];

        if (userLikedGenres.length === 0) {
            return res.status(200).json({ 
                moodboards: [],
                message: 'No liked genres found. Add some genres to see personalized moodboards!'
            });
        }

        // Query public moodboards that have tags matching user's liked genres
        const moodboardsRef = db.collection('moodboards');
        const moodboardsSnapshot = await moodboardsRef
            .where('isPublic', '==', true)
            .where('tags', 'array-contains-any', userLikedGenres)
            .orderBy('createdAt', 'desc')
            .limit(20)
            .get();

        const moodboards = [];
        moodboardsSnapshot.forEach(doc => {
            moodboards.push({
                id: doc.id,
                ...doc.data()
            });
        });

        res.json({
            moodboards,
            message: moodboards.length > 0 
                ? 'Moodboards fetched successfully' 
                : 'No moodboards found matching your liked genres'
        });

    } catch (error) {
        console.error('Error fetching moodboard feed:', error);
        res.status(500).json({ error: 'Failed to fetch moodboard feed' });
    }
});

module.exports = router;
