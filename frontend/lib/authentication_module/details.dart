import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:App/routes.dart';

class DetailsPage extends StatefulWidget {
  final String email;
  final String password;

  DetailsPage(this.email, this.password, {Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPage();
}

class _DetailsPage extends State<DetailsPage> {
  TextEditingController name = TextEditingController();

  TextEditingController phoneno = TextEditingController();

  List<String> Errors = [
    'Name cannot be empty',
    'Phone number contains digits from 0-9',
    'Phone number must be of 10 digits',
  ];

  int signup = 3;

  Future<int> validateInfo(String name, String phone) async {
    if (name.length == 0)
      return 0;
    else if (num.tryParse(phone) == null)
      return 1;
    else if (phone.length != 10)
      return 2;
    else {
      final response = await http.post(
<<<<<<< HEAD
        Uri.parse('http://10.1.128.246:5000/parent/signup'),
=======
        Uri.parse('http://192.168.122.1:5000/parent/signup'),
>>>>>>> 3a419d8300b56d668f6c57f66fb9d393eab69542
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'email': widget.email,
          'password': widget.password,
          'name': name,
          'mobile_no': int.parse(phone),
        }),
      );

      if (response.statusCode == 200) {
        return signup;
      } else {
        throw Exception('Failed to connect to server');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Authentication Page'),
            ),
            body: SingleChildScrollView(
                child: Center(
                    child: Column(children: [
              SizedBox(
                height: 20,
              ),
              Text('Personal Info',
                  style: TextStyle(
                    fontFamily: AutofillHints.name,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.purple,
                  )),
              Container(
                child: Column(children: [
                  Container(
                      child: Column(
                    children: [
                      Container(
                          width: 200,
                          child: TextField(
                            controller: name,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: TextStyle(color: Colors.purple),
                            ),
                          )),
                      Container(
                          width: 200,
                          child: TextField(
                            controller: phoneno,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              labelStyle: TextStyle(color: Colors.purple),
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            validateInfo(name.text, phoneno.text).then((value) {
                          if (value == signup) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage(
                                          widget.email,
                                        )));
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Error'),
                                    content: Text(Errors[value]),
                                    actions: [
                                      OutlinedButton(
                                          child: Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          })
                                    ],
                                  );
                                });
                          }
                        }),
                        child: Text('Signup'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.green),
                        ),
                      )
                    ],
                  ))
                ]),
              )
            ])))));
  }
}
