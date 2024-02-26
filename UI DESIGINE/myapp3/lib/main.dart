
import 'package:flutter/material.dart';
import 'package:myapp3/screens/myhome.dart';
import 'package:myapp3/screens/screen2.dart';
import 'package:myapp3/screens/screen3.dart';
import 'package:myapp3/screens/screen4.dart';
import 'package:myapp3/screens/screen5.dart';
import 'package:myapp3/screens/screen6.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:screen3() ,
    );
  }
}