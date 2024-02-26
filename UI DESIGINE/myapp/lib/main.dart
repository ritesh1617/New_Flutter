
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: Text("Task 1"),titleTextStyle: TextStyle(fontWeight: FontWeight.bold),),
        body: Container(
          color: Colors.white,
          height: double.maxFinite,
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 400,
                width: 400,
                color: Colors.black87,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container( 
                      height: 290,
                      width: 100,
                      color: Colors.red,
                      child: Center(child: Text("child 1",style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                    Container(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container( 
                          height: 140,
                          width: 100,
                          color: Colors.green,
                           child: Center(child: Text("child 2",style: TextStyle(fontWeight: FontWeight.bold))),
                        ),
                        Container(height: 10,),
                        Container( 
                      height: 140,
                      width: 100,
                      color: Colors.blue,
                       child: Center(child: Text("child 3",style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                      ],
                    ),
                    
                  ],
                ),
              ),
            ],
          )),
      ),
    );
  }
}