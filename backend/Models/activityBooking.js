const mongoose = require("mongoose");
const {ObjectId} = mongoose.Schema.Types;

const ActivityBookingSchema = new mongoose.Schema({

  // start time of the party
  drop_off_time: {
      type: Date,
      required: [true, "Please enter the drop_off_time of the activity"],
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
    required: [true, "Please enter the time of activity booking"],
  },

  // ID of the child enrolled in activities.
  childId: [{
    type: ObjectId,
    ref: "Child",
  }],

  // ID of the booked activities
  activityId: [{
    type: ObjectId,
    ref: "Activity",
  }],

  transactionId: {
    type: String,
    required: true,
  }
});

const PartyBooking = mongoose.model("ActivityBooking", ActivityBookingSchema);
module.exports = PartyBooking;