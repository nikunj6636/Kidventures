import 'package:App/authentication_module/authen_main.dart';
import 'package:App/booking_module/booking.dart';
import 'package:App/profile/addChild.dart';
import 'package:flutter/material.dart';

import 'package:accordion/accordion.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:roundcheckbox/roundcheckbox.dart';

// Now we need to make a responsive app for this purpose
class MyListView extends StatefulWidget {
  final Centre centre;
  final int index;
  final int setIndex;
  MyListView(this.centre, this.index, this.setIndex, {Key? key})
      : super(key: key);
  @override
  State<MyListView> createState() => _MyList();
}

class _MyList extends State<MyListView> {

  
  int index = 0;
  Centre centre = Centre(center_name: '', address: '', distance: 0);
  int selectedindex = 0;
  @override
  void initState() {
    index = widget.index;
    centre = widget.centre;
    selectedindex = widget.setIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Row(
      children: [
        Text(centre.center_name),
        Radio<int>(
            value: index,
            groupValue: selectedindex,
            onChanged: (int? index) {
              selectedindex = (index == null ? 0 : index);
            }),
      ],
    ));
  }
}

class SelectCenter extends StatefulWidget {
  @override
  State<SelectCenter> createState() => _SelectCenter();
}

class Centre {
  final String center_name;
  final String address;
  final double distance;

  const Centre({
    // constructor function
    required this.center_name,
    required this.address,
    required this.distance,
  });
}

List<dynamic> list_of_centers = [];
List<bool> selected = [];

class _SelectCenter extends State<SelectCenter> {
  // A list that shows the centers
  int i = 2;
  int selectedindex = 0;

  Centre x = Centre(center_name: 'Dominos', 
  address: 'Gacchibowli Indra Market, Hyderabad', 
  distance: 2.334),
      y = Centre(center_name: 'DMart', address: 'SLN Terminus, Hyderabad Gacchibowli', distance: 0.223),
      z = Centre(center_name: 'Haldiram', address: 'India', distance: 6.51);

  @override
  void initState() {
    list_of_centers.add(x);
    list_of_centers.add(y);
    list_of_centers.add(z);

    // Main code
    list_of_centers.sort((a, b) {
      if (a.distance < b.distance) {
        return -1;
      } else if (a.distance > b.distance) {
        return 1;
      } else {
        return 0;
      }
    });
    for (int i = 0; i < list_of_centers.length; i++) {
      selected.add(false);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Choose Center'),
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Container(
                    child: Column(
          children: [
            Text(
              'Select Nearby Centers',
              style: TextStyle(
                  fontFamily: AutofillHints.name,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.purple),
            ),
            Column(
              children: list_of_centers.map((e) {
                return ListTile(
                  title: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.center_name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(e.address,
                              style: TextStyle(
                                color: Colors.grey,
                              )),
                          Text(
                            e.distance.toString() + ' km from your current location'),
                        ]),
                  ),
                  leading: Radio<int>(
                    splashRadius: 15,
                    hoverColor: Colors.yellow,
                    activeColor: Colors.green,
                    value: list_of_centers.indexOf(e),
                    groupValue: selectedindex,
                    onChanged: (int? value) {
                      setState(() {
                        selectedindex = value ?? 0;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            Text(''),
            ElevatedButton(onPressed: () {}, child: Text('Proceed To Payment')),
            Text(''),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Go Back')),
          ],
        )))),
        
      ),
    );
  }
}
