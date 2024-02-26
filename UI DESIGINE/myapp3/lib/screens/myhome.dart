
import 'package:flutter/material.dart';

class myhome extends StatefulWidget {
  const myhome({super.key});

  @override
  State<myhome> createState() => _myhomeState();
}

class _myhomeState extends State<myhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child:Column(
            children: [
               Container(
                height: 120,
                margin: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 1,
                  )
                  ),
                ),
                Container(
                height: 120,
                margin: EdgeInsets.all(14),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 1,
                  )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.yellowAccent,
                    ),
                    SizedBox(width: 10,),
                     Container(
                      height: 100,
                      width: 100,
                      color: Colors.pinkAccent,
                    ),
                    SizedBox(width: 10,),
                     Container(
                      height: 100,
                      width: 100,
                      color: Colors.greenAccent,
                    )
                  ],),
                ),
                Container(
                height: 120,
                margin: EdgeInsets.all(14),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 1,
                  )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.yellowAccent,
                    ),
                    SizedBox(width: 10,),
                     Container(
                      height: 100,
                      width: 100,
                      color: Colors.pinkAccent,
                    ),
                    SizedBox(width: 10,),
                     Container(
                      height: 100,
                      width: 100,
                      color: Colors.greenAccent,
                    )
                  ],),
                ),
                Container(
                height: 120,
                margin: EdgeInsets.all(14),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 1,
                  )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.yellowAccent,
                    ),
                    SizedBox(width: 10,),
                     Container(
                      height: 100,
                      width: 100,
                      color: Colors.pinkAccent,
                    ),
                    SizedBox(width: 10,),
                     Container(
                      height: 100,
                      width: 100,
                      color: Colors.greenAccent,
                    )
                  ],),
                ),
                Container(
                height: 120,
                margin: EdgeInsets.all(14),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 1,
                  )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.yellowAccent,
                    ),
                    Text("A"),
                     Container(
                      height: 100,
                      width: 100,
                      color: Colors.pinkAccent,
                    ),
                      Text("B"),
                     Container(
                      height: 100,
                      width: 100,
                      color: Colors.greenAccent,
                    )
                  ],),
                ),
                Container(
                height: 120,
                margin: EdgeInsets.all(14),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 1,
                  )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("A"),
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.yellowAccent,
                    ),
                    Text("B"),
                     Container(
                      height: 100,
                      width: 100,
                      color: Colors.pinkAccent,
                    ),
                      Text("C"),
                     Container(
                      height: 100,
                      width: 100,
                      color: Colors.greenAccent,
                    ),
                    Text("D"),
                  ],),
                ),
                Container(
                height: 120,
                margin: EdgeInsets.all(14),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 1,
                  )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("A"),
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.yellowAccent,
                    ),
                    Text("B"),
                     Container(
                      height: 100,
                      width: 100,
                      color: Colors.pinkAccent,
                    ),
                      Text("C"),
                     Container(
                      height: 100,
                      width: 100,
                      color: Colors.greenAccent,
                    ),
                    Text("D"),
                  ],),
                ),
                
          ] ,) ,
        ),
      ),
    );
  }
}