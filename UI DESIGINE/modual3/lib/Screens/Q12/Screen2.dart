
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class scrreen2 extends StatefulWidget {
  const scrreen2({super.key});

  @override
  State<scrreen2> createState() => _scrreen2State();
}

class _scrreen2State extends State<scrreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
      
      body: Stack(
        children: [
        Positioned.fill(
          child: Container(
          color: Colors.amber,
        )),
        Positioned(  
          bottom: 0,
          child: Container(
          height: MediaQuery.of(context).size.height / 1.4,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50)
            ) 
          ),
        )),
        Positioned(
          top: 180,
          left: 120,
          child: CircleAvatar(
            maxRadius: 80,
          backgroundImage: AssetImage("assets/plate.jpg"),
        )),
        Positioned(
          top: 370,
          right: 0,
          left: 10,
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Row(
                    children: [
                      Text("Sei Ua Samun Phari",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 60,top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.alarm,color: Colors.blue,),
                          Text("50min",style: TextStyle(fontSize: 16),)
                        ],
                      ),
                      SizedBox(width: 40,),
                      Row(
                        children: [
                          Icon(Icons.star,color: Colors.amber,),
                          Text("4.8",style: TextStyle(fontSize: 16),)
                        ],
                      ),
                      SizedBox(width: 40,),
                      Row(
                        children: [
                          Icon(Icons.fireplace_outlined,color: Colors.redAccent,),
                          Text("350 kcal",style: TextStyle(fontSize: 16),)
                        ],
                      ),
                  
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      Container(
                        child: Text("Rs.120",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                      Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.amber
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Row(
                              children: [
                                Icon(Icons.minimize),
                                CircleAvatar(maxRadius: 20,child: Text("1"),),
                                Icon(Icons.add),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 210,top: 40),
                  child: Row(
                    children: [
                      Container(
                        child: Text("Ingredienta",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Scrollbar(
                    child: Row(
                      children: [
                      Container(
                      height: 150,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            maxRadius: 40,
                            backgroundImage: AssetImage("assets/plate.jpg"),
                          ),
                          Text("Noodels")
                        ],
                      ),
                    ),
                    SizedBox(width: 20,),
                    Container(
                      height: 150,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            maxRadius: 40,
                            backgroundImage: AssetImage("assets/plate.jpg"),
                          ),
                          Text("Noodels")
                        ],
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      height: 150,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            maxRadius: 40,
                            backgroundImage: AssetImage("assets/plate.jpg"),
                          ),
                          Text("Noodels")
                        ],
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      height: 150,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Column(
                        children: [
                          CircleAvatar(
                            maxRadius: 40,
                            backgroundImage: AssetImage("assets/plate.jpg"),
                          ),
                          Text("Noodels")
                        ],
                      ),
                    ),
                      ],
      
                  ),),
                ),
                 Padding(
                  padding: const EdgeInsets.only(right: 360,top: 40),
                  child: Row(
                    children: [
                      Container(
                        child: Text("About",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                      ),
                    ],
                  ),
                ),
                Text("A Vibrent thai sausage made with ground chiken,plus its spicy chile,dip.from chefnass saavang of Atlanta's talat market",maxLines: 5,)
               
              ],
            ),
          ))
      
      ])
    );
  }
}