import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicapp/Controller/songplayercontroller.dart';
import 'package:musicapp/const/colors.dart';
import 'package:musicapp/custom%20widget/songplaybutton.dart';
import 'package:velocity_x/velocity_x.dart';

class songControllerButton extends StatelessWidget {
  const songControllerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SongPlayerController songPlayerController=Get.put(SongPlayerController());
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("2:34"),
            Text("/"),
            Text(
              "1:20",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        20.heightBox,
        Padding(
          padding: const EdgeInsets.only(bottom: 10,left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.skip_previous_outlined,
                size: 40,
              ),
              40.widthBox,
              Container(
                height: 40,
                width: 40,
                  decoration:
                      BoxDecoration(color: primarycolor, shape: BoxShape.circle),
                  child:Obx(() => songPlayerController.isPlaying.value?
                  InkWell(
                    onTap: (){
                      songPlayerController.pausePlaying();
                    },
                    child: Icon(Icons.pause)):
                    InkWell(
                      onTap: (){
                        songPlayerController.resumePlaying();
                      },
                      child: Icon(Icons.play_arrow)),),
                  ),
              40.widthBox,
              Icon(
                Icons.skip_next_outlined,
                size: 40,
              ),
              40.heightBox,
              
            ],
          ),
        ),
      ],
    );
  }
}
