
import 'package:flutter/material.dart';

class screen3 extends StatefulWidget {
  const screen3({super.key});

  @override
  State<screen3> createState() => _screen3State();
}

class _screen3State extends State<screen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Column(
          children: [
            Text("1200.00",style: TextStyle(color: Colors.white,),),
            Text("Balance USD",style: TextStyle(color: Colors.white,fontSize:12)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
             child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(12),
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search,color: Colors.white,size: 40,),
                          SizedBox(height: 10,),
                          Text("LOAD MONEY",style: TextStyle(color: Colors.white,),)
                        ],
                      ),
                    ),
                  Container(
                  margin: EdgeInsets.all(12),
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                   child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.request_page,color: Colors.white,size: 40,),
                          SizedBox(height: 10,),
                          Text("REQUEST MONEY",style: TextStyle(color: Colors.white,),)
                        ],
                      ),
                )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(12),
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.purpleAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.print,color: Colors.white,size: 40,),
                          SizedBox(height: 10,),
                          Text("MARCHENT MONEY",style: TextStyle(color: Colors.white,),)
                        ],
                      ),
                    ),
                  Container(
                  margin: EdgeInsets.all(12),
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                   child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image,color: Colors.white,size: 40,),
                          SizedBox(height: 10,),
                          Text("SEND MONEY",style: TextStyle(color: Colors.white,),)
                        ],
                      ),
                )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(12),
                      height: 100,
                      width: 430,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:Colors.pinkAccent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(360),
                          color:Colors.amber,
                      ),
                            child: Icon(Icons.search,size: 30,color: Colors.white,),
                            ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Text("Shell Darwen",style: TextStyle(color: Colors.white,fontSize: 20),),
                          SizedBox(height: 4,),
                          Text("Marchent Payment",style: TextStyle(color: Colors.white,fontSize: 12),)
                            ],
                          ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text("-30",style: TextStyle(color: Colors.white,fontSize: 20),),
                        SizedBox(height: 4,),
                        Text("06/05/2019",style: TextStyle(color: Colors.white,fontSize: 12),)
                      ],
                    )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(12),
                      height: 100,
                      width: 430,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:Colors.pinkAccent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(360),
                              color:Colors.amber,
                            ),
                            child: Icon(Icons.print,size: 30,color: Colors.white,),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Shell Darwen",style: TextStyle(color: Colors.white,fontSize: 20),),
                              SizedBox(height: 4,),
                              Text("Marchent Payment",style: TextStyle(color: Colors.white,fontSize: 12),)
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("-30",style: TextStyle(color: Colors.white,fontSize: 20),),
                              SizedBox(height: 4,),
                              Text("06/05/2019",style: TextStyle(color: Colors.white,fontSize: 12),)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(12),
                      height: 100,
                      width: 430,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:Colors.pinkAccent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(360),
                              color:Colors.amber,
                            ),
                            child: Icon(Icons.search,size: 30,color: Colors.white,),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Shell Darwen",style: TextStyle(color: Colors.white,fontSize: 20),),
                              SizedBox(height: 4,),
                              Text("Marchent Payment",style: TextStyle(color: Colors.white,fontSize: 12),)
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("-30",style: TextStyle(color: Colors.white,fontSize: 20),),
                              SizedBox(height: 4,),
                              Text("06/05/2019",style: TextStyle(color: Colors.white,fontSize: 12),)
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(12),
                      height: 100,
                      width: 430,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:Colors.pinkAccent,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(360),
                              color:Colors.amber,
                            ),
                            child: Icon(Icons.search,size: 30,color: Colors.white,),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Shell Darwen",style: TextStyle(color: Colors.white,fontSize: 20),),
                              SizedBox(height: 4,),
                              Text("Marchent Payment",style: TextStyle(color: Colors.white,fontSize: 12),)
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("-30",style: TextStyle(color: Colors.white,fontSize: 20),),
                              SizedBox(height: 4,),
                              Text("06/05/2019",style: TextStyle(color: Colors.white,fontSize: 12),)
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
             ),
        ),
      ),
    );
  }
}