const express = require('express');
const router = express.Router();
const { db } = require('../../firebase/firebase');

router.post('/', async (req, res) => {
  const {
    uid,
    email,
    name,
    age
  } = req.body;

  if (!uid || !email || !name) {
    return res.status(400).json({ error: 'uid, email, and name are required' });
  }

  try {
    const userRef = db.collection('users').doc(uid);
    const userDoc = await userRef.get();

    if (userDoc.exists) {
      return res.status(400).json({ error: 'User already exists' });
    }

    await userRef.set({
      email,
      name,
      age: age || null,
      username: null,
      bio: '',
      likedGenres: [],
      profilePic: '',
      isArtist: false,
      followers: [],
      following: [],
      createdAt: new Date()
    });

    res.status(201).json({ success: true, message: 'User created' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
