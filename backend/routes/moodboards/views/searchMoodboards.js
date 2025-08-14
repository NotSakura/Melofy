const express = require('express');
const router = express.Router();
const Moodboard = require('../../../models/moodboard');
const Post = require('../../../models/post');
// const auth = require('../../../middleware/auth');

// Search for moodboards and posts by title
router.get('/', /* auth, */ async (req, res) => {
    try {
        const searchQuery = req.query.q; // Get the search query from URL parameter

        if (!searchQuery) {
            return res.status(400).json({ message: 'Search query is required' });
        }

        // Create a case-insensitive regex pattern for the search
        const searchPattern = new RegExp(searchQuery, 'i');

        // Search for moodboards
        const moodboards = await Moodboard.find({
            title: searchPattern,
            // Only return public moodboards or those owned by the requesting user
            // $or: [
            //     { isPublic: true },
            //     { creator: req.user._id }
            // ]
        }).select('title description creator createdAt updatedAt isPublic genres');

        // Search for posts
        const posts = await Post.find({
            title: searchPattern,
            // Only return public posts or those owned by the requesting user
            // $or: [
            //     { isPublic: true },
            //     { creator: req.user._id }
            // ]
        }).select('title content creator createdAt updatedAt isPublic');

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
