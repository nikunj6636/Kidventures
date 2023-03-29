const mongoose = require("mongoose");
const {ObjectId} = mongoose.Schema.Types;

// Maximum duration of activity
let max = 5;

let arr = []

for(let i = 1 ; i <= max  ; i++){
  arr.push(i)
}


const ActivitySchema = new mongoose.Schema({
  drop_off_time: {
      type: Date,
      required: [true, "Please enter drop off time"]
  },
  duration: {
    type: Number,
    required: [true, "Please enter duration of the activity"],
    enum: arr
  },
  parentId: {
    type: ObjectId,
    required: true,
    ref: "Parent"
  },
  childId: [  // array of child_id
    {
        type: ObjectId,
        ref: "Child"
    }
  ]
});

const Activity = mongoose.model("Activity", ActivitySchema);
module.exports = Activity;