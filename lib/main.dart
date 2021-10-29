
import 'package:demo_file_manager/BLOC/home/DriverScreen.dart';
import 'package:demo_file_manager/BLOC/login/LoginScreen.dart';
import 'package:demo_file_manager/BLOC/welcome/WelcomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(DriverApp());
}

class DriverApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomeScreen(),
    );
  }
}
