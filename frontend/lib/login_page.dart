import 'package:flutter/material.dart';
import 'package:hello_app/main.dart';
import 'package:intl/intl.dart';
import 'package:flat_3d_button/flat_3d_button.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyLoginPage();
}

class _MyLoginPage extends State<MyLoginPage> {
  // Boolean vairable to decide if we want to make the
  // login or the sign up page
  bool is_signin = true;

  bool is_otp = false;

  // Username and password for sign in case
  TextEditingController username_signin = TextEditingController();

  TextEditingController password_signin = TextEditingController();

  bool agree_signin = false;

  // Username and password for sign up case
  TextEditingController username_signup = TextEditingController();

  TextEditingController password_signup = TextEditingController();

  TextEditingController confirm_password = TextEditingController();

  bool agree_signup = false;

  // Might change it to some other correct integer if we want to
  int correct = 5;

  // OTP number for sign up purpose
  int generateOTP() {
    // Some method here

    return 123456;
  }

  // Actual OTP value
  int OTP = 123456;

  // OTP value entered by the user
  TextEditingController otp = TextEditingController();

  // list of errors
  List<String> Errors = [
    'Email ID cannot be empty',
    'Password cannot be empty',
    'Confirmed Password and Password does not match',
    'Invalid Email Address',
  ];

  // Validate Sign In
  bool validateEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  // Returns index of error
  int validateSignIn(String username, String password) {
    if (username.length == 0) {
      return 0;
    }
    if (validateEmail(username) == false) {
      return 3;
    }
    if (password.length == 0) {
      return 1;
    }

    return correct;
  }

  // Function that sends OTP
  void sendOTP() {
    return;
  }

  // Validate Sign Up #1
  int ValidateSignUp(
      String username, String password, String confirm_password) {
    if (username.length == 0) {
      return 0;
    }
    if (validateEmail(username) == false) {
      return 3;
    }
    if (password.length == 0) {
      return 1;
    }
    if (password != confirm_password) {
      return 2;
    }

    return correct;
  }

  // Duration
  Duration myDur = Duration(minutes : 5);

