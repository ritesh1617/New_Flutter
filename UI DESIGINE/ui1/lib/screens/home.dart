
import 'package:flutter/material.dart';
import 'package:ui1/screens/home1.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.menu,color: Colors.black,),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.purple,
                    child: IconButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => home1(),));
                    }, icon: Icon(Icons.person,color: Colors.white,)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Text("Hello,",style: TextStyle(color: Colors.black,fontSize: 30),),
                 Text("Ritesh!",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 30),),
                ],
              ),
              
            ),
             Padding(
               padding: const EdgeInsets.only(left: 30),
               child: Row(
                 children: [
                   Text("Have a nice day!",style: TextStyle(color: Colors.grey,fontSize: 20),),
                 ],
               ),
             ), 
             Padding(
               padding: const EdgeInsets.only(left: 45,top: 40),
               child: Row(
                children: [
                  Text("My tasks",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                  SizedBox(width: 20,),
                  Text("Project",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                  SizedBox(width: 20,),
                  Text("Pendings",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.bold),),
                ],
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(left: 20,top: 30),
               child: Row(
                children: [
                  Container(
                    height: 300,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.purple[200],
                      borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20,left: 20),
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.person,color: Colors.white,),
                                ),
                                SizedBox(width: 10,),
                                Text("project",style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                            
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,top: 50),
                            child: Row(
                              children: [
                                Text("Back End \nDevelopment",style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,top: 50),
                            child: Row(
                              children: [
                                Text("Apr 3",style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                          ),
                        ],
                      ),
                  ),
                  SizedBox(width: 20,),
                 Container(
                    height: 300,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.purple[200],
                      borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20,left: 20),
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.purple,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.person,color: Colors.white,),
                                ),
                                SizedBox(width: 10,),
                                Text("project",style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                            
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,top: 50),
                            child: Row(
                              children: [
                                Text("Back End \nDevelopment",style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,top: 50),
                            child: Row(
                              children: [
                                Text("Apr 3",style: TextStyle(color: Colors.white,fontSize: 20),)
                              ],
                            ),
                          ),
                        ],
                      ),
                  ),
                ],
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(left: 20,top: 20),
               child: Row(
                children: [
                  Text("Progress",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),)
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
             )
             
             
          ],
        ),
      ),
    );
  }
}