import 'package:App/authentication_module/authen_main.dart';
import 'package:App/booking_module/booking.dart';
import 'package:flutter/material.dart';
import 'package:App/booking_module/location.dart';

void main() {
  runApp(MyApp());
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
          AuthenticationPage(), // start with authentication module and navigate to MainPage
    );
  }
}
