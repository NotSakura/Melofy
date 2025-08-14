const express = require('express');
const router = express.Router();

// Search across all content types
router.use('/', require('./views/search')); // GET /api/search?q=query

module.exports = router;


/**
 * Search API Contract
 * 
 * Endpoint: GET /api/search?q=your_search_term
 * Description: Search across moodboards and posts by title
 * 
 * Query Parameters:
 * - q: string (required)
 *   The search query text to match against titles
 * 
 * Response: 200 OK
 * {
 *   moodboards: [{
 *     _id: string,
 *     title: string,
 *     description: string,
 *     creator: string,
 *     createdAt: string (ISO date),
 *     updatedAt: string (ISO date),
 *     isPublic: boolean,
 *     genres: string[]
 *   }],
 *   posts: [{
 *     _id: string,
 *     title: string,
 *     content: string,
 *     creator: string,
 *     createdAt: string (ISO date),
 *     updatedAt: string (ISO date),
 *     isPublic: boolean
 *   }],
 *   total: {
 *     moodboards: number,
 *     posts: number
 *   }
 * }
 * 
 * Error Responses:
 * 400 Bad Request
 * {
 *   message: "Search query is required"
 * }
 * 
 * 500 Internal Server Error
 * {
 *   message: "Error performing search",
 *   error: string
 * }
 * 
 * Example Usage:
 * GET /api/search?q=summer
 * 
 * Notes:
 * - Search is case-insensitive
 * - When authentication is enabled (currently commented out):
 *   - Only returns public content and private content owned by the requesting user
 *   - Requires valid JWT token in Authorization header
 */



/// FUTURE: Use Algolia for serach need research