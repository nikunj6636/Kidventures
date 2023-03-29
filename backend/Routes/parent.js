const express = require('express')
const router = express.Router() 

const Parent  = require('../Models/parent')

const bcrypt =  require('bcrypt') 
const nodemailer = require('nodemailer');
const { request, response } = require('express');

router.post('/checkemail',async (request,response)=>{
  const userExists = await Parent.findOne({email: request.body.email}); // conition here
  try{
    if(userExists){
      response.status(400).send({exists: false});
    }
    else {
      response.status(200).send({exists: false});
    }
  }
  catch(exception){
    response.status(404).send(exception);
  }
})

router.post('/signup',async (request,response)=>{ // storing a new "user" in the database

  const salt = await bcrypt.genSalt(10);
  const hashPassword = await bcrypt.hash(request.body.password, salt);
  request.body.password = hashPassword;

  const user = new Parent(request.body);
  try {
    await user.save(); 
    response.status(200).send({message: "User created"});
  } catch (error) {
    response.status(400).send(error);
  }

})

router.post("/signin", async (request, response) => { 
    const user = await Parent.findOne({email: request.body.email}); // conition here
    try{
      if (!user) {
        response.status(403).send({ message: "Email does not exist"});
        return;
      }

      const cmp = await bcrypt.compare(request.body.password, user.password);
      if (cmp === false){
        response.status(403).send({ meassage: "Incorrect password"});
        return;
      }
      response.status(200).send({message: "User authenticated successfully"}); // response in {accessToken: __} object is passed
    }
  
    catch(err){
      response.send(err).status(404);
    }
  });

  
router.post("/sendOTP", async (request, response) => { 

  var transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: 'nikunjproject6@gmail.com',
      pass: 'bvuxycfgcitqpsbp'
    }
  });

  const OTP = Math.floor(Math.random() * 1000000);  // random 6 digit number generated
  
  var mailOptions = {
    from: 'nikunjproject6@gmail.com',
    to: request.body.email,
    subject: 'Email verification of the App',
    text: 'OTP to verify your accout is: ' + OTP.toString(),
  };
  
  transporter.sendMail(mailOptions, function(error, info){
    if (error) {
      response.status(400).send({message: "Error sending the email"});
    } else {
      response.status(200).send({OTP: OTP});
    }
  });
});


router.post("/profile", async (request, response) => { // get the profile of the user
  const user = await Parent.findOne({email: request.body.email});
  try {
    response.status(200).send(user); 
  } catch (error) {
    response.status(400).send(error);
  }
});


router.put("/update/profile", async (request, response) => { // get the profile of the user
  const user = await Parent.updateOne({email: request.body.email}, {$set: request.body});
  try {
    response.status(200).send(user); 
  } catch (error) {
    response.status(400).send(error);
  }
});

module.exports = router 