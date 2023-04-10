const express = require("express");
const mongoose = require("mongoose");
const cors = require('cors');

const app = express();

// For cross-origin-reference

require("dotenv").config({ path: "./config.env" });
const port = process.env.PORT || 5000;

app.use(cors()); // allows request from any origin
app.use(express.json());

mongoose.set('strictQuery', false);

const uri = "mongodb+srv://nikunjgarg6636:nikunj6636@cluster0.4lmgshd.mongodb.net/BookingApp?retryWrites=true&w=majority"

mongoose.connect( uri , { useNewUrlParser: true, useUnifiedTopology: true })
    .then(() => {
        console.log("Mongoose Connected");
    }).catch((error) => {
        console.log("Mongoose not connected");
        console.log(error);
    });

// routes

app.use("/parent/", require("./Routes/parent"));

app.listen(port, () => {
  console.log("Server is running at port", port);
});




// if(navigator.geolocation){
// navigator.geolocation.getCurrentPosition((position)=>{
//     const latitude = position.coords.latitude
//     const longtitude = position.coords.longitude 
//     console.log(latitude,longtitude);
// },(error)=>{
//     console.log(error)
// });
// }