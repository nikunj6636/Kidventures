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
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text('Authentication Page'),
            ),
            body:
                // SingleChildScrollView(
                // child:
                Container(
                    child: Center(
                        child: Column(children: [
              SizedBox(
                height: 40,
              ),
              Text(is_signin ? 'LOGIN PAGE' : 'SIGN UP PAGE',
                  style: TextStyle(
                    fontFamily: AutofillHints.name,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.purple,
                  )),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(
                        Theme.of(context).buttonTheme.minWidth * 1.5,
                        Theme.of(context).buttonTheme.height,
                      )),
                      backgroundColor: is_signin == true
                          ? MaterialStatePropertyAll<Color>(Color(0xFFD3D3D3))
                          : MaterialStatePropertyAll<Color>(Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        is_signin = true;
                      });
                    },
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors
                            .black, // Replace with your desired font color
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(
                        Theme.of(context).buttonTheme.minWidth * 1.5,
                        Theme.of(context).buttonTheme.height,
                      )), // Set the height of the button from the theme
                      backgroundColor: is_signin == false
                          ? MaterialStatePropertyAll<Color>(Color(0xFFD3D3D3))
                          : MaterialStatePropertyAll<Color>(Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        is_signin = false;
                      });
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors
                            .black, // Replace with your desired font color
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                  child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    if (value == 0) {
                      is_signin = true;
                    } else {
                      is_signin = false;
                    }
                  });
                  print(value);
                },
                children: <Widget>[
                  SignInPage(),
                  SignUpPage(),
                ],
              )),

              // Buttons for toggling
              // ButtonBar(
              //   mainAxisSize: MainAxisSize.min,
            ]))
                    // )
                    )));
  }
}
