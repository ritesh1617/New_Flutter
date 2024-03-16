
import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:musicapp/Controller/songDataController.dart';
import 'package:musicapp/Controller/songplayercontroller.dart';
import 'package:musicapp/const/colors.dart';
import 'package:musicapp/custom%20widget/song_list.dart';
import 'package:musicapp/custom%20widget/songpageheader.dart';
import 'package:musicapp/custom%20widget/trandingsong.dart';
import 'package:musicapp/screens/playSong.dart';
import 'package:velocity_x/velocity_x.dart';

class SongPage extends StatefulWidget {
  const SongPage({Key? key}) : super(key: key);

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  @override
  Widget build(BuildContext context) {
    songdataController songDataController=Get.put(songdataController());
    SongPlayerController songPlayerController=Get.put(SongPlayerController());
    
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
                   Obx(() =>  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            songDataController.isDeviceSong.value=false;

                          },
                          child: Text("Cloud Song",style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: songDataController.isDeviceSong.value?labelColor:primarycolor,
                          ))),
                        InkWell(
                          onTap: (){
                            songDataController.isDeviceSong.value=true;
                          },
                          
                          child: Text("Device Song",style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                 color: songDataController.isDeviceSong.value?primarycolor:labelColor,
                          ))),
                      ],
                    ),),
                    30.heightBox,
                  Obx(() =>  songDataController.isDeviceSong.value? Column(
                    children: songDataController.localsongList.value.map((e) => song_list(
                      onPress: (){
                        songPlayerController.playLocalAudio(e.data);
                        Get.to(songpage());
                      },
                      songName: e.title,)).toList()
                   ):Column(
                    children: [
                      
                      
                    ],
                   )),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}