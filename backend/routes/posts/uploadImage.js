const express = require('express');
const router = express.Router();
const multer = require('multer');
// Will need these when implementing auth:
// const { authMiddleware, storage } = require('../../firebase/admin');
const { storage } = require('../../firebase/admin');
const path = require('path');

// Configure multer for memory storage
const upload = multer({
    storage: multer.memoryStorage(),
    limits: {
        fileSize: 5 * 1024 * 1024 // 5MB limit
    },
    fileFilter: (req, file, cb) => {
        // Accept only image files
        const allowedTypes = /jpeg|jpg|png|gif/;
        const extname = allowedTypes.test(path.extname(file.originalname).toLowerCase());
        const mimetype = allowedTypes.test(file.mimetype);

        if (extname && mimetype) {
            cb(null, true);
        } else {
            cb(new Error('Only image files are allowed!'));
        }
    }
});

// Upload image endpoint
// TODO: Add auth middleware when authentication is implemented
// router.post('/', authMiddleware, upload.single('image'), async (req, res) => {
router.post('/', upload.single('image'), async (req, res) => {
    try {
        if (!req.file) {
            return res.status(400).json({
                success: false,
                error: 'No image file provided'
            });
        }

        // TODO: Get real user ID from auth when implemented
        // const userId = req.user.uid;
        const userId = 'dev-user'; // For development   MIGHT BE AN ISSUE TO DEBUGG LATERR
        
        // Create a unique filename
        const timestamp = Date.now();
        const fileName = `posts/${userId}/${timestamp}-${req.file.originalname}`;
        
        // Create a reference to the file in Firebase Storage
        const fileRef = storage.bucket().file(fileName);
        
        // Create a write stream and upload the file
        const blobStream = fileRef.createWriteStream({
            metadata: {
                contentType: req.file.mimetype
            }
        });

        blobStream.on('error', (error) => {
            console.error('Upload error:', error);
            res.status(500).json({
                success: false,
                error: 'Failed to upload image'
            });
        });

        blobStream.on('finish', async () => {
            // Make the file publicly accessible
            await fileRef.makePublic();
            
            // Get the public URL
            const publicUrl = `https://storage.googleapis.com/${storage.bucket().name}/${fileName}`;
            
            res.status(200).json({
                success: true,
                imageUrl: publicUrl
            });
        });

        blobStream.end(req.file.buffer);

    } catch (error) {
        console.error('Error in image upload:', error);
        res.status(500).json({
            success: false,
            error: 'Failed to process image upload'
        });
    }
});

module.exports = router;
