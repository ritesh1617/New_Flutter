

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class screen1 extends StatefulWidget {
  const screen1({super.key});

  @override
  State<screen1> createState() => _screen1State();
}

class _screen1State extends State<screen1> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: Icon(Icons.arrow_back)),
            Container(
               height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              child: Icon(Icons.search)),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 180),
                      child: Container(
                        child: Text("Restaurent",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),
                        )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                            color: Colors.grey[400],
                            borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(child: Text("20-30 Min"))),
                            SizedBox(width: 10,),
                             Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(child: Text("2-4km"))),
                             SizedBox(width: 10,),
                      
                             Container(
                            height: 30,
                            width: 100,
                            decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(child: Text("Restaurent"))),
                        ],
                      ),
                    )
                  ],
                ),
                Flexible(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(child: Text("R",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),)),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(child: Text("orange sandwiches is delicious",style: TextStyle(fontWeight: FontWeight.bold),)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.star,color: Colors.amber,),
                      Text("4.7",style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                )
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Scrollbar(
                 child: Row(
                   children: [
                     Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(child: Text("Recomennded")),),
                      SizedBox(width: 10,),
                       Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(child: Text("Popular")),),
                      SizedBox(width: 10,), 
                     Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(child: Text("Noodels")),),
                      SizedBox(width: 10,),
                      Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(child: Text("pizza")),),
                      SizedBox(width: 10,),
                       Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(child: Text("Burger")),),
                       SizedBox(width: 10,),
                      Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15)
                      ),
                      child: Center(child: Text("Soup")),),
                   ],
                 )),
            ),
            Container(
              margin: EdgeInsets.all(16),
              height: 150,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage("assets/SOUP.jpg"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40,right: 60),
                  child: Column(
                    children: [
                      Text("Soba Soup",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      Text("No1.in sales",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 16),),
                      Text("Rs.120",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:110),
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],),
            ),
             Container(
              margin: EdgeInsets.all(16),
              height: 150,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage("assets/SOUP.jpg"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40,right: 60),
                  child: Column(
                    children: [
                      Text("Soba Soup",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      Text("No1.in sales",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 16),),
                      Text("Rs.120",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:110),
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],),
            ),
             Container(
              margin: EdgeInsets.all(16),
              height: 150,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage("assets/SOUP.jpg"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40,right: 60),
                  child: Column(
                    children: [
                      Text("Soba Soup",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      Text("No1.in sales",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 16),),
                      Text("Rs.120",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                      
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:110),
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],),
            ),
             

          ],
          ),
          
      ),
     floatingActionButton:  FloatingActionButton(
              backgroundColor: Colors.amber,
              onPressed: (){},child: Icon(Icons.shopping_bag),),
           
      
    );
    
  }
}