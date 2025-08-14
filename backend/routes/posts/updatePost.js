const express = require('express');
const router = express.Router();
// const { auth } = require('../../firebase/admin');
const { db } = require('../../firebase/admin');

router.put('/:id', /* auth, */ async (req, res) => {
    try {
        const postId = req.params.id;
        const { 
            previewUrl,      // iTunes preview song URL
            trackName,       // iTunes track name
            artistName,      // iTunes artist name
            imageUrl,
            caption,
            tags,
            genres
        } = req.body;

        // For prototype: use a default user ID
        const userId = 'prototype-user-1';

        // Get the post
        const postDoc = await db.collection('posts').doc(postId).get();

        if (!postDoc.exists) {
            return res.status(404).json({
                success: false,
                error: 'Post not found'
            });
        }

        // Check if user is the creator
        if (postDoc.data().creatorId !== userId) {
            return res.status(403).json({
                success: false,
                error: 'Unauthorized to update this post'
            });
        }

        // Update the post
        const updatedPost = {
            previewUrl,
            trackName,
            artistName,
            imageUrl,
            caption,
            tags,
            genres,
            updatedAt: new Date().toISOString()
        };

        await db.collection('posts').doc(postId).update(updatedPost);

        res.status(200).json({
            success: true,
            postId,
            post: {
                ...postDoc.data(),
                ...updatedPost
            }
        });

    } catch (error) {
        console.error('Error updating post:', error);
        res.status(500).json({
            success: false,
            error: 'Failed to update post'
        });
    }
});

module.exports = router;
