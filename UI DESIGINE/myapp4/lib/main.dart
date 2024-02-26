
import 'package:flutter/material.dart';

void main(){
  runApp(myapp3());
}

class myapp3 extends StatelessWidget {
  const myapp3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(backgroundColor: Colors.black,title:Text("1200.00"),titleTextStyle: TextStyle(color: Colors.white), ),

        body: Column(
          children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 100,
                    width: 150,
                    color: Colors.red,
                    child: Center(child: Text("Load Mony")),
                  ),
                  Container(width: 5,),
                  Container(
                    height: 100,
                    width: 150,
                    color: Colors.blue,
                    child: Center(child: Text("Request Mony")),
                  ),
                ],
              ),
              Container(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 100,
                    width: 150,
                    color: Colors.purple,
                    child: Center(child: Text("Merchant Mony")),
                  ),
                  Container(width: 5,),
                  Container(
                    height: 100,
                    width: 150,
                    color: Colors.orange,
                    child: Center(child: Text("Send Mony")),
                  ),
                ],
              ),
              Container(height: 5,),
              Row(
                children: [
                  Container(
                    height: 100,
                    width:double.maxFinite,
                    color: Colors.pinkAccent,
                    child: Row(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text("Shell Drawen",style: TextStyle(color: Colors.white,fontSize:16),),
                        Text("Merchant Payment",style: TextStyle(color: Colors.white,fontSize:14),),
                        ],
                      ),
                      Container(width: 30,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(" -30",style: TextStyle(color: Colors.white,fontSize:16),),
                          Text("06/05/2019",style: TextStyle(color: Colors.white,fontSize:14),),
                        ],
                      )
                    ],),
                  )
                ],
              ),
              Container(height: 5,),
               Row(
                children: [
                  Container(
                    height: 100,
                    width: 305,
                    color: Colors.pinkAccent,
                    child: Row(children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Shell Drawen",style: TextStyle(color: Colors.white,fontSize:16),),
                          Text("Merchant Payment",style: TextStyle(color: Colors.white,fontSize:14),),
                        ],
                      ),
                      Container(width: 30,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(" -30",style: TextStyle(color: Colors.white,fontSize:16),),
                          Text("06/05/2019",style: TextStyle(color: Colors.white,fontSize:14),),
                        ],
                      )
                    ],),
                  )
                ],
              ),
          ],
        ),
        ),
    );
  }
}