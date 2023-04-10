const express = require('express')
const router = express.Router() 

const Parent  = require('../Models/parent')
const Child  = require('../Models/child')

const bcrypt =  require('bcrypt') 
const nodemailer = require('nodemailer');


function distance(lat1,
                     lat2, lon1, lon2)
    {
   
        // The math module contains a function
        // named toRadians which converts from
        // degrees to radians.
        lon1 =  lon1 * Math.PI / 180;
        lon2 = lon2 * Math.PI / 180;
        lat1 = lat1 * Math.PI / 180;
        lat2 = lat2 * Math.PI / 180;
   
        // Haversine formula
        let dlon = lon2 - lon1;
        let dlat = lat2 - lat1;
        let a = Math.pow(Math.sin(dlat / 2), 2)
                 + Math.cos(lat1) * Math.cos(lat2)
                 * Math.pow(Math.sin(dlon / 2),2);
               
        let c = 2 * Math.asin(Math.sqrt(a));
   
        // Radius of earth in kilometers. Use 3956
        // for miles
        let r = 6371;
   
        // calculate the result
        return(c * r);
    }

// Now handle the location of the user
router.post('/nearest', async (request,response)=>{
    
    const centers = [
        {
            'Latitude' : 37.888,
            'Longtitude' : -122,
            'ID' : '1',

        },
        {
            'Latitude' : 38.76,
            'Longtitude' : -122.08,
            'ID' : '2',
        },
        {
            'Latitude' : 35.44,
            'Longtitude' : -121.76,
            'ID' : '3',

        },

    ]

    const latitude = request.body.latitude 
    const longtitude = request.body.longtitude

    let distances = [];
    for(let i = 0 ; i < centers.length ; i++)
    {
        let center = centers[i] 

        distances.push({
            'center' : center,
            'distance' : distance(center.Latitude,latitude,center.Longtitude,longtitude),
        })

    }

    distances.sort((a,b)=>{
        return a.distance - b.distance;
    })

    response.status(201).send(distances.slice(0,5)); 
})

module.exports = router;