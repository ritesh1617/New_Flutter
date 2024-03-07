import 'package:flutter/material.dart';
import 'package:myapp/Const/images.dart';

Widget Back_screen({Widget? child,context}){
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage(bgImage),fit: BoxFit.cover)
    ),
    child: child,
  );
}
