
import 'package:flutter/material.dart';
import 'package:myapp4/screen1.dart';

void main(){
  runApp(myapp3());
}

class myapp3 extends StatelessWidget {
  const myapp3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    home: screen(),
    );
  }
}