import 'package:App/booking_module/select_center.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

import 'package:App/profile/profile.dart' show Child;
import 'location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyActivityModule extends StatefulWidget {
  final String email;

  MyActivityModule(this.email, {Key? key}) : super(key: key);

  @override
  State<MyActivityModule> createState() => _MyActivityModule();
}

class _MyActivityModule extends State<MyActivityModule> {
  // List of children
  List<Child> children = [];

  // Name of the selected children
  List<String> selected = [];

  TextEditingController drop_time_activity = TextEditingController();

  static List<int> time_available = [
    1,
    2,
    3,
    4,
    5
  ]; // available duration of activity
  int duration = 1; // make sure it is an element of list

  // List of activities
  List<String> activities = [
    'Origami',
    'Painting',
    'Story telling',
  ];

  // object id of the chosen activities
  List<String> chosen_activities = [];

  // Boolean for testing
  bool ch = false;

  Future<void> fetchChild() async {
    final response = await http.post(
      Uri.parse('http://10.1.128.246:5000/parent/children'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': widget.email,
      }),
    );

    if (response.statusCode == 200) {
      final array =
          jsonDecode(response.body); // array of children(json objects)

      setState(() {
        for (int i = 0; i < array.length; i++) {
          final elem = array[i];
          final child = new Child(
              name: elem["name"],
              DOB: elem["date_of_birth"],
              gender: elem["gender"]);
          children.add(child);
        }

        ch = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchChild();
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
      ch == true
          ? Container(
              width: 250,
              child: DropDownMultiSelect(
                options: children.map((child) => child.name).toList(),
                selectedValues: selected, // array of selected chuldren
                onChanged: (value) {
                  setState(() {
                    selected = value;
                  });
                },
                whenEmpty: 'Select children',
              ),
            )
          : CircularProgressIndicator(),

      Text(''),

      Container(
        width: 250,
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
            Text(''),

            Row(
              children: [
                Text('Select Duration: ',
                    style: TextStyle(
                      fontSize: 20,
                    )),
                DropdownButton(
                    icon: Icon(Icons.keyboard_arrow_down),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepPurple,
                    ),
                    value: duration.toString(),
                    items: time_available.map((elem) {
                      return DropdownMenuItem(
                          value: elem.toString(),
                          child: Text(elem.toString() +
                              (elem > 1 ? ' hours' : ' hour')));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        duration = int.parse(
                            value ?? '1'); // to return a non nullable string
                      });
                    }),
              ],
            ),
          ],
        ),
      ),

      Text(''),
      Text('Select Activities: ',
          style: TextStyle(
            fontFamily: AutofillHints.name,
            fontSize: 20,
            color: Colors.purple,
          )),
      Container(
        width: 250,
        child: DropDownMultiSelect(
          options: activities,
          selectedValues: chosen_activities,
          onChanged: (value) {
            setState(() {
              chosen_activities = value;
              return;
            });
          },
          whenEmpty: 'Select required Activities',
        ),
      ),
      Text(''),

      ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LocationPage()));
        },
        child: Text(
          'Find Centers Nearby',
          style: TextStyle(
            fontSize: 20,
            fontFamily: AutofillHints.name,
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
          mouseCursor: MaterialStatePropertyAll<MouseCursor>(MouseCursor.defer),
        ),
      ),
    ]);
  }
}
