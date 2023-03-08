import 'package:flutter/material.dart';
import 'package:hello_app/main.dart';
import 'package:intl/intl.dart';
import 'package:flat_3d_button/flat_3d_button.dart';

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

  // list of errors
  List<String> Errors = [
    'Email ID cannot be empty',
    'Password cannot be empty',
    'Confirmed Password and Password does not match',
  ];

  // Validate Sign In
  int validateSignIn(String username, String password) {
    if (username.length == 0) {
      return 0;
    }
    if (password.length == 0) {
      return 1;
    }

    return correct;
  }

  // Validate Sign Up #1
  int ValidateSignUp(
      String username, String password, String confirm_password) {
    if (username.length == 0) {
      return 0;
    }
    if (password.length == 0) {
      return 1;
    }
    if (password != confirm_password) {
      return 2;
    }

    return correct;
  }

  

  @override
  void initState() {
    username_signin.text = '';
    password_signin.text = '';

    username_signup.text = '';
    password_signup.text = '';
    confirm_password.text = '';

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

                Text(is_signin == true ? 'LOGIN PAGE' : 'SIGN IN PAGE',
                    style: TextStyle(
                      fontFamily: AutofillHints.name,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.purple,
                    )),

                // Buttons for toggling
                ButtonBar(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flat3dButton(
                      onPressed: () {
                        setState(() {
                          is_signin = true;
                        });
                      },
                      child: Text('Log In'),
                      color:
                          is_signin == true ? Colors.deepPurple : Colors.purple,
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
                ),

                // Form to take input from user ,
                // depends on log in or sign up

                is_signin == true
                    ? Container(
                        child: Column(
                          children: [
                            Container(
                                width: 200,
                                child: TextField(
                                  controller: username_signin,
                                  decoration: InputDecoration(
                                    labelText: 'Email ID',
                                    labelStyle: TextStyle(color: Colors.purple),
                                  ),
                                )),
                            Container(
                                width: 200,
                                child: TextField(
                                  controller: password_signin,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: TextStyle(color: Colors.purple),
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
                                                builder: (context) => MyApp()));
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
                                                        Navigator.of(context)
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
                                    labelStyle: TextStyle(color: Colors.purple),
                                  ),
                                )),
                            Container(
                                width: 200,
                                child: TextField(
                                  controller: password_signup,
                                  decoration: InputDecoration(
                                    labelText: 'Create A Password',
                                    labelStyle: TextStyle(color: Colors.purple),
                                  ),
                                )),
                            Container(
                                width: 200,
                                child: TextField(
                                  controller: confirm_password,
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    labelStyle: TextStyle(color: Colors.purple),
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
                                                        Navigator.of(context)
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
