
import 'package:flutter/material.dart';

class screen2 extends StatefulWidget {
  const screen2({super.key});
 
  @override
  State<screen2> createState() => _screen2State();
}

class _screen2State extends State<screen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.maxFinite,
              child: Image.network("https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8bmF0dXJlJTIwd2FsbHBhcGVyfGVufDB8fDB8fHww",fit: BoxFit.cover,)
            ), //first image container

           Padding(
             padding: const EdgeInsets.only(top: 20,left: 10),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("Oeschinen Lake campground",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text("kanderstange,Switzerland",style: TextStyle(color: Colors.grey,fontSize: 16),),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    children: [
                      Icon(Icons.star,color: Colors.amber,size: 30,),
                      Text("41",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    ],
                  ),
                )
              ],
             ),
           ),//second text row
           Padding(
             padding: const EdgeInsets.only(left: 10,top:  60),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Icon(Icons.phone,color: Colors.blue,size: 30,),
                    Text("CALL",style: TextStyle(color: Colors.blue,fontSize: 16),),
                  ],
                ),
                 Column(
                  children: [
                    Icon(Icons.location_on,color: Colors.blue,size: 30,),
                    Text("ROUTE",style: TextStyle(color: Colors.blue,fontSize: 16),),
                  ],
                ),
                 Column(
                  children: [
                    Icon(Icons.share,color: Colors.blue,size: 30,),
                    Text("SHARE",style: TextStyle(color: Colors.blue,fontSize: 16),),
                  ],
                ),
              ],
             ),
           ),//Third Icons Row
           SizedBox(height: 60,),
           Padding(
             padding: const EdgeInsets.all(12),
             child: Text("Oeschinensee is accessible by foot from Kandersteg within 1.5 hours. The cable car operates in summer and winter season daily from mornings till evenings - non stop. In summer enjoy swimming in the lake, boat rides on the blue and clear water or just have fun with the toboggan run at the top station of the cable car. Several hotels around the lake offer rooms in summer. Restaurants are open in winter and summer. The region belongs to the Unesco heritage Jungfrau-Aletsch."),
           ),
          ],
        ),
      ),
    );
  }
}