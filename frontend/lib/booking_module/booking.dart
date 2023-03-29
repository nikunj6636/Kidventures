import 'package:flutter/material.dart';
import 'package:App/main.dart';
import 'package:flat_3d_button/flat_3d_button.dart';

import 'activity.dart';
import 'party.dart';

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
              child: Column(children: [
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

                SizedBox(
                  height: 10,
                ),

                party_booking
                    ? MyPartyModule(widget.email)
                    : MyActivityModule(
                        widget.Name, widget.Age, widget.Gender, widget.email)
              ]),
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
                        builder: (context) => MyApp(widget.email)));
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
        ));
  }
}
