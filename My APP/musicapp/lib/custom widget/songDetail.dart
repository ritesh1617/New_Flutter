
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:musicapp/const/export.dart';
import 'package:velocity_x/velocity_x.dart';

class songDetail extends StatelessWidget {
  final String songTitle;
  final String artistName;
  const songDetail({Key? key,required this.songTitle,required this.artistName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Row(
                  children: [
                    Icon(Icons.play_arrow),
                    10.heightBox,
                    Text("210 Plays",style:Theme.of(context).textTheme.bodySmall)
                  ],
                ),
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text("$songTitle",maxLines:1 ,style:Theme.of(context).textTheme.bodyLarge)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.favorite,size: 30,),
                        10.widthBox,
                        Icon(Icons.download,size: 30,),
                      ],
                    ),
                  ],
                ),
                10.heightBox,
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: Text("$artistName",maxLines: 1,style:Theme.of(context).textTheme.bodySmall)),
                    
                  ],
                ),
      ],
    );
  }
}