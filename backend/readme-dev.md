# Melofy Backend Documentation

## Tech Stack
- **Runtime Environment**: Node.js
- **Framework**: Express.js
- **Database**: Firebase (for data storage and authentication)
- **Containerization**: Docker
- **API Style**: RESTful

## Architecture
The backend follows a modular architecture with the following structure:
- `routes/`: Contains all API endpoint handlers organized by feature
  - `auth/`: Authentication related routes
  - `posts/`: Post management routes ()
  - `users/`: User profile management
  - `moodboards/`: Moodboard related functionalities
- `firebase/`: Firebase configuration and utilities
- `index.js`: Main application entry point

## Running the Backend

### Using Docker
1. Make sure you have Docker installed on your system
2. Navigate to the backend directory
3. Build the Docker image:
   ```bash
   docker build -t melofy-backend .
   ```
4. Run the container:
   ```bash
   docker run -p 3000:3000 melofy-backend
   ```
   The backend will be accessible at `http://localhost:3000`

### Without Docker (Development)
1. Install dependencies:
   ```bash
   npm install
   ```
2. Start the server:
   ```bash
   npm start
   ```

## API Testing
The API endpoints have been tested using Postman for basic functionality. Test cases include:
- Successful and failed authentication attempts
- Post creation and retrieval
- Image upload functionality
- Moodboard operations

## API Endpoints

### Authentication
#### Sign Up
- **Endpoint**: `POST /api/auth/signup`
- **Description**: Register a new user
- **Input**: 
  ```json
  {
    "email": "string",
    "password": "string",
    "username": "string"
  }
  ```
- **Response**: JWT token and user information

#### Sign In
- **Endpoint**: `POST /api/auth/signin`
- **Description**: Authenticate existing user
- **Input**: 
  ```json
  {
    "email": "string",
    "password": "string"
  }
  ```
- **Response**: JWT token and user information

### Posts
#### Create Post
- **Endpoint**: `POST /api/posts/create`
- **Description**: Create a new post with Spotify track and image
- **Input**: 
  ```json
  {
    "previewUrl": "string",    // iTunes preview song URL
    "trackName": "string",     // iTunes track name
    "artistName": "string",    // iTunes artist name
    "imageUrl": "string",
    "caption": "string",
    "tags": ["string"],
    "genres": ["string"]
  }
  ```
- **Response**: 
  ```json
  {
    "success": true,
    "postId": "string",
    "post": {
      "creatorId": "string",
      "previewUrl": "string",
      "trackName": "string",
      "artistName": "string",
      "imageUrl": "string",
      "caption": "string",
      "tags": ["string"],
      "genres": ["string"],
      "likes": 0,
      "createdAt": "string"
    }
  }
  ```

#### Get All Posts
- **Endpoint**: `GET /api/posts`
- **Description**: Retrieve all posts with pagination
- **Query Parameters**: 
  - `page`: number (optional, default: 1)
  - `limit`: number (optional, default: 10)
- **Response**: 
  ```json
  {
    "success": true,
    "posts": [Post],
    "total": number,
    "page": number,
    "totalPages": number
  }
  ```

#### Get Specific Post
- **Endpoint**: `GET /api/posts/:id`
- **Description**: Retrieve a specific post by ID
- **Parameters**:
  - `id`: Post ID
- **Response**: 
  ```json
  {
    "success": true,
    "post": {
      "id": "string",
      "creatorId": "string",
      "TrackId": "string",
      "imageUrl": "string",
      "caption": "string",
      "tags": ["string"],
      "genres": ["string"],
      "likes": number,
      "createdAt": "string"
    }
  }
  ```

#### Update Post
- **Endpoint**: `PUT /api/posts/:id`
- **Description**: Update an existing post
- **Parameters**:
  - `id`: Post ID
- **Input**: 
  ```json
  {
    "previewUrl": "string",    // iTunes preview song URL
    "trackName": "string",     // iTunes track name
    "artistName": "string",    // iTunes artist name
    "imageUrl": "string",
    "caption": "string",
    "tags": ["string"],
    "genres": ["string"]
  }
  ```
- **Response**: 
  ```json
  {
    "success": true,
    "postId": "string",
    "post": {
      "creatorId": "string",
      "previewUrl": "string",
      "imageUrl": "string",
      "caption": "string",
      "tags": ["string"],
      "genres": ["string"],
      "updatedAt": "string"
    }
  }
  ```

#### Delete Post
- **Endpoint**: `DELETE /api/posts/:id`
- **Description**: Delete a post
- **Parameters**:
  - `id`: Post ID
- **Response**: 
  ```json
  {
    "success": true,
    "message": "Post deleted successfully"
  }
  ```

### Posts
#### Upload Image
- **Endpoint**: `POST /api/posts/upload-image`
- **Description**: Upload an image for a post. Stores in Firebase Database and uploads that link to Firebase Cloud Storage
- **Input**: 
  ```
  Form-data:
  {
    "image": File
  }
  ```
- **Response**: 
  ```json
  {
    "imageUrl": "string"
  }
  ```

### Moodboards
#### Create Moodboard
- **Endpoint**: `POST /api/moodboards`
- **Description**: Create a new moodboard
- **Input**: 
  ```json
  {
    "title": "string",
    "description": "string",
    "isPublic": boolean
  }
  ```
- **Response**: Created moodboard details

#### Get All Public Moodboards
- **Endpoint**: `GET /api/moodboards/public`
- **Description**: Retrieve all public moodboards
- **Query Parameters**: 
  - `page`: number (optional)
  - `limit`: number (optional)
- **Response**: Array of public moodboards

#### Get Specific Moodboard
- **Endpoint**: `GET /api/moodboards/:id`
- **Description**: Retrieve a specific moodboard by ID
- **Parameters**: 
  - `id`: Moodboard ID
- **Response**: Moodboard details

#### Edit Moodboard
- **Endpoint**: `PUT /api/moodboards/:id`
- **Description**: Update an existing moodboard
- **Parameters**: 
  - `id`: Moodboard ID
- **Input**: 
  ```json
  {
    "title": "string",
    "description": "string",
    "isPublic": boolean
  }
  ```
- **Response**: Updated moodboard details

#### Delete Moodboard
- **Endpoint**: `DELETE /api/moodboards/:id`
- **Description**: Delete a moodboard
- **Parameters**: 
  - `id`: Moodboard ID
- **Response**: Success message

### User Profile
- **Endpoint**: `PUT /api/users`
- **Description**: Update user profile
- **Input**: 
  ```json
  {
    "username": "string",
    "bio": "string",
    "avatar": "string"
  }
  ```
- **Response**: Updated user profile

## Future Implementations

### Authentication Enhancement
Currently, the authentication middleware is commented out for development purposes. The application will use Firebase Authentication for handling user authentication and authorization. Future implementation will include:
1. Firebase Authentication integration
2. Role-based access control through Firebase
3. Password reset functionality using Firebase Auth
4. Email verification through Firebase
5. OAuth integration for social login (Google, Facebook) via Firebase Auth

### Additional Security Features
- Rate limiting
- Request validation
- CORS policy refinement
- Input sanitization

These features will be implemented progressively to ensure secure and robust authentication system while maintaining the application's performance and usability.
