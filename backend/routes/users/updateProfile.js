const express = require('express');
const router = express.Router();
const { db } = require('../../firebase/firebase');
const verifyToken = require('../auth/verifyToken');

router.patch('/:uid', verifyToken, async (req, res) => {
  const { uid } = req.params;

  // Secure check: user can only update their own profile
  if (req.user.uid !== uid) {
    return res.status(403).json({ error: 'Unauthorized' });
  }

  const {
    username,
    bio,
    likedGenres,
    profilePic,
    isArtist
  } = req.body;

  const updateFields = {};

  if (username !== undefined) updateFields.username = username;
  if (bio !== undefined) updateFields.bio = bio;
  if (likedGenres !== undefined) updateFields.likedGenres = likedGenres;
  if (profilePic !== undefined) updateFields.profilePic = profilePic;
  if (isArtist !== undefined) updateFields.isArtist = isArtist;

  try {
    await db.collection('users').doc(uid).update(updateFields);
    res.json({ success: true, message: 'Profile updated successfully' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
