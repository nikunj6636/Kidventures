import 'package:App/authentication_module/signin.dart';
import 'package:App/authentication_module/signup.dart';
import 'package:flutter/material.dart';
import 'package:flat_3d_button/flat_3d_button.dart';

class AuthenticationPage extends StatefulWidget {
  AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPage();
}

class _AuthenticationPage extends State<AuthenticationPage> {
  // decide to signin / signup

  bool is_signin = true;

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

              Text(is_signin ? 'LOGIN PAGE' : 'SIGN UP PAGE',
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
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors
                            .white, // Replace with your desired font color
                      ),
                    ),
                    color:
                        is_signin == true ? Colors.deepPurple : Colors.purple,
                  ),
                  Flat3dButton(
                    onPressed: () {
                      setState(() {
                        is_signin = false;
                      });
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors
                            .white, // Replace with your desired font color
                      ),
                    ),
                    color:
                        is_signin == false ? Colors.deepPurple : Colors.purple,
                  )
                ],
              ),
              is_signin ? SignInPage() : SignUpPage(),
            ])))));
  }
}
