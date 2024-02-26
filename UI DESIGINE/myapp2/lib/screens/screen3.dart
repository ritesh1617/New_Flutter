import 'package:flutter/material.dart';

class Home_Page extends StatelessWidget {
  var fname;
  var lname;
   Home_Page({super.key,required this.fname,required this.lname});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Text("Your Full Name is:- $fname $lname ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),

              ],
            ),
          )
        ],
      ),
    );
  }
}