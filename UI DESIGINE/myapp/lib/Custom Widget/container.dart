

import 'package:flutter/material.dart';
import 'package:myapp/const/color.dart';

Widget Containerpro({double? Height,Width,Widget? child}){
  return Container(
       height: Height,
       width: Width,
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
           blurRadius: 3,
           color: grey,
        ),
      ]
      ),
     child: child,
  );
}