
import 'package:flutter/material.dart';

class home2 extends StatefulWidget {
  const home2({super.key});

  @override
  State<home2> createState() => _home2State();
}

class _home2State extends State<home2> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40,left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back,color: Colors.black,size: 30,),
                  Icon(Icons.search,color: Colors.black,size: 30,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50,left: 10,right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Apr,3",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                  Container(
                    height: 80,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text("+ Add Task",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.purpleAccent[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Text("APR",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),),
                           Text("3",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 26),),
                            Text("SUN",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 14),)
                        ],
                      ),
                    ),
                  ),
                   Container(
                    height: 100,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Text("APR",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),),
                           Text("3",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 26),),
                            Text("SUN",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),)
                        ],
                      ),
                    ),
                  ),
                   Container(
                    height: 100,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Text("APR",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),),
                           Text("3",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 26),),
                            Text("SUN",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),)
                        ],
                      ),
                    ),
                  ),
                   Container(
                    height: 100,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          Text("APR",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),),
                           Text("3",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 26),),
                            Text("SUN",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),)
                        ],
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,top: 30),
              child: Row(
                children: [
                  Text("Task",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              height: 80,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: Row(
                children: [
                SizedBox(width: 10,),
                CircleAvatar(
                  backgroundColor: Colors.purple,
                  radius: 20,
                  child: Icon(Icons.menu_book_outlined,color: Colors.white,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:20,top: 20 ),
                  child: Column(
                    children: [
                      Text("Project",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      Text("2 days ago",style: TextStyle(color: Colors.grey,fontSize: 14),)
                    ],
                  ),
                ),
                SizedBox(width: 180,),
                Icon(Icons.more_vert)
              ],),
             ),
             Container(
              margin: EdgeInsets.all(16),
              height: 80,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: Row(
                children: [
                SizedBox(width: 10,),
                CircleAvatar(
                  backgroundColor: Colors.purple,
                  radius: 20,
                  child: Icon(Icons.menu_book_outlined,color: Colors.white,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:20,top: 20 ),
                  child: Column(
                    children: [
                      Text("Project",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      Text("2 days ago",style: TextStyle(color: Colors.grey,fontSize: 14),)
                    ],
                  ),
                ),
                SizedBox(width: 180,),
                Icon(Icons.more_vert)
              ],),
             ),
             Container(
              margin: EdgeInsets.all(16),
              height: 80,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: Row(
                children: [
                SizedBox(width: 10,),
                CircleAvatar(
                  backgroundColor: Colors.purple,
                  radius: 20,
                  child: Icon(Icons.menu_book_outlined,color: Colors.white,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:20,top: 20 ),
                  child: Column(
                    children: [
                      Text("Project",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      Text("2 days ago",style: TextStyle(color: Colors.grey,fontSize: 14),)
                    ],
                  ),
                ),
                SizedBox(width: 180,),
                Icon(Icons.more_vert)
              ],),
             ),
             Container(
              margin: EdgeInsets.all(16),
              height: 80,
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.grey[200],
              ),
              child: Row(
                children: [
                SizedBox(width: 10,),
                CircleAvatar(
                  backgroundColor: Colors.purple,
                  radius: 20,
                  child: Icon(Icons.menu_book_outlined,color: Colors.white,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:20,top: 20 ),
                  child: Column(
                    children: [
                      Text("Project",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      Text("2 days ago",style: TextStyle(color: Colors.grey,fontSize: 14),)
                    ],
                  ),
                ),
                SizedBox(width: 180,),
                Icon(Icons.more_vert)
              ],),
             ),
          ],
        ),
      ),
    );
  }
}