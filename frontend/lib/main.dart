import 'package:App/authenticationModule/authenMain.dart';
import 'dart:convert';
import 'package:App/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

var emailtext = '';
var passwordtext = '';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const storage = FlutterSecureStorage();
  emailtext = await storage.read(key: "KEY_USERNAME") ?? '';
  passwordtext = await storage.read(key: "KEY_PASSWORD") ?? '';

  final response = await http.post(
      Uri.parse('http://10.1.134.42:5000/parent/signin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': emailtext,
        'password': passwordtext,
      }),
    );

  if(response.statusCode == 200) {
      runApp(const ProfileApp());
    }
    else {
      runApp(const MyApp());
    }
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const AuthenticationPage(),
    );
  }
}

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Booking App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: ProfilePage(emailtext),
    );
  }
}