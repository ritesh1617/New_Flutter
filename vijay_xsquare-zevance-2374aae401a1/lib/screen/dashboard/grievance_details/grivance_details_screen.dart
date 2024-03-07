import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grievance/common/custom/info_dialog.dart';
import 'package:grievance/common/widget/CardLikeCommentWidget.dart';
import 'package:grievance/common/widget/GDProfileWidget.dart';
import 'package:grievance/model/FileData.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/provider/GrievanceProvider.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

const kUrl = "https://www.mediacollege.com/downloads/sound-effects/nature/forest/rainforest-ambient.mp3";

class GrievanceDetailsScreen extends StatefulWidget {
  final dynamic _argument;

  const GrievanceDetailsScreen(this._argument, {Key? key}) : super(key: key);

  @override
  _GrievanceDetailsScreenState createState() => _GrievanceDetailsScreenState();
}

class _GrievanceDetailsScreenState extends State<GrievanceDetailsScreen>
    with TickerProviderStateMixin {
  Grievance? model;
  Users? users;


  FlickManager? flickManager;

  String type = "chat";
  @override
  void initState() {
    super.initState();
    model = widget._argument as Grievance;
    type = "chat";
    if (model!.attachments!.isNotEmpty) {
      if (model!.attachments![0].mediaType != "") {
        type = model!.attachments![0].mediaType!;
      }
    }
    getUserDetails();
    getGrievanceById();
    if (type == CustomFileType.video) {
      flickManager = FlickManager(
          videoPlayerController: VideoPlayerController.network(
            model!.attachments![0].url!,
          ),
          autoPlay: true);
    }

  }

  @override
  void dispose() {
    if (flickManager != null) flickManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.whiteTemp,
      appBar: AppBar(
        backgroundColor: colors.backgroundColor,
        leading: GestureDetector(
            onTap: () {
              navigatorKey.currentState!.pop();
            },
            child: Container(child: const Image(image: AssetImage(Images.ic_back)),padding: EdgeInsets.all(15),)),
        title: Text(
          "Grievance Details",
          style: boldBlack18,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //  _grievanceFollowDetails(),
                    SizedBox(height: 110,),
                    (type == CustomFileType.video)
                        ? _grievanceVideo()
                        : Container(),
                    (type == CustomFileType.photo)
                        ? _grievanceImage()
                        : Container(),
                  ],
                ),
                GDProfileWidget(model: model!,userID: users?.id,onUploadClick: (){
                  if(model!.proofOfPurchase==null) {
                    Utils.mediaPicker(context, true, true, false, false, true)
                        .then((value) {
                      // print("++++++");
                      if (value != null) {
                        setState(() {
                         FileData selectedProofFile = value as FileData;
                         addProofOfPurchase(model!.id!,selectedProofFile);
                        });
                        // print(selectedFile!.type);
                      }
                    });
                  }
                  else{
                    navigatorKey.currentState!.pushNamed(RouteName.viewProofOfPurchaseScreen,arguments: model!).then((value) => {
                      getGrievanceById()
                    });
                  }
                },),
                Positioned(right: -20,top: 150,child: GestureDetector(
                    onTap: (){
                      navigatorKey.currentState!.pushNamed(RouteName.grievanceRepliesScreen,arguments: model).then((value) => {
                        getGrievanceById()
                      });
                    },
                    child: Image.asset(Images.icon_chat,width: 80,height: 80,)),)
              ],
            )
          ),
          CardLikeCommentWidget(model: model,
            onMakeLouder: () => {_clickMakeLouder()},
            onFeelYou: () => {_clickFeelYou()},
            onComment: (){
              navigatorKey.currentState!.pushNamed(RouteName.commentScreen,arguments: model?.id!).then((value) => {
                getGrievanceById()
              });
            },
            onShare: (){
            navigatorKey.currentState!.pushNamed(
                RouteName.shareScreen,
                arguments: model);
          },)
        ],
      ),
    );
  }

  _grievanceVideo() {
    var height = 180.0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(0.0),
      child: SizedBox(
        height: height,
        child: VisibilityDetector(
          key: ObjectKey(flickManager),
          onVisibilityChanged: (visibility) {
            if (visibility.visibleFraction == 0 && mounted) {
              flickManager?.flickControlManager?.autoPause();
            } else if (visibility.visibleFraction == 1) {
              flickManager?.flickControlManager?.autoResume();
            }
          },
          child: FlickVideoPlayer(
            flickManager: flickManager!,
            flickVideoWithControls: const FlickVideoWithControls(
              controls: FlickPortraitControls(),
            ),
            flickVideoWithControlsFullscreen: const FlickVideoWithControls(
              controls: FlickLandscapeControls(),
            ),
          ),
        ),
      ),
    );
  }

  _grievanceImage() {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          navigatorKey.currentState!.pushNamed(RouteName.imageViewerScreen,
              arguments: model!.attachments![0].url!);
        },
        child: Container(
        //  margin: const EdgeInsets.only(top: 15, left: 15, right: 15),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(0.0),
            child: FadeInImage(
                fadeInDuration: const Duration(milliseconds: 150),
                image: NetworkImage(model!.attachments![0].url!),
                width: deviceWidth,
                fit: BoxFit.cover,
                imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                      Images.rectangle_placeholder,
                      fit: BoxFit.cover,
                    ),
                placeholderErrorBuilder: (context, error, stackTrace) =>
                    Image.asset(
                      Images.rectangle_placeholder,
                      fit: BoxFit.cover,
                    ),
                placeholder: const AssetImage(Images.rectangle_placeholder)),
          ),
        ),
      ),
    );
  }

  _clickMakeLouder() {
    setState(() {
      if (model!.isLouder) {
        model!.totalLoud =
            (int.parse(model!.totalLoud!) - 1).toString();
      } else {
        model!.totalLoud =
            (int.parse(model!.totalLoud!) + 1).toString();
      }
      model!.isLouder = !model!.isLouder;
    });
    updateLouderApiCall(model!.id!);
  }

  Future<void> updateLouderApiCall(String grievanceId) async {
    try {
      await Provider.of<GrievanceProvider>(context, listen: false)
          .updateLouderApi(context, grievanceId, LouderType.grievance)
          .then((value) => {});
    } on HttpException catch (error) {
    } catch (error) {}
  }

  _clickFeelYou() {
    setState(() {
      if (model!.isFeel) {
        model!.totalFeel = (int.parse(model!.totalFeel!) - 1).toString();
      } else {
        model!.totalFeel = (int.parse(model!.totalFeel!) + 1).toString();
      }
      model!.isFeel = !model!.isFeel;
    });
    updateFeelApiCall(model!.id!);
  }

  Future<void> updateFeelApiCall(String grievanceId) async {
    try {
      await Provider.of<GrievanceProvider>(context, listen: false)
          .updateFeelYouApi(context, grievanceId)
          .then((value) => {});
    } catch (error) {
      print(error);
    }
  }

  Future<void> getGrievanceById() async {
    print("Grievance ID :"+model!.id!);
    try {
      await Provider.of<GrievanceProvider>(context, listen: false)
          .getGrievanceById(context,model!.id!)
          .then((value) => {
                if (value != null)
                  {
                    setState(() {
                      model = value;
                      log(model!.toJson().toString());
                    })
                  }
              });
    } catch (error) {}
  }

  void addProofOfPurchase(String grivanceID,FileData proofOfPurchase) async {
    ProgressDialog  pr = ProgressDialog(context,type: ProgressDialogType.normal, isDismissible:false, showLogs: true,customBody: Container(height: 70,child:
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Please Wait... Proof of purchase uploading..",style: boldBlack14,)
        ],
      ),
    ),));
    try {
      // Log user in

      pr.show();
      await Provider.of<GrievanceProvider>(context, listen: false)
          .addProofOfPurchase(context, grivanceID,proofOfPurchase)
          .then((value) {
            pr.hide();
        responseAddGrievance(value);
      });
    } on HttpException catch (error) {
      pr.hide();
      print(error);
    } catch (error) {
      pr.hide();
      print(error);
    }
  }

  void responseAddGrievance(Grievance? value) async {

    if (value != null) {
      uploadInvoiceSuccessDialog();
      setState(() {
        model=value;
      });
    } else {
      ToastUtils.setSnackBar(context, "Something Wrong!");
    }
    getGrievanceById();
  }

  void uploadInvoiceSuccessDialog(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return InfoDialogBox(
            title: "Invoice uploaded successfully",
            descriptions:"",
            titleCenter: true,
            closePress: () {
            },
          );
        });
  }

  void getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    var userDate = prefs.getString(Constants.user);
    setState(() {
      users = Users.fromJson(json.decode(userDate!));
    });
  }
}
