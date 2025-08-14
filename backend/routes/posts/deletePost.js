const express = require('express');
const router = express.Router();
// const { auth } = require('../../firebase/admin');
const { db } = require('../../firebase/admin');

router.delete('/:id', /* auth, */ async (req, res) => {
    try {
        const postId = req.params.id;
        // For prototype: use a default user ID
        // In production, this will be the authenticated user's ID
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
                error: 'Unauthorized to delete this post'
            });
        }

        // Delete the post
        await db.collection('posts').doc(postId).delete();

        res.status(200).json({
            success: true,
            message: 'Post deleted successfully'
        });

    } catch (error) {
        console.error('Error deleting post:', error);
        res.status(500).json({
            success: false,
            error: 'Failed to delete post'
        });
    }
});

module.exports = router;
