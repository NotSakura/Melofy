const express = require('express');
const router = express.Router();
const { admin } = require('../../firebase/firebase');
const verifyToken = require('./verifyToken');

router.post('/', verifyToken, async (req, res) => {
  try {
    await admin.auth().revokeRefreshTokens(req.user.uid);
    res.json({ success: true, message: 'User logged out (tokens revoked)' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

module.exports = router;
