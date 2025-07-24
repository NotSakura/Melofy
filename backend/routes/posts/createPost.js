const express = require('express');
const router = express.Router();
const { auth } = require('../../firebase/admin');
const { db } = require('../../firebase/admin');

// Endpoint to create a new media post
router.post('/', auth, async (req, res) => {
    try {
        const { 
            spotifyTrackId,  // This will come from frontend after user selects a song
            imageUrl,        // URL of the uploaded image
            caption,
            tags,
            genres
        } = req.body;

        // Get the authenticated user's ID from the auth middleware
        const userId = req.user.uid;

        // Create the post document
        const newPost = {
            creatorId: userId,
            spotifyTrackId,
            imageUrl,
            caption,
            tags,
            genres,
            likes: 0,
            createdAt: new Date().toISOString()
        };

        // Add the post to Firestore
        const postRef = await db.collection('posts').add(newPost);

        res.status(201).json({
            success: true,
            postId: postRef.id,
            post: newPost
        });

    } catch (error) {
        console.error('Error creating post:', error);
        res.status(500).json({
            success: false,
            error: 'Failed to create post'
        });
    }
});

module.exports = router;
