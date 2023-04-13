import 'package:App/authentication_module/authen_main.dart';
import 'package:App/authentication_module/login_page.dart';
import 'package:App/authentication_module/otp.dart';
import 'package:App/booking_module/booking.dart';
import 'package:flutter/material.dart';
import 'package:App/booking_module/location.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: [
    SystemUiOverlay.bottom,
    SystemUiOverlay.top,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Booking App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue), // Colors.fromRGB(0,0,255)
      ),
      home:
          // AuthenticationPage(),
          HomePage('amanrajmathematics@gmail.com',''), // start with authentication module and navigate to MainPage
    );
  }
}
