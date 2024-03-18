
import 'package:flutter/material.dart';
import 'package:musicapp/custom%20widget/song&volume.dart';
import 'package:musicapp/custom%20widget/songControllerButton.dart';
import 'package:musicapp/custom%20widget/songDetail.dart';
import 'package:musicapp/custom%20widget/songWave.dart';
import 'package:musicapp/custom%20widget/songplaybutton.dart';
import 'package:velocity_x/velocity_x.dart';


class songpage extends StatelessWidget {
  final String songTitle;
  final String artistName;
  const songpage({Key? key,required this.songTitle,required this.artistName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var value=20.0;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                20.heightBox,
                songplayheaderbutton(),
                10.heightBox,
                song_volume_updown(),
                20.heightBox,
                songDetail(
                  artistName: artistName,
                  songTitle: songTitle,
                ),
                20.heightBox,
                20.heightBox,
                Spacer(),
                songControllerButton(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}