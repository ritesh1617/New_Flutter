import 'package:musicapp/const/export.dart';

class songControllerButton extends StatelessWidget {
  const songControllerButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SongPlayerController songPlayerController=Get.put(SongPlayerController());
    return Column(
      children: [
       Obx(() =>  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${songPlayerController.currentTime}"),
            Text("/"),
            Text(
              "${songPlayerController.totalTime}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),),
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
