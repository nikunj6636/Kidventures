import 'package:flutter/material.dart';
import 'package:App/routes.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  int authenticated = 5; // is returned when user is authenticated

  bool agree = false;

  // list of errors
  List<String> Errors = [
    'Email ID cannot be empty',
    'Password cannot be empty',
    'Invalid Email Address',
    'Invalid User Credentials',
  ];

  bool validateEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  Future<int> validateSignIn(String email, String password) async {
    if (email.length == 0)
      return 0;
    else if (password.length == 0)
      return 1;
    else if (!validateEmail(email))
      return 2;
    else {
      final response = await http.post(
        Uri.parse('http://10.1.128.246:5000/parent/signin'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return authenticated;
      } else if (response.statusCode == 403) {
        // invalid credentials
        return 3;
      } else {
        // error connecting with database
        throw Exception('Failed to connect to server');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Container(
            child: Column(
          children: [
            Container(
                width: 200,
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    labelText: 'Email ID',
                    labelStyle: TextStyle(color: Colors.purple),
                  ),
                )),
            Container(
                width: 200,
                child: TextField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.purple),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Checkbox(
                  value: agree,
                  onChanged: (value) {
                    setState(() {
                      agree = value ?? false;
                      return;
                    });
                  }),
              Text(
                "By Logging in to the App, I agree to\n the terms and conditions.",
                softWrap: true,
              ),
            ]),
            Text(''),
            ElevatedButton(
              onPressed: agree
                  ? () {
                      validateSignIn(email.text, password.text).then((value) {
                        if (value == authenticated) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage(
                                        email.text, // email here
                                      )));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Error During Sign In'),
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
                          return;
                        }
                      });
                    }
                  : null,
              child: Text('Login'),
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
              ),
            )
          ],
        ))
      ]),
    );
  }
}
