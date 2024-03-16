import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:musicapp/const/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class song_list extends StatelessWidget {
    final String songName;
    final VoidCallback onPress;

  const song_list({Key? key,required this.songName,required this.onPress}) : super(key: key);

  

  @override
  Widget build(BuildContext context) { 
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onPress,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: divcolor.withOpacity(0.7),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            children: [
                 Icon(Icons.play_arrow,size: 40,),
                 10.heightBox,
                 Flexible(child: Text("$songName",maxLines: 1,style: Theme.of(context).textTheme.bodyMedium,)),
            ],
          )
        ),
      ),
    );
  }
}