import 'package:flutter/material.dart';
import 'package:App/main.dart';
import 'package:intl/intl.dart';
import 'package:flat_3d_button/flat_3d_button.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:multiselect/multiselect.dart';

class MyPartyModule extends StatefulWidget {
  final String email;

  MyPartyModule(this.email, {Key? key}) : super(key: key);

  @override
  State<MyPartyModule> createState() => _MyPartyModule();
}

class _MyPartyModule extends State<MyPartyModule> {
  // email
  String email = '';

  // For Party Booking
  TextEditingController start_time_party = TextEditingController();

  // Available time hours

  List<int> time_available = [];
  int max_available = 3;
  TextEditingController duration_party = TextEditingController();
  String duration = '1';

  // number of adults in the party

  int adults = 0;
  bool edit_adults = false;
  int adults_err = 0;
  // error 1 for alphabetical number of adults, 2 for range error

  TextEditingController number_adults = TextEditingController();

  void updateAdults(String n_adults) {
    setState(() {
      if (num.tryParse(n_adults) == null) {
        adults_err = 1;
      } else if (int.parse(n_adults) > 10) {
        adults_err = 2;
      } else {
        adults_err = 0;
        adults = int.parse(n_adults);
        edit_adults = false;
      }
    });
  }

  // number of children in the party

  int children = 0;
  bool edit_children = false;
  int children_err = 0;
  // error 1 for alphabetical number of children, 2 for range error

  TextEditingController number_children = TextEditingController();

  void updatechildren(String n_children) {
    setState(() {
      if (num.tryParse(n_children) == null) {
        children_err = 1;
      } else if (int.parse(n_children) > 20) {
        children_err = 2;
      } else {
        children_err = 0;
        children = int.parse(n_children);
        edit_children = false;
      }
    });
  }

  @override
  void initState() {
    // init the state
    email = widget.email;

    // Available time
    for (int i = 1; i <= 5; i++) {
      time_available.add(i);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          width: edit_adults == false ? 160 : 120,
          child: TextField(
            controller: number_adults,
            enabled: edit_adults,
            decoration: InputDecoration(
                labelText: edit_adults == false ? "Adults" : '',
                errorText: adults_err == 1
                    ? 'Please enter a valid number'
                    : (adults_err == 2
                        ? 'Number of adults cant exceed 10'
                        : ''),
                hintStyle: TextStyle(color: Colors.blue),
                hintText: "Enter number of adults"),
          ),
        ),
        edit_adults == false
            ? IconButton(
                onPressed: () {
                  setState(() {
                    edit_adults = true;
                  });
                },
                icon: Icon(Icons.edit),
              )
            : IconButton(
                onPressed: () {
                  updateAdults(number_adults.text);
                },
                icon: Icon(Icons.done)),
        edit_adults == false
            ? SizedBox()
            : IconButton(
                onPressed: () {
                  setState(() {
                    number_adults.text = adults.toString();
                    edit_adults = false;
                  });
                },
                icon: Icon(Icons.cancel_outlined))
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          width: edit_children == false ? 160 : 120,
          child: TextField(
            controller: number_children,
            enabled: edit_children,
            decoration: InputDecoration(
                labelText: edit_children == false ? "children" : '',
                errorText: children_err == 1
                    ? 'Please enter a valid number'
                    : (children_err == 2
                        ? 'Number of children cant exceed 10'
                        : ''),
                hintStyle: TextStyle(color: Colors.blue),
                hintText: "Enter number of children"),
          ),
        ),
        edit_children == false
            ? IconButton(
                onPressed: () {
                  setState(() {
                    edit_children = true;
                  });
                },
                icon: Icon(Icons.edit),
              )
            : IconButton(
                onPressed: () {
                  updatechildren(number_children.text);
                },
                icon: Icon(Icons.done)),
        edit_children == false
            ? SizedBox()
            : IconButton(
                onPressed: () {
                  setState(() {
                    number_children.text = children.toString();
                    edit_children = false;
                  });
                },
                icon: Icon(Icons.cancel_outlined))
      ]),
      Center(
        child: Container(
          // Party Booking Time
          width: 250,
          child: Column(
            children: [
              TextField(
                controller: start_time_party,
                decoration: InputDecoration(
                  icon: Icon(Icons.timer),
                  labelText: 'Select start time of the party',
                ),
                readOnly: true,
                onTap: () async {
                  TimeOfDay? time = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());

                  if (time != null) {
                    setState(() {
                      start_time_party.text = time.format(context).toString();
                      print(start_time_party.text);
                      return;
                    });
                  } else {
                    setState(() {
                      start_time_party.text =
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
                      color: Colors.black,
                    ),
                    value: duration.toString(),
                    items: time_available.map((e) {
                      return DropdownMenuItem(
                          value: e.toString(),
                          child: Text(
                              e.toString() + (e > 1 ? ' hours' : ' hour')));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        duration = value.toString();
                      });
                    }),
              ],
            ),
            Text(''),
      ElevatedButton(
      onPressed: (){

      },
      child: Text(
        'Find Centres Nearby',
      style: TextStyle(
        fontSize: 20,
        fontFamily: AutofillHints.name,
        color: Colors.white,
        ),
        ),
      
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
          mouseCursor:  MaterialStatePropertyAll<MouseCursor>(MouseCursor.defer),
        ),),
            ],
          ),
        ),
      )
    ]);
  }
}
