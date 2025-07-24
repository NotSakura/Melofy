const express = require('express');
const router = express.Router();
const { db } = require('../../firebase/firebase');
const verifyToken = require('../auth/verifyToken');

// GET /api/posts/feed - Get posts based on user's liked genres
router.get('/', verifyToken, async (req, res) => {
    try {
        // Get the current user's liked genres
        const userDoc = await db.collection('users').doc(req.user.uid).get();
        if (!userDoc.exists) {
            return res.status(404).json({ error: 'User not found' });
        }

        const userData = userDoc.data();
        const userLikedGenres = userData.likedGenres || [];

        if (userLikedGenres.length === 0) {
            return res.status(200).json({ 
                posts: [],
                message: 'No liked genres found. Add some genres to see personalized posts!'
            });
        }

        // Query posts that match any of the user's liked genres
        const postsRef = db.collection('posts');
        const postsSnapshot = await postsRef
            .where('genre', 'array-contains-any', userLikedGenres)
            .orderBy('createdAt', 'desc') // Assuming we have a createdAt field
            .limit(20) // Limit to 20 posts per request
            .get();

        const posts = [];
        postsSnapshot.forEach(doc => {
            posts.push({
                id: doc.id,
                ...doc.data()
            });
        });

        res.json({
            posts,
            message: posts.length > 0 
                ? 'Posts fetched successfully' 
                : 'No posts found matching your liked genres'
        });

    } catch (error) {
        console.error('Error fetching feed:', error);
        res.status(500).json({ error: 'Failed to fetch feed posts' });
    }
});

module.exports = router;
