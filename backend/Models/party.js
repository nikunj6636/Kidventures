const mongoose = require("mongoose");
const {ObjectId} = mongoose.Schema.Types;

// Maximum duration of activity
let max = 5;

let arr = []

for(let i = 1 ; i <= max  ; i++){
  arr.push(i)
}

const PartySchema = new mongoose.Schema({
  drop_off_time: {
      type: Date,
      required: [true, "Please enter drop off time"]
  },
  duration: {
    type: Number,
    required: [true, "Please enter duration of the activity"],
    enum: arr
  },
  

  // ID of the parent who booked 
  parentId: {
    type: ObjectId,
    required: true,
    ref: "Parent"
  },

  children: 
    {
        type: Number,
        
        required : true,
    },

  adult: 
  {
    type: Number, 
    required : true,
  },
  
});

const Party = mongoose.model("Party", PartySchema);
module.exports = Party;