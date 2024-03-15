import 'package:flutter/material.dart';
import 'package:modual3/Screens/12.dart';
import 'package:modual3/Screens/Q5/5.dart';
import 'package:modual3/Screens/Q4/4.dart';
import 'package:modual3/Screens/Q1/screen2.dart';
import 'package:modual3/Screens/Q2/screen3.dart';
import 'package:modual3/Screens/Q6/6.dart';
import 'package:modual3/Screens/Q7/7.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:CheckboxExample(),
    );
  }
}

