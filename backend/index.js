const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());

// Auth routes
app.use('/api/auth/signup', require('./routes/auth/signUp'));
app.use('/api/auth/signin', require('./routes/auth/signIn'));
app.use('/api/auth/logout', require('./routes/auth/logOut'));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});


const updateProfile = require('./routes/users/updateProfile');
app.use('/api/users', updateProfile);
