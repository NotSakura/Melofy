const express = require('express');
const router = express.Router();
const { db } = require('../../firebase/firebase');
const verifyToken = require('./verifyToken');

router.post('/', verifyToken, async (req, res) => {
  const uid = req.user.uid;

  try {
    const userDoc = await db.collection('users').doc(uid).get();

    if (!userDoc.exists) {
      return res.status(404).json({ error: 'User profile not found' });
    }

    res.json({
      success: true,
      user: userDoc.data()
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
