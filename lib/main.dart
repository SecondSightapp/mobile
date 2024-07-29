import 'package:flutter/material.dart';
import 'package:secondsight/src/ui/screens/home.dart';
import 'package:secondsight/src/ui/screens/loading_screen.dart';

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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(56, 48, 115, 1)),
      ),
      // making this home for now for testing purposes, will be login page otherwise and should only go to homepage if logged in
      home: const LoadingScreen(),
    );
  }
}