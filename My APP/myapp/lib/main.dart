
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/screens/Auth/login.dart';
import 'package:get/get_navigation/get_navigation.dart';


void main(){
  runApp(const MyApp());   
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}