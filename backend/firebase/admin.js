const admin = require("firebase-admin");

// Authentication middleware - will be used when auth is implemented
/*
const authMiddleware = async (req, res, next) => {
    const header = req.headers.authorization;
    if (!header || !header.startsWith("Bearer ")) {
        return res.status(401).json({ error: "Unauthorized" });
    }

    const token = header.split(" ")[1];
    try {
        const decoded = await admin.auth().verifyIdToken(token);
        req.user = decoded;
        next();
    } catch (err) {
        return res.status(401).json({ error: "Invalid token" }); 
    }
};
*/

module.exports = {
    admin,
    // authMiddleware,  // Uncomment when implementing authentication
    storage: admin.storage()
};
