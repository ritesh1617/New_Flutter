
import 'package:flutter/material.dart';
import 'package:ui1/screens/home2.dart';

class home1 extends StatefulWidget {
  const home1({super.key});

  @override
  State<home1> createState() => _home1State();
}

class _home1State extends State<home1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
        color: Colors.purpleAccent[100],
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20,top: 40),
              child: Row(
                children: [
                  Icon(Icons.arrow_back,color: Colors.white,size: 30,),
                  SizedBox(width: 50,),
                  Text("Create new Task",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: TextStyle(color: Colors.white),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Date",
                  labelStyle: TextStyle(color: Colors.white),
                  suffixIcon: Icon(Icons.date_range,color: Colors.white,),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)
                  )
                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              height: 560,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50))
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30,top: 40),
                    child: Row(
                      children: [
                        Container(
                          height: 100,
                          width: 150,
                          child: TextField(
                            decoration: InputDecoration(
                            labelText: "Date",
                           labelStyle: TextStyle(color: Colors.grey),
                           suffixIcon: Icon(Icons.alarm,color: Colors.grey,),
                          enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)
                    )
                                    ),
                          ),
                        ),
                        SizedBox(width: 40,),
                        Container(
                          height: 100,
                          width: 150,
                          child: TextField(
                            decoration: InputDecoration(
                            labelText: "Date",
                           labelStyle: TextStyle(color: Colors.grey),
                           suffixIcon: Icon(Icons.alarm,color: Colors.grey,),
                          enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)
                    )
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(16),
                              child: TextField(
                              decoration: InputDecoration(
                              labelText: "Description",
                             labelStyle: TextStyle(color: Colors.grey),
                            enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)
                      )
                                      ),
                            ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20,top: 10),
                    child: Row(
                      children: [
                        Text("Category",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 10,),
                      Container(
                        height: 50,
                        width: 80,
                        color: Colors.grey[100],
                        child: Center(child: Text("Marketing",)),
                      ),
                      Container(
                        height: 50,
                        width: 80,
                        color: Colors.grey[100],
                        child: Center(child: Text("Mettings",)),
                      ),
                      Container(
                        height: 50,
                        width: 80,
                        color: Colors.grey[100],
                        child: Center(child: Text("Study",)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right:10),
                        child: Container(
                          height: 50,
                          width: 80,
                          color: Colors.grey[100],
                          child: Center(child: Text("Sports",)),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: 10,),
                      Container(
                        height: 50,
                        width: 80,
                        color: Colors.grey[100],
                        child: Center(child: Text("Devlopment",)),
                      ),
                      Container(
                        height: 50,
                        width: 80,
                        color: Colors.grey[100],
                        child: Center(child: Text("Family",)),
                      ),
                      Container(
                        height: 50,
                        width: 80,
                        color: Colors.grey[100],
                        child: Center(child: Text("Urgent",)),
                      ),
                      
                    ],
                  ),
                  SizedBox(height: 40,),
                  Container(
                    margin: EdgeInsets.all(20),
                    height: 50,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(child:TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => home2(),));
                    }, child: Text("SUBMIT",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)) ),
                  )

                ],
              ),
            ),
          ],
        ),
       ),
      
    );
  }
}