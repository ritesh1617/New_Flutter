
import 'package:flutter/material.dart';

class myhome2 extends StatefulWidget {
  const myhome2({super.key});

  @override
  State<myhome2> createState() => _myhome2State();
}

class _myhome2State extends State<myhome2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.yellowAccent,
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.maxFinite,
              color: Colors.amber,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text("Row/Col",style: TextStyle(fontSize: 20),),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 1,
                    width: double.maxFinite,
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                        Text("Layout",style: TextStyle(fontSize: 20),),
                        Text("Main Axis Alignment",style: TextStyle(fontSize: 20),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                       Icon(Icons.arrow_back),
                       Text("Row",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                       Icon(Icons.arrow_forward),
                       Icon(Icons.arrow_back),
                       Text("Space\nAround",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                       Icon(Icons.arrow_forward),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    margin:EdgeInsets.all(10) ,
                    height: 1,
                    width: double.maxFinite,
                    color: Colors.black,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                        Text("Main Axix Size",style: TextStyle(fontSize: 20),),
                        Text("Main Axis Alignment",style: TextStyle(fontSize: 20),),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                       Icon(Icons.arrow_back),
                       Text("main",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                       Icon(Icons.arrow_forward),
                       Icon(Icons.arrow_back),
                       Text("Sterch",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                       Icon(Icons.arrow_forward),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.star_border_rounded,size: 40,),
                Icon(Icons.star_border_rounded,size: 70,),
                Icon(Icons.star_border_rounded,size: 40,),

              ],
            )
          ],
        ),
      ),
    );
  }
}