  @override
  void initState() {
    username_signin.text = '';
    password_signin.text = '';

    username_signup.text = '';
    password_signup.text = '';
    confirm_password.text = '';

    OTP = generateOTP();

    return;
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
                    child: Column(
              children: [
                // Padding from top hue hue
                Text('',
                    style: TextStyle(
                      fontFamily: AutofillHints.name,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.purple,
                    )),

                // Title

                Text(
                    is_otp == true
                        ? 'OTP PAGE'
                        : is_signin == true
                            ? 'LOGIN PAGE'
                            : 'SIGN IN PAGE',
                    style: TextStyle(
                      fontFamily: AutofillHints.name,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.purple,
                    )),

                // Buttons for toggling
                is_otp == false
                    ? ButtonBar(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flat3dButton(
                            onPressed: () {
                              setState(() {
                                is_signin = true;
                              });
                            },
                            child: Text('Log In'),
                            color: is_signin == true
                                ? Colors.deepPurple
                                : Colors.purple,
                          ),
                          Flat3dButton(
                            onPressed: () {
                              setState(() {
                                is_signin = false;
                              });
                            },
                            child: Text('Sign Up'),
                            color: is_signin == false
                                ? Colors.deepPurple
                                : Colors.purple,
                          )
                        ],
                      )
                    : SizedBox(),

                // Form to take input from user ,
                // depends on log in or sign up

                is_otp == true
                    ?
                    // OTP
                    Container(
                        child: Column(
                          children: [
                            Text(''),
                            Text('Enter The OTP that is sent to ' +
                                username_signup.text +
                                ':'),
                            Container(
                                width: 200,
                                child: TextField(
                                  controller: otp,
                                  decoration: InputDecoration(
                                    labelText: 'OTP',
                                    labelStyle: TextStyle(color: Colors.purple),
                                  ),
                                )),
                            Text('Session will expire in: ',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),),
                            Text(''),
                            TimerCountdown(
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
                                                            MyLoginPage()));
                                              })
                                        ],
                                      );
                                    });
                              },
                            ),
                            ElevatedButton(
                              onPressed: () {
                                String res = OTP.toString();
                                if (res == otp.text) {
                                  // Redirect to the Profile Page
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyApp()));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('OTP validation failed'),
                                          content: Text('Invalid OTP'),
                                          actions: [
                                            OutlinedButton(
                                                child: Text('OK'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              MyLoginPage()));
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
                                    MaterialStatePropertyAll<Color>(
                                        Colors.indigo),
                              ),
                            ),
                            Text(''),
                            Text(''),
                            FloatingActionButton.extended(
                                backgroundColor: Colors.purple,
                                foregroundColor: Colors.white,
                                label: Text('Request Another OTP'),
                                onPressed: () {
                                  
                                  setState(() {
                                    OTP = generateOTP();
                                  });
                                  sendOTP();
                                  setState(() {
                                    myDur = Duration(minutes : 5);
                                  });
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title:
                                              Text('OTP Regeneration Request'),
                                          content: Text(
                                              'OTP has been successfully sent to your email\n.'),
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
                    : is_signin == true
                        ? Container(
                            child: Column(
                              children: [
                                Container(
                                    width: 200,
                                    child: TextField(
                                      controller: username_signin,
                                      decoration: InputDecoration(
                                        labelText: 'Email ID',
                                        labelStyle:
                                            TextStyle(color: Colors.purple),
                                      ),
                                    )),
                                Container(
                                    width: 200,
                                    child: TextField(
                                      controller: password_signin,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        labelStyle:
                                            TextStyle(color: Colors.purple),
                                      ),
                                    )),
                                Text(''),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                          value: agree_signin,
                                          onChanged: (value) {
                                            setState(() {
                                              agree_signin = value ?? false;
                                              return;
                                            });
                                          }),
                                      Text(
                                        "By Logging in to the App, I agree to\n the terms and conditions.",
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                      ),
                                    ]),
                                Text(''),
                                ElevatedButton(
                                  onPressed: agree_signin == true
                                      ? () {
                                          int res = validateSignIn(
                                              username_signin.text,
                                              password_signin.text);
                                          if (res == correct) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyApp()));
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        'Error During Sign In'),
                                                    content: Text(Errors[res]),
                                                    actions: [
                                                      OutlinedButton(
                                                          child: Text('OK'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          })
                                                    ],
                                                  );
                                                });
                                            return;
                                          }
                                        }
                                      : null,
                                  child: Text('Login'),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                            Colors.green),
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(
                            child: Column(
                              children: [
                                Container(
                                    width: 200,
                                    child: TextField(
                                      controller: username_signup,
                                      decoration: InputDecoration(
                                        labelText: 'Email ID',
                                        labelStyle:
                                            TextStyle(color: Colors.purple),
                                      ),
                                    )),
                                Container(
                                    width: 200,
                                    child: TextField(
                                      controller: password_signup,
                                      decoration: InputDecoration(
                                        labelText: 'Create A Password',
                                        labelStyle:
                                            TextStyle(color: Colors.purple),
                                      ),
                                    )),
                                Container(
                                    width: 200,
                                    child: TextField(
                                      controller: confirm_password,
                                      decoration: InputDecoration(
                                        labelText: 'Confirm Password',
                                        labelStyle:
                                            TextStyle(color: Colors.purple),
                                      ),
                                    )),
                                Text(''),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                          value: agree_signup,
                                          onChanged: (value) {
                                            setState(() {
                                              agree_signup = value ?? false;
                                              return;
                                            });
                                          }),
                                      Text(
                                        "By Signing up on the App, I agree\nto the terms and conditions.",
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                      ),
                                    ]),
                                Text(''),
                                ElevatedButton(
                                  onPressed: agree_signup == true
                                      ? () {
                                          int res = ValidateSignUp(
                                              username_signup.text,
                                              password_signup.text,
                                              confirm_password.text);
                                          if (res == correct) {
                                            sendOTP();
                                            setState(() {
                                              is_otp = true;
                                            });

                                            return;
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        'Error During Sign Up'),
                                                    content: Text(Errors[res]),
                                                    actions: [
                                                      OutlinedButton(
                                                          child: Text('OK'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          })
                                                    ],
                                                  );
                                                });
                                            return;
                                          }
                                        }
                                      : null,
                                  child: Text('Create An Account'),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                            Colors.green),
                                  ),
                                )
                              ],
                            ),
                          ),
              ],
            )))));
  }
}
