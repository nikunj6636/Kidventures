import 'package:flutter/material.dart';
import 'package:App/main.dart';
import 'package:intl/intl.dart';
import 'package:flat_3d_button/flat_3d_button.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:multiselect/multiselect.dart';

class MyActivityModule extends StatefulWidget {
  final String email;
  final List<String> Name;
  final List<String> Age;
  final List<String> Gender;
  MyActivityModule(this.Name, this.Age, this.Gender, this.email, {Key? key})
      : super(key: key);

  @override
  State<MyActivityModule> createState() => _MyActivityModule();
}

class _MyActivityModule extends State<MyActivityModule> {
  // Initialized variables

  // String
  String email = '';

  // List of children
  List<String> Name = [];
  List<String> Age = [];
  List<String> Gender = [];

  // List of selected children
  List<String> selected = [];

  // For the Activity Booking Part
  TextEditingController drop_time_activity = TextEditingController();

  List<int> time_available = [];
  int max_available = 5;
  TextEditingController duration_activity = TextEditingController();
  String? duration = '1';

  // For the Party Booking Part
  TextEditingController start_time_party = TextEditingController();

  @override
  void initState() {
    // init the state
    email = widget.email;
    Name = widget.Name;
    Age = widget.Age;
    Gender = widget.Gender;

    // Available time
    for (int i = 1; i <= 5; i++) {
      time_available.add(i);
    }

    print("Activity Booking");
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('Select Children',
          style: TextStyle(
            fontFamily: AutofillHints.name,
            fontSize: 20,
            color: Colors.purple,
          )),

      // Select using multiselect

      Container(
        width: 200,
        child: DropDownMultiSelect(
            options: Name,
            selectedValues: selected,
            onChanged: (value) {
              setState(() {
                selected = value;
                return;
              });
            }),
      ),

      Text(''),

      Container(
        width: 200,
        // Activity Booking
        child: Column(
          children: [
            // Drop Off Time
            TextField(
              controller: drop_time_activity,
              decoration: InputDecoration(
                icon: Icon(Icons.timer),
                labelText: 'Select Drop Off Time',
              ),
              readOnly: true,
              onTap: () async {
                TimeOfDay? time = await showTimePicker(
                    context: context, initialTime: TimeOfDay.now());
                if (time != null) {
                  setState(() {
                    drop_time_activity.text = time.format(context).toString();
                    print(drop_time_activity.text);
                    return;
                  });
                } else {
                  setState(() {
                    drop_time_activity.text =
                        TimeOfDay.now().format(context).toString();
                    return;
                  });
                  return;
                }
              },
            ),
            Row(
              children: [
                Text('Duration: ',
                    style: TextStyle(
                      fontSize: 20,
                    )),
                DropdownButton(
                    icon: Icon(Icons.keyboard_arrow_down),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    value: duration.toString(),
                    items: time_available.map((e) {
                      return DropdownMenuItem(
                          value: e.toString(),
                          child: Text(e.toString() + ' hours'));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        duration = value.toString();
                      });
                    }),
              ],
            ),
          ],
        ),
      )
    ]);
  }
}
