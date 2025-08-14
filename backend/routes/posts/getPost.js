const express = require('express');
const router = express.Router();
// const { auth } = require('../../firebase/admin');
const { db } = require('../../firebase/admin');

// Get a specific post by ID
router.get('/:id', async (req, res) => {
    try {
        const postId = req.params.id;
        const postDoc = await db.collection('posts').doc(postId).get();

        if (!postDoc.exists) {
            return res.status(404).json({
                success: false,
                error: 'Post not found'
            });
        }

        const postData = postDoc.data();
        // For prototype: use a default user ID
        const userId = 'prototype-user-1';  // In production: req.user.uid

        // Check if post is private and user is not the creator
        if (postData.isPrivate && postData.creatorId !== userId) {
            return res.status(403).json({
                success: false,
                error: 'This post is private'
            });
        }
        
        const post = {
            id: postDoc.id,
            ...postData
        };

        res.status(200).json({
            success: true,
            post
        });

    } catch (error) {
        console.error('Error fetching post:', error);
        res.status(500).json({
            success: false,
            error: 'Failed to fetch post'
        });
    }
});

module.exports = router;
