import 'package:App/authentication_module/authen_main.dart';
import 'package:App/authentication_module/details.dart';
import 'package:flutter/material.dart';
import 'package:App/main.dart';

import 'package:http/http.dart' as http;
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'dart:convert';

class OTPPage extends StatefulWidget {
  final String username;
  final String password;
  OTPPage(this.username, this.password, {Key? key}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPage();
}

class _OTPPage extends State<OTPPage> {
  int OTP = 0;
  TextEditingController OTPField = TextEditingController();
  Duration myDur = Duration(minutes: 2);

  bool stop_timer = false;

  Future<void> sendOTP() async {
    // send OTP to email and fetch it from backend
    final response = await http.post(
      Uri.parse('http://localhost:5000/parent/sendOTP'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': widget.username,
      }),
    );
    if (response.statusCode == 200) {
      OTP = jsonDecode(response.body)["OTP"];
    } else {
      throw Exception("OTP not sent");
    }
  }

  @override
  void initState() {
    super.initState();
    sendOTP();
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
                height: 10,
              ),
              Text('OTP PAGE',
                  style: TextStyle(
                    fontFamily: AutofillHints.name,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.purple,
                  )),
              Container(
                child: Column(
                  children: [
                    Text(''),
                    Text('Enter The otp_field that is sent to ' +
                        widget.username +
                        ':'),
                    Container(
                        width: 200,
                        child: TextField(
                          obscureText: true,
                          controller: OTPField,
                          maxLength: 6,
                          decoration: InputDecoration(
                            labelText: 'OTP',
                            labelStyle: TextStyle(color: Colors.purple),
                          ),
                        )),
                    Text(
                      'Session will expire in: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    Text(''),
                    stop_timer == false
                        ? TimerCountdown(
                            endTime: DateTime.now().add(myDur),
                            format: CountDownTimerFormat.minutesSeconds,
                            onEnd: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Session Timeout'),
                                      content: Text(
                                          'Oops! Looks like your session has expired.'),
                                      actions: [
                                        OutlinedButton(
                                            child: Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AuthenticationPage()));
                                            })
                                      ],
                                    );
                                  });
                            },
                          )
                        : SizedBox(),
                    ElevatedButton(
                      onPressed: () {
                        if (OTP.toString() == OTPField.text) {
                          setState(() {
                            stop_timer = true;
                          });
                          Navigator.push( // Redirect to the Personal Details Page
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                      widget.username, widget.password)));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('OTP validation failed'),
                                  content: Text('Invalid OTP_field'),
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
                      },
                      child: Text('Verify OTP'),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.indigo),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    FloatingActionButton.extended(
                        backgroundColor: Colors.purple,
                        foregroundColor: Colors.white,
                        label: Text('Request Another OTP'),
                        onPressed: () {
                          setState(() {
                            myDur = Duration(minutes: 2);
                          });
                          sendOTP();
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('OTP Regeneration Request'),
                                  content: Text(
                                      'OTP has been successfully sent to your email\n'),
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
                        })
                  ],
                ),
              )
            ])))));
  }
}
