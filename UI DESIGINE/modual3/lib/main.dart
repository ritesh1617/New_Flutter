import 'package:flutter/material.dart';
import 'package:modual3/Screens/12.dart';
import 'package:modual3/Screens/5.dart';
import 'package:modual3/Screens/screen1.dart';
import 'package:modual3/Screens/screen2.dart';
import 'package:modual3/Screens/screen3.dart';

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
      home: screen1(),
    );
  }
}

