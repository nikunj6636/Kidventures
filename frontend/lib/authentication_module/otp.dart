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
      Uri.parse('http://10.1.128.246:5000/parent/sendOTP'),
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
                          Navigator.push(
                              // Redirect to the Personal Details Page
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

// Create an input widget that takes only one digit

class HomePage extends StatefulWidget {
  final String username;
  final String password;
  const HomePage(this.username, this.password, {Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 4 text editing controllers that associate with the 4 input fields
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();

  int OTP = 0;

  // Add timer to page
  Duration myDur = Duration(minutes: 2);

  bool stop_timer = false;

  // This is the entered code
  // It will be displayed in a Text widget
  String? _otp;

  // Email
  String email = '';
  String passw = '';

  Future<void> sendOTP() async {
    // send OTP to email and fetch it from backend
    final response = await http.post(
      Uri.parse('http://10.1.128.246:5000/parent/sendOTP'),
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
    email = widget.username;
    passw = widget.password;
    sendOTP();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Email ID Verification',
              style: TextStyle(
                fontFamily: AutofillHints.birthday,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(
            height: 30,
          ),
          Text('Enter the OTP sent to ' + email,
              style: TextStyle(
                fontFamily: AutofillHints.birthday,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          // Implement 4 input fields
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OtpInput(_fieldOne, true), // auto focus
              OtpInput(_fieldTwo, false),
              OtpInput(_fieldThree, false),
              OtpInput(_fieldFour, false),
              OtpInput(_fieldFive, false),
              OtpInput(_fieldSix, false),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  _otp = _fieldOne.text +
                      _fieldTwo.text +
                      _fieldThree.text +
                      _fieldFour.text +
                      _fieldFive.text +
                      _fieldSix.text;
                  // stop_timer = !stop_timer;
                });
                if (_otp == OTP.toString()) {
                  setState(() {
                    stop_timer = true;
                  });
                  Navigator.push(
                      // Redirect to the Personal Details Page
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailsPage(widget.username, widget.password)));
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('OTP validation failed'),
                          content: Text('Sorry, but OTP validation failed!!!'),
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
              child: const Text('Submit')),
          const SizedBox(
            height: 30,
          ),
          stop_timer == false ? Text('OTP will expire in: ') : SizedBox(),
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
              setState(() {
                _otp = _fieldOne.text +
                    _fieldTwo.text +
                    _fieldThree.text +
                    _fieldFour.text +
                    _fieldFive.text +
                    _fieldSix.text;

                // stop_timer = !stop_timer;
              });
              setState(() {
                myDur = Duration(minutes: 2);
                stop_timer = false;
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
            },
            child: const Text('Request Another OTP',
                style: TextStyle(
                  color: Colors.black,
                )),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll<Color>(Colors.lightBlue),
            ),
          ),
          // Display the entered OTP code
          Text(
            _otp?.length == 6 ? '' : 'Please enter OTP',
            style: const TextStyle(fontSize: 30),
          )
        ],
      ),
    );
  }
}

// Create an input widget that takes only one digit
class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  const OtpInput(this.controller, this.autoFocus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 50,
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            counterText: '',
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0)),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
