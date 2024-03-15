

import 'package:travelapp/const/export.dart';

Widget music_list_container({Color? color,String? musicname,Widget? child}){
  return Container(
         height: 100,
         width: double.maxFinite,
         decoration: BoxDecoration(
         color: Liteblue,
         borderRadius: BorderRadius.circular(10)
        ),
    child:Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.all(8),
          child: CircleAvatar(
            radius: 40,
            child: Icon(Icons.music_note_outlined),
            backgroundColor: green,
          ),
        ),
        Container(child: musicname?.text.color(white).textStyle(TextStyle(fontWeight: FontWeight.bold,fontSize: 24)).make()),
        60.widthBox,
        Container(
          
          child: child,
        ),
      ],
    ),
  );
}