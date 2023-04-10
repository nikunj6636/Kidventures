const mongoose = require("mongoose");
const {ObjectId} = mongoose.Schema.Types;

const PartyBookingSchema = new mongoose.Schema({

  // start time of the party
  start_off_time: {
      type: Date,
      required: [true, "Please enter the start time of the party"],
  },

  // duration of the party
  duration: {
    type: Number,
    required: [true, "Please enter duration of Party"],
  },
  
  // ID of the parent who booked
  parentId: {
    type: ObjectId,
    required: true,
    ref: "Parent",
  },
  
  // ID of the booked center
  centerId: {
    type: ObjectId,
    required: true,
    ref: "Center",
  },

  // store the time of booking
  booking_time: {
    type: Date,
    required: [true, "Please enter the tiem of party booking"],
  },

  // number of adults in the party
  adults: {
    type: Number, 
    required : true,
  },

  // number of children in party
  children: {
    type: Number, 
    required : true,
  },
  
  // transactionid of the party
  transactionId: {
    type: String,
    required: true,
  }
});

const PartyBooking = mongoose.model("PartyBooking", PartyBookingSchema);
module.exports = PartyBooking;