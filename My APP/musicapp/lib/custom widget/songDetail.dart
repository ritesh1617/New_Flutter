
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class songDetail extends StatelessWidget {
  const songDetail({Key? key}) : super(key: key);

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
                    Text("Terabulawa aya h ma",style:Theme.of(context).textTheme.bodyLarge),
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
                    Text("Jubain Nautiyal",style:Theme.of(context).textTheme.bodySmall),
                    
                  ],
                ),
      ],
    );
  }
}