const express = require('express')
const router = express.Router() 

const Activity  = require('../Models/activity')

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

module.exports = router