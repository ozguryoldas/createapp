import 'package:flutter/material.dart';
import 'package:attendence_app/FrontScreen/loginSignup.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Attendance"),
          ),
          body: const LoginSignUp(),
        )
    );
  }
}