
import 'package:flutter/material.dart';
import 'package:musicapp/const/colors.dart';

class songplayheaderbutton extends StatelessWidget {
  const songplayheaderbutton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 40,height: 40,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: divcolor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Center(child: Icon(Icons.arrow_back_ios)),
        ),
         Container(
          width: 40,height: 40,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: divcolor,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Center(child: Icon(Icons.settings)),
        ),
      ],
    );
  }
}