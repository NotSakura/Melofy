# Melofy
Melofy is a social platform where users create, save, and explore music-inspired moodboards with images and songs. It offers a personalized experience for music fans to organize and share their favourite tracks and moods, bringing together self-expression, musical storytelling, and community.

---

## Features

- **Explore Moodboards**: Explore personalized and trending moodboards created by other fans.
- **Create Posts**: Combine your favourite songs and pictures into a new post.  
- **Create Moodboards**: Combine your favourite posts into personalized moodboards.  
- **User Profile**: View your posts and moodboards.
- **Community**: Like and comment on posts and moodboards, and tag others in your moodboards.
- **Dark Mode Support**: Seamlessly switch between light and dark themes.  

---

## Tech Stack

- **Flutter**
- **Node.js + Express**
- **Firebase**
- **iTunes API**


---

## Installation

### Backend Setup

1. Clone the repository:  
    ```bash
    git clone https://github.com/NotSakura/Melofy.git
    cd Melofy/backend
    ```
2. Install dependencies:  
    ```bash
    npm install
    ```
3. Run the backend server:
   ```bash
   npm start
   ```
   The backend will be accessible at `http://localhost:3000`

Alternatively, you can use Docker:
```bash
docker build -t melofy-backend .
docker run -p 3000:3000 melofy-backend
```

### Frontend Setup

1. Navigate to the frontend directory:  
    ```bash
    cd Melofy/frontend
    ```
2. Install Flutter dependencies:  
    ```bash
    flutter pub get
    ```
3. Run on iOS (Mac required):  
    ```bash
    flutter run
    ```

---

## Video Demo

Please see a video of our demo here! https://drive.google.com/file/d/1dC92nqPM2BjWAphAa6QG_Z1vXc5LHSiQ/view?usp=sharing 

We’ve also added videos (split due to size constraints) in this repository available for download.
