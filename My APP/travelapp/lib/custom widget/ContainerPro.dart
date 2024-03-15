
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../const/export.dart';

Widget container_pro({Color? color,String? mname}){
  return Container(
    height: 100,
    width: 150,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10)
    ),
    child: Center(child: mname?.text.color(white).textStyle(TextStyle(fontSize: 20,fontWeight: FontWeight.bold)).make()),
  );
}