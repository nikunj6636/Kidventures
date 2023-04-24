const express = require('express')
const router = express.Router() 

const Activity  = require('../Models/activity')
const Booking = require('../Models/activityBooking')
const Party = require('../Models/partyBooking')

router.post('/getPrice', async (req, res) => {
    let {activity_name} = req.body;
    // console.log(activity_name)
    const activity_price = await Activity.findOne({name:activity_name})
    try {
        console.log(activity_price)
        res.status(200).json(activity_price); 
    } catch (error) {
        console.log(activity_price)
        res.status(400).json(error);
    }
})

router.post('/confirmBooking', async (req, res) => {
    let {dropOffTime, duration, parentEmail, centerId, childrenString, activityString, center_address, bookingDate} = req.body;
    // console.log(activity_name)
    dropOffTime = bookingDate + " " + dropOffTime;
    childrenString = childrenString[0];
    activityString = activityString[0];
    const activityInstance = new Booking({
        dropOffTime:dropOffTime,
        duration:duration,
        parentEmail:parentEmail,
        bookingTime: Date.now(),
        childName:childrenString,
        activityName:activityString,
        centerName: center_address,
    })
    try {
        await activityInstance.save();
        res.status(200).send({message: "Booking confirmed"});
        console.log(activityInstance);
    }
    catch (error) {
        res.status(400).send(error);
        console.log(error);
    }
})

router.post('/confirmParty', async (req, res) => {
    let {startTime, duration, parentEmail, centerAddress,children, adult, bookingDate} = req.body;
    startTime = bookingDate + " " + startTime;
    const partyInstance = new Party({
        startTime:startTime,
        duration:duration,
        parentEmail:parentEmail,
        centerAddress: centerAddress,
        bookingTime: Date.now(),
        adults:adult,
        children:children,
    })
    console.log(partyInstance);
    try {
        await partyInstance.save();
        res.status(200).send({message: "Booking confirmed"});
        // console.log(activityInstance);
    }
    catch (error) {
        res.status(400).send(error);
        console.log(error);
    }
})

module.exports = router