const express = require('express');
const router = express.Router();
const db = require('../../../firebase/db');

// Search for content across all types
router.get('/', /* auth, */ async (req, res) => {
    try {
        const searchQuery = req.query.q; // Get the search query from URL parameter

        if (!searchQuery) {
            return res.status(400).json({ message: 'Search query is required' });
        }

        // Get all moodboards and filter in memory
        const moodboardsSnapshot = await db.collection('moodboards').get();
        
        const searchQueryLower = searchQuery.toLowerCase();
        const moodboards = moodboardsSnapshot.docs
            .filter(doc => doc.data().title.toLowerCase().includes(searchQueryLower))
            .slice(0, 10) // Limit to 10 moodboards
            .map(doc => ({
                id: doc.id,
                title: doc.data().title,
                description: doc.data().description,
                creator: doc.data().creator,
                createdAt: doc.data().createdAt,
                updatedAt: doc.data().updatedAt,
                isPublic: doc.data().isPublic,
                genres: doc.data().genres
            }));

        // Get all posts and filter in memory
        const postsSnapshot = await db.collection('posts').get();
        
        const posts = postsSnapshot.docs
            .filter(doc => doc.data().title.toLowerCase().includes(searchQueryLower))
            .slice(0, 15) // Limit to 15 posts
            .map(doc => ({
            id: doc.id,
            title: doc.data().title,
            content: doc.data().content,
            creator: doc.data().creator,
            createdAt: doc.data().createdAt,
            updatedAt: doc.data().updatedAt,
            isPublic: doc.data().isPublic
        }));

        res.json({
            moodboards,
            posts,
            total: {
                moodboards: moodboards.length,
                posts: posts.length
            }
        });

    } catch (error) {
        console.error('Search error:', error);
        res.status(500).json({ message: 'Error performing search', error: error.message });
    }
});

module.exports = router;
