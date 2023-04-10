const mongoose = require("mongoose");
const {ObjectId} = mongoose.Schema.Types;

const CenterSchema = new mongoose.Schema({

  // Name of the center
  name: {
    type: String,
    required: true,
  },

  // address of the center
  address: {
    type: String,
    required: true,
  },

  // latitude of center
  latitude: {
    type: Schema.Types.Decimal128,
    required: true,
  },

  // longitude of center
  longitude: {
    type: Schema.Types.Decimal128,
    required: true,
  },

  // array of max bookings of each activity
  max_bookings: [{
    type: Number,
  }],

  // array of ObjectId of future bookings of the activity
  activity_bookings: [{
    type: ObjectId,
    ref: "ActivityBooking",
  }],

  // array of ObjectId of future party bookings
  party_bookings: [{
    type: ObjectId,
    ref: "PartyBooking",
  }],
});

const Center = mongoose.model("Center", CenterSchema);
module.exports = Center;