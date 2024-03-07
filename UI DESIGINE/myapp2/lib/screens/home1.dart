
import 'package:flutter/material.dart';

class scrren1 extends StatefulWidget {
  const scrren1({super.key});

  @override
  State<scrren1> createState() => _scrren1State();
}

class _scrren1State extends State<scrren1> {
 
 final List  imageurl=[
  "https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8cGVyc29ufGVufDB8fDB8fHww",
  "https://images.unsplash.com/photo-1543610892-0b1f7e6d8ac1?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fHJvdW5kJTIwcHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D",
  "https://images.unsplash.com/photo-1552058544-f2b08422138a?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8cGVyc29ufGVufDB8fDB8fHww",
  "https://images.unsplash.com/photo-1504593811423-6dd665756598?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D",
  "https://images.unsplash.com/photo-1500048993953-d23a436266cf?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D",
  "https://images.unsplash.com/photo-1599566150163-29194dcaad36?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D",
  "https://images.unsplash.com/photo-1494959764136-6be9eb3c261e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fHBlcnNvbnxlbnwwfHwwfHx8MA%3D%3D"

 ];
 final List name=[
  "Ritesh",
  "Jay",
  "Rohit",
  "Akshay",
  "Dilip",
  "Darshit",
  "Denny"
 ];
 
 final List Contact=[
  "897867569",
  "456387883",
  "566474889",
  "877657676",
  "647478488",
  "657899430",
  "657839039"
 ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: imageurl.length,
        itemBuilder:(context,int ind){
         return Padding(
           padding: const EdgeInsets.all(14),
           child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => list_1(imageurl: imageurl[ind],name: name[ind],contact: Contact[ind],)));
            },
             child: Card(
              
                 child: Padding(
                   padding: const EdgeInsets.all(30),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue,
                        backgroundImage: NetworkImage("${imageurl[ind]}"),
                       ),
                      Column(
                         children: [
                           Text("${name[ind]}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                           Text("${Contact[ind]}",style: TextStyle(fontSize:14,color: Colors.grey),),
                         ],
                       ),
                       Icon(Icons.phone,color: Colors.black,)
                     ],
                   ),
                 ),
              ),
           ),
         );
        },
      ),
    );
  }
}

class list_1 extends StatelessWidget {
  final String imageurl;
  var name;
  var contact;

  list_1({super.key,required this.imageurl,required this.name,required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 200,
                width: 350,
                decoration: BoxDecoration(
                  color: Colors.pink[100],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                   CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage("$imageurl"),
                    backgroundColor: Colors.blue,
                   ),
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Column(
                       children: [
                         Text("$name",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                         Text("$contact",style: TextStyle(fontSize: 16,color: Colors.grey),),
                       ],
                       ),
                    ),
                    Icon(Icons.phone,color: Colors.black,size: 30,),
                ],),
              ),
            ),
          ],
        ),
      ),
    );
  }
}