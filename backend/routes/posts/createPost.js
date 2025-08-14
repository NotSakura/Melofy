const express = require('express');
const router = express.Router();
// const { auth } = require('../../firebase/admin');  // Will be used later for auth
const { db } = require('../../firebase/admin');

// Endpoint to create a new media post
router.post('/', /* auth, */ async (req, res) => {
    try {
        const { 
            previewUrl,      // iTunes preview song URL
            trackName,       // iTunes track name
            artistName,      // iTunes artist name
            imageUrl,        // URL of the uploaded image
            caption,
            tags,
            genres
        } = req.body;

        // For prototype: use a default user ID 
        // req.user.uid: In production, this should be the authenticated user's ID
        const userId = 'prototype-user-1';

        // Create the post document
        const newPost = {
            creatorId: userId,
            previewUrl,
            trackName,
            artistName,
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
