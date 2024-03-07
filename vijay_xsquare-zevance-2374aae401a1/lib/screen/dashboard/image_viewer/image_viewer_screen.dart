
import 'package:flutter/material.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class ImageViewerScreen extends StatefulWidget {
  final dynamic _argument;
  const ImageViewerScreen(this._argument,{Key? key}) : super(key: key);

  @override
  State<ImageViewerScreen> createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {
  String url="";

  @override
  void initState() {
    super.initState();
    url=widget._argument as String;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.blackTemp,
      appBar: AppBar(
        backgroundColor: colors.blackTemp,
        leading: GestureDetector(
            onTap: () {
              navigatorKey.currentState!.pop();
            },
            child: Container(child: const Image(image: AssetImage(Images.ic_back),color: colors.whiteTemp,),padding: EdgeInsets.all(15.0),)),
        title: Text(
          "Photo",
          style: regularBlack18.copyWith(color: colors.whiteTemp),
        ),
        centerTitle: true,
      ),
      body: PinchZoom(
        child: Image.network(url),
        resetDuration: const Duration(milliseconds: 100),
        maxScale: 2.5,
        onZoomStart: (){print('Start zooming');},
        onZoomEnd: (){print('Stop zooming');},
      ),
    );
  }
}
