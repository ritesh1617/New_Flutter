
import 'package:flutter/material.dart';

class screen4 extends StatefulWidget {
  const screen4({super.key});

  @override
  State<screen4> createState() => _screen4State();
}

class _screen4State extends State<screen4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        child: Column(
          children: [
           Container(
            height: 150,
            width: double.maxFinite,
            color: Colors.amber,
            child: Column(
              children: [
                SizedBox(height: 10,),
                Text("Stack",style: TextStyle(color: Colors.black,fontSize: 20),),
                SizedBox(height: 20,),
                 Container(
                    height: 1,
                    width: double.maxFinite,
                    color: Colors.black,
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                        Text("Type",style: TextStyle(fontSize: 16),),
                        Text("Alignment",style: TextStyle(fontSize: 16),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                       Icon(Icons.arrow_back),
                       Text("align",style: TextStyle(fontSize: 16,),),
                       Icon(Icons.arrow_forward),
                       Icon(Icons.arrow_back),
                       Text("Top\nStart",style: TextStyle(fontSize: 16,),),
                       Icon(Icons.arrow_forward),
                    ],
                  ),
              ],
            ),
           ),
           Container(
            margin: EdgeInsets.all(40),
            height: 400,
            color: Colors.green,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 250,
                  width: 250,
                  color: Colors.yellow,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              ],
            ),
           )
        ],),
      ),
    );
  }
}