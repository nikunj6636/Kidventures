import 'package:flutter/material.dart';
import 'package:App/main.dart';
import 'package:intl/intl.dart';
import 'package:flat_3d_button/flat_3d_button.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:multiselect/multiselect.dart';

class MyBookingModule extends StatefulWidget {
  final String email;
  final List<String> Name;
  final List<String> Age;
  final List<String> Gender;
  MyBookingModule(this.Name, this.Age, this.Gender, this.email, {Key? key})
      : super(key: key);

  @override
  State<MyBookingModule> createState() => _MyBookingModule();
}

class _MyBookingModule extends State<MyBookingModule> {
  // Initialized variables
  bool party_booking = false;

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
    email = widget.email;
    Name = widget.Name;
    Age = widget.Age;
    Gender = widget.Gender;

    // Available time
    for (int i = 1; i <= 5; i++) {
      time_available.add(i);
    }

    print("Inside booking module");
    print(Name);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Booking'),
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          // Body
          child: Center(
            child: Column(
              children: [
                Text(''), // Adds padding from top

                Text(
                    party_booking == true
                        ? 'PARTY BOOKING'
                        : 'ACTIVITY BOOKING',
                    style: TextStyle(
                      fontFamily: AutofillHints.name,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.purple,
                    )),

                ButtonBar(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flat3dButton(
                      onPressed: () {
                        setState(() {
                          party_booking = false;
                        });
                      },
                      child: Text('ACTIVITY'),
                      color: party_booking == false
                          ? Colors.deepPurple
                          : Colors.purple,
                    ),
                    Flat3dButton(
                      onPressed: () {
                        setState(() {
                          party_booking = true;
                        });
                      },
                      child: Text('PARTY'),
                      color: party_booking == true
                          ? Colors.deepPurple
                          : Colors.purple,
                    )
                  ],
                ),
                Text(''),
                // Main body of the app
                // Select children is common for them
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
                party_booking == false
                    ? Container(
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
                                    context: context,
                                    initialTime: TimeOfDay.now());

                                if (time != null) {
                                  setState(() {
                                    drop_time_activity.text =
                                        time.format(context).toString();
                                    print(drop_time_activity.text);
                                    return;
                                  });
                                } else {
                                  setState(() {
                                    drop_time_activity.text = TimeOfDay.now()
                                        .format(context)
                                        .toString();
                                    return;
                                  });
                                  return;
                                }
                              },
                            ),
                            
                            Row(
                              
                              children: [
                                Text('Duration: '
                                ,
                                style : TextStyle( 
                                  fontSize: 20,
                                )),
                                DropdownButton(
                                  
                              icon: Icon(Icons.keyboard_arrow_down),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                value : duration.toString(),
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
                    : Container(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              label: 'Previous Bookings',
              icon: Icon(Icons.work_history_sharp),
            ),
            BottomNavigationBarItem(
              label: 'Book A Center',
              icon: Icon(Icons.bookmark_border),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.people),
            )
          ],
          currentIndex: 1,
          onTap: (int index) {
            if (index == 2) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyApp(Name, Age, Gender, email)));
              return;
            }
            if (index == 1) {
              return;
            }
            if (index == 0) {
              return;
            }
            setState(() {});
          },
        ),
      ),
    );
  }
}
