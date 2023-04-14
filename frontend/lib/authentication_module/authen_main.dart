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

  bool isSignIn = true;
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            body:
                Container(
                    child: Center(
                        child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(
                        Theme.of(context).buttonTheme.minWidth * 1.5,
                        Theme.of(context).buttonTheme.height,
                      )),
                      backgroundColor: isSignIn == true
                          ? MaterialStatePropertyAll<Color>(Color(0xFFD3D3D3))
                          : MaterialStatePropertyAll<Color>(Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        isSignIn = true;
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
                      backgroundColor: isSignIn == false
                          ? MaterialStatePropertyAll<Color>(Color(0xFFD3D3D3))
                          : MaterialStatePropertyAll<Color>(Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        isSignIn = false;
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
              Flexible(
                  fit: FlexFit.loose,
                  child: PageView(
                    controller: controller,
                    onPageChanged: (value) {
                      setState(() {
                        if (value == 1) {
                          isSignIn = true;
                        } else {
                          isSignIn = false;
                        }
                      });
                      print(value);
                    },
                    children: <Widget>[
                      // SignInPage(),
                      // SignUpPage(),
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
