
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


 ];
 final List name=[
  "Ritesh",
  "Jay",
  "Rohit",
  "Akshay"
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
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => list_1(imageurl: imageurl[ind],name: name[ind],)));
            },
             child: Card(
                 child: Padding(
                   padding: const EdgeInsets.all(30),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          shape: BoxShape.circle,
                        ),
                        child: Image.network("${imageurl[ind]}",fit: BoxFit.cover,),
                       ),
                       Text("${name[ind]}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
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

  list_1({super.key,required this.imageurl,required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
              child: Column(
                children: [
                 Container(
                  height: 150,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network("$imageurl"),
                 ),
                 Text("$name",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),)
              ],),
            ),
          ],
        ),
      ),
    );
  }
}