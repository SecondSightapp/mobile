import 'package:flutter/material.dart';
import 'package:secondsight/src/ui/screens/home.dart';
import 'package:secondsight/src/ui/screens/login.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // making this home for now for testing purposes, will be login page otherwise and should only go to homepage if logged in
      home: const HomePage(),
    );
  }
}