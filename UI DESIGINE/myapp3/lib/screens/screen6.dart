import 'package:flutter/material.dart';

class screen6 extends StatefulWidget {
  const screen6({super.key});

  @override
  State<screen6> createState() => _screen6State();
}

class _screen6State extends State<screen6> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Center(child: Text("Padding")),
      ),
      body: Container(
        child: Column(children: [
                Container(
                  height: 20,
                  width: double.maxFinite,
                  color: Colors.greenAccent[100],
                ),
                Container(
                  height: 40,
                  width: double.maxFinite,
                  color: Colors.green,
                  child: Center(child: Text("FIRST",style: TextStyle(color: Colors.white,fontSize: 20),)),
                ),
                Container(
                  height: 20,
                  width: double.maxFinite,
                  color: Colors.greenAccent[100],
                ),
                Container(
                  height: 20,
                  width: double.maxFinite,
                  color: Colors.redAccent[100],
                ),
                Container(
                  height: 40,
                  width: double.maxFinite,
                  color: Colors.red,
                    child: Center(child: Text("Scecond",style: TextStyle(color: Colors.white,fontSize: 20),)),

                ),
                Container(
                  height: 20,
                  width: double.maxFinite,
                  color: Colors.redAccent[100],
                ),
                Container(
                  height: 40,
                  width: double.maxFinite,
                   child: Center(child: Text("50 ft",style: TextStyle(color: Colors.black,fontSize: 24),)),
                ),
                Container(
                  height: 20,
                  width: double.maxFinite,
                  color: Colors.blueAccent[100],
                ),
                Container(
                  height: 40,
                  width: double.maxFinite,
                  color: Colors.blue,
                   child: Center(child: Text("THIRD",style: TextStyle(color: Colors.white,fontSize: 20),)),
                ),
                Container(
                  height: 20,
                  width: double.maxFinite,
                  color: Colors.blueAccent[100],
                ),
                Container(
                  height: 40,
                  width: double.maxFinite,
                  child: Center(child: Text("Flex : 1",style: TextStyle(color: Colors.black,fontSize: 24),)),
                ),
                Container(
                  height: 20,
                  width: double.maxFinite,
                  color: Colors.purpleAccent[100],
                ),
                Container(
                  height: 40,
                  width: double.maxFinite,
                  color: Colors.purple,
                  child: Center(child: Text("FOURTH",style: TextStyle(color: Colors.white,fontSize: 20),)),
                ),
                Container(
                  height: 20,
                  width: double.maxFinite,
                  color: Colors.purpleAccent[100],
                ),
                Container(
                  height: 60,
                  width: double.maxFinite,
                  child: Center(child: Text("Flex : 2",style: TextStyle(color: Colors.black,fontSize: 24),)),
                ),
                Container(
                  height: 20,
                  width: double.maxFinite,
                  color: Colors.blueGrey[100],
                ),
                Container(
                  height: 40,
                  width: double.maxFinite,
                  color: Colors.lightBlue,
                   child: Center(child: Text("FIFTH",style: TextStyle(color: Colors.white,fontSize: 20),)),
                ),
                Container(
                  height: 20,
                  width: double.maxFinite,
                  color: Colors.blueGrey[100],
                ),

        ],),
      ),
    );
  }
}