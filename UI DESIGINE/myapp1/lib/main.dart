import 'package:flutter/material.dart';

void main(){
  runApp(myapp1());
}         

class myapp1 extends StatelessWidget {
  const myapp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text("Task 2"),
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),
        backgroundColor: Colors.yellow,),
    body: Container(
      height: double.maxFinite,
      width: double.maxFinite,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 100,
                width: 100,
                color: Colors.purpleAccent[100],
              ),
              Container(width: 10,),

              Container(
                height: 100,
                width: 100,
                color: Colors.pinkAccent[100],
              ),
               Container(width: 10,),
              Container(
                height: 100,
                width: 100,
                color: Colors.yellowAccent[100],
              ),
            ],
          ),
          Container(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 100,
                color: Colors.purpleAccent[100],
              ),
              Container(width: 10,),
              Container(
                height: 100,
                width: 100,
                color: Colors.pinkAccent[100],
              ),
              Container(width: 10,),
              Container(
                height: 100,
                width: 100,
                color: Colors.yellowAccent[100],
              ),
            ],
          ),
            Container(height: 10,),

           Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 100,
                width: 100,
                color: Colors.purpleAccent[100],
              ),
              Container(width: 10,),
              Container(
                height: 100,
                width: 100,
                color: Colors.pinkAccent[100],
              ),
              Container(width: 10,),
              Container(
                height: 100,
                width: 100,
                color: Colors.yellowAccent[100],
              ),
            ],
          ),
            Container(height: 10,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 100,
                width: 100,
                color: Colors.purpleAccent[100],
              ),
              Container(
                height: 100,
                width: 100,
                color: Colors.pinkAccent[100],
              ),
              Container(
                height: 100,
                width: 100,
                color: Colors.yellowAccent[100],
              ),
            ],
          ),
          Container(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 100,
                width: 100,
                color: Colors.purpleAccent[100],
              ),
              Container(
                height: 100,
                width: 100,
                color: Colors.pinkAccent[100],
              ),
              Container(
                height: 100,
                width: 100,
                color: Colors.yellowAccent[100],
              ),
            ],
          ),
          Container(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 100,
                width: 100,
                color: Colors.purpleAccent[100],
              ),
              Container(
                height: 100,
                width: 100,
                color: Colors.pinkAccent[100],
              ),
              Container(
                height: 100,
                width: 100,
                color: Colors.yellowAccent[100],
              ),
            ],
          ),
        ],

      ),
    ),

    ),
    );
  }
}