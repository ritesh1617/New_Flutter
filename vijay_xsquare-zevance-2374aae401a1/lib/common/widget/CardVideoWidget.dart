import 'package:flutter/material.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:video_player/video_player.dart';
import 'package:readmore/readmore.dart';

import '../../theme/color.dart';

class CardVideoWidget extends StatelessWidget {
  Grievance? model;

  CardVideoWidget({Key? key, required Grievance this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = 400.0;
    VideoPlayerController controller=VideoPlayerController.network(model!.attachments![0].url!)..initialize();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: ReadMoreText(
              model!.description!,
              style: regularBlack12,
              trimLines: 2,
              colorClickableText: colors.grayTemp,
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Show more',
              trimExpandedText: ' Show less',
              moreStyle: regularGray12,
            )),
        ClipRRect(
          borderRadius: BorderRadius.circular(0.0),
          child: Stack(
            children: [
              SizedBox(
                height: height,
                child: VideoPlayer(
                    controller),
              ),
              SizedBox(
                height: height,
                child: Center(
                    child: Image.asset(
                  Images.ic_video,
                  width: 50,
                  height: 50,
                )),
              ),
           //   Text("Duration ${controller.value.duration}",style: boldBlack14.copyWith(color: Colors.blue),)
            ],
          ),
        )
      ],
    );
  }
}
