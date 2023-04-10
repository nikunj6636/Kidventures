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
            'Latitude' : 17.44215798501415,
            'Longtitude' : 78.35763801329668,
            'address' : 'Lingampally Road, Hyderabad - 500032',
            'ID' : 'CENTRE #1',

        },
        
        {
            'Latitude' :  17.443577315844962,
            'Longtitude' : 78.36605805461083,
            'address' : 'Mahabaleshwar clinics, Near Hehe road, Gachibowli Hyderabad 500031',
            'ID' : 'CENTRE #2',
        },
        
        {
            'Latitude' : 17.45009531328669,
            'Longtitude' :  78.33886021962053,
            'address' : 'Mujes, Kiess, Plot No 43 , Hehe Nagar, Hyderabad',
            'ID' : 'CENTRE #3',

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


    response.status(200).send(distances.slice(0,5)); 
})

module.exports = router;