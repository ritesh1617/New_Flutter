import 'dart:math';

import 'package:flutter/material.dart';

class screen5 extends StatefulWidget {
  const screen5({super.key});

  @override
  State<screen5> createState() => _screen5State();
}

class _screen5State extends State<screen5> {

 Color bgcolor=Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: bgcolor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                setState(() {
                  bgcolor=Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0).withOpacity(1.0);
                });
              }, child: Text("Change Baground Color")),
              
          ],),
        ),
      ),
    );
  }
}