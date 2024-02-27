
import 'package:flutter/material.dart';

class home_screen extends StatelessWidget {
  var name;

  home_screen({super.key,required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:CrossAxisAlignment.center,
            children: [
            Text("$name")
          ],),
        ),
      ),
    );
  }
}