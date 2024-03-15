

import 'package:travelapp/const/export.dart';

Widget follow_screen_container({Color? color,String? artistname,String? follow}){
  return Container(
         height: 100,
         width: double.maxFinite,
         decoration: BoxDecoration(
         color: yellow,
         borderRadius: BorderRadius.circular(10)
        ),
    child:Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.all(8),
          child: CircleAvatar(
            radius: 40,
            backgroundColor: green,
          ),
        ),
        Container(child: artistname?.text.color(white).textStyle(TextStyle(fontWeight: FontWeight.bold,fontSize: 24)).make()),
        60.widthBox,
        Container(
          height: 30,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          child:Center(child: follow?.text.color(white).textStyle(TextStyle(fontWeight: FontWeight.bold,fontSize: 20)).make()),
        ),
      ],
    ),
  );
}