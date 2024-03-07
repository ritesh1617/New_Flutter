
import 'package:flutter/material.dart';

class home2 extends StatefulWidget {
  const home2({super.key});

  @override
  State<home2> createState() => _home2State();
}

class _home2State extends State<home2> {

 final List name=[
   "Ritesh",
   "Rahul",
   "Jay",

 ];  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: name.length,
        itemBuilder:(context,int ind){
        return Card(
          color: Colors.green,
               child: Text("${name[ind]}"),
        );

      },
    )
    );
  }
}