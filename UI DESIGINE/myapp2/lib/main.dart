
import 'package:flutter/material.dart';

void main(){
  runApp( myapp2 ());
}

class myapp2 extends StatelessWidget {
  const myapp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Task 3"),backgroundColor: Colors.grey,elevation: 10,),
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          color: Colors.white,
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               Column(
                children: [
                  Container(
                    height: 60,
                    width: 300,
                    color: Colors.green,
                  ),
                  Container(height: 5,),
                  Row(
                    children: [
                    Container(
                    height: 60,
                    width: 100,
                    color: Colors.blue,
                  ),
                  Container(width: 5,),
                  Container(
                    height: 60,
                    width: 190,
                    color: Colors.red,
                  ),
                    ],
                  ),
                   Container(height: 5,),
                  Row(
                    children: [
                      Container(
                          height: 200,
                          width: 300,
                          color: Colors.purpleAccent,
                      ),
                    ],
                  ),
                  Container(height: 5,), 
                  Row(
                    children: [
                      Container(
                          height: 150,
                          width: 300,
                          color: Colors.blueAccent,
                      ),
                    ],
                  ),
                ],
               ),
               Column(
                children: [
                  Row(
                    children: [
                      Container(
                          height: 150,
                          width: 300,
                          color: Colors.purpleAccent,
                      ),
                    ],
                  ),
                  Container(height: 10,),
                  Row(
                    children: [
                      Container(
                        height: 150,
                        width: 190,
                        color: Colors.greenAccent,
                      ),
                      Container(width: 10,),
                      Column(
                        children: [
                          Container(
                        height: 50,
                        width: 100,
                        color: Colors.blueAccent,
                      ),
                      Container(height: 10,),
                      Container(
                        height: 90,
                        width: 100,
                        color: Colors.redAccent,
                      ),
                        ],
                      ),
                    ],
                  ),
                   Container(height: 5,),
                   Row(
                    children: [
                      Container(
                          height: 150,
                          width: 300,
                          color: Colors.green,
                      ),
                    ],
                  ),
                ],
               ),
               Column(
                 children: [
                   Row(
                        children: [
                          Container(
                            height: 300,
                            width: 190,
                            color: Colors.greenAccent,
                          ),
                          Container(width: 10,),
                          Column(
                            children: [
                              Container(
                            height: 90,
                            width: 100,
                            color: Colors.blueAccent,
                          ),
                          Container(height: 10,),
                          Container(
                            height: 200,
                            width: 100,
                            color: Colors.redAccent,
                          ),
                            ],
                          ),
                        ],
                      ),
                       Container(height: 5,),
                      Row(
                    children: [
                      Container(
                          height: 150,
                          width: 300,
                          color: Colors.purpleAccent,
                      ),
                    ],
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