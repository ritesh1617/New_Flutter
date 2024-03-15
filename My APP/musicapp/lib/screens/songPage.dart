
import 'package:flutter/material.dart';
import 'package:musicapp/custom%20widget/song_list.dart';
import 'package:musicapp/custom%20widget/songpageheader.dart';
import 'package:musicapp/custom%20widget/trandingsong.dart';
import 'package:velocity_x/velocity_x.dart';

class SongPage extends StatefulWidget {
  const SongPage({Key? key}) : super(key: key);

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    20.heightBox,
                    SongPageheader(),
                    10.heightBox,
                    tranding_song(),
                    20.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Cloud Song",style: Theme.of(context).textTheme.bodySmall,),
                        Text("Device Song",style: Theme.of(context).textTheme.bodySmall,),
                      ],
                    ),
                    30.heightBox,
                    song_list(),
                    song_list(),
                    song_list(),
                    song_list(),
                    song_list(),
                    song_list(),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}