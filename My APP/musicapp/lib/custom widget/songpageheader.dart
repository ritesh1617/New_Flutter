
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SongPageheader extends StatefulWidget {
  const SongPageheader({Key? key}) : super(key: key);

  @override
  State<SongPageheader> createState() => _SongPageheaderState();
}

class _SongPageheaderState extends State<SongPageheader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageIcon(AssetImage("assets/a1.png"),size: 60,),
            10.widthBox,
            Text("MUSIC BAG",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,fontFamily: "poppins"),),
          ],
      
    );
  }
}