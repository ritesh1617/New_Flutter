import 'package:flutter/material.dart';
import 'package:myapp2/screens/screen1.dart';
import 'package:myapp2/screens/screen2.dart';
import 'package:myapp2/screens/screen4.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:screen4() ,
             

    );
  }
}