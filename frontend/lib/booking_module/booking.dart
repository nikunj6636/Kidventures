import 'package:flutter/material.dart';
import 'package:flat_3d_button/flat_3d_button.dart';
import 'location.dart';
import 'activity.dart';
import 'party.dart';

class MyBookingModule extends StatefulWidget {
  final String email;
  MyBookingModule(this.email, {Key? key}) : super(key: key);

  @override
  State<MyBookingModule> createState() => _MyBookingModule();
}

class _MyBookingModule extends State<MyBookingModule> {
  // Initialized variables
  bool party_booking = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text(''), // Adds padding from top

        Text(party_booking == true ? 'PARTY BOOKING' : 'ACTIVITY BOOKING',
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
              color: party_booking == false ? Colors.deepPurple : Colors.purple,
            ),
            Flat3dButton(
              onPressed: () {
                setState(() {
                  party_booking = true;
                });
              },
              child: Text('PARTY'),
              color: party_booking == true ? Colors.deepPurple : Colors.purple,
            )
          ],
        ),

        SizedBox(
          height: 10,
        ),

        party_booking
            ? MyPartyModule(widget.email)
            : MyActivityModule(widget.email),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LocationPage()));
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
            mouseCursor:
                MaterialStatePropertyAll<MouseCursor>(MouseCursor.defer),
          ),
        )
      ]),
    );
  }
}
