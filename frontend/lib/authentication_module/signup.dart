import 'package:App/authentication_module/otp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  int signup = 5; // is returned when user is authenticated

  bool agree = false;

  // list of errors
  List<String> Errors = [
    'Email ID cannot be empty',
    'Password cannot be empty',
    'Invalid Email Address',
    'Password and Confirm Password Does not match',
    'Email Already Exists',
  ];

  bool validateEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  Future<int> validateSignUp(
      String username, String password, String confirmPassword) async {
    if (username.length == 0)
      return 0;
    else if (password.length == 0)
      return 1;
    else if (!validateEmail(username))
      return 2;
    else if (password != confirmPassword) return 3;

    final response = await http.post(
      Uri.parse('http://localhost:5000/parent/checkemail'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': username,
      }),
    );

    if (response.statusCode == 200) {
      // email and password created, redirect to OTP page
      return signup;
    } else if (response.statusCode == 400) {
      // email already exists
      return 4;
    } else {
      // error connecting to database
      throw Exception("Database connection failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Container(
            width: 200,
            child: TextField(
              controller: username,
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
                labelText: 'Create A Password',
                labelStyle: TextStyle(color: Colors.purple),
              ),
            )),
        Container(
            width: 200,
            child: TextField(
              obscureText: true,
              controller: confirmPassword,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                labelStyle: TextStyle(color: Colors.purple),
              ),
            )),
        Text(''),
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
            "By Signing up on the App, I agree\nto the terms and conditions.",
            softWrap: true,
          ),
        ]),
        Text(''),
        ElevatedButton(
          onPressed: agree == true
              ? () {
                  validateSignUp(
                          username.text, password.text, confirmPassword.text)
                      .then((res) {
                    if (res == signup) {
                      // redirect to the OTP page
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  OTPPage(username.text, password.text)));
                      return;
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Error During Sign Up'),
                              content: Text(Errors[res]),
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
          child: Text('Create An Account'),
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
          ),
        )
      ],
    ));
  }
}
