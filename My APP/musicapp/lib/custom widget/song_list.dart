import 'package:flutter/material.dart';
import 'package:musicapp/const/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class song_list extends StatelessWidget {
  const song_list({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: divcolor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
             Icon(Icons.play_arrow,size: 40,),
             10.heightBox,
             Text("Chalo bulawa aya hai mata",style: Theme.of(context).textTheme.bodyMedium,),
        ],
      )
    );
  }
}