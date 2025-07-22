const admin = require("firebase-admin");
const serviceAccount = require("./melofy-service-account.json"); 

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://melofy-50892.firebaseio.com"
});

const db = admin.firestore();
module.exports = { admin, db };
