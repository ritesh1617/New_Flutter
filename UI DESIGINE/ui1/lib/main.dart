import 'dart:html';

import 'package:flutter/material.dart';
import 'package:ui1/screens/home.dart';
import 'package:ui1/screens/home1.dart';
import 'package:ui1/screens/home2.dart';
import 'package:ui1/screens/screen1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: scrren1(),
    );
  }
}

