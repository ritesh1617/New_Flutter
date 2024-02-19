import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grievance/common/widget/CommentItemWidget.dart';
import 'package:grievance/common/widget/RecieveChatWidget.dart';
import 'package:grievance/common/widget/SendChatWidget.dart';
import 'package:grievance/model/Comment.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/provider/GrievanceProvider.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/common.dart';
import 'package:grievance/utils/constants.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:rxdart/rxdart.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

const kUrl = "https://www.mediacollege.com/downloads/sound-effects/nature/forest/rainforest-ambient.mp3";

class GrievanceDetailsOldScreen extends StatefulWidget {
  final dynamic _argument;

  const GrievanceDetailsOldScreen(this._argument, {Key? key}) : super(key: key);

  @override
  _GrievanceDetailsOldScreenState createState() => _GrievanceDetailsOldScreenState();
}

class _GrievanceDetailsOldScreenState extends State<GrievanceDetailsOldScreen>
    with TickerProviderStateMixin {
  Grievance? model;
  Users? users;

  final GlobalKey _globalKey = GlobalKey();

  List<Comment> commentList = [];
  FlickManager? flickManager;

  final _commentController = TextEditingController();

  //++++++++++++++ Audio Player +++++++++++++++++
  final _player = AudioPlayer();
  LockCachingAudioSource _audioSource = LockCachingAudioSource(Uri.parse(
    "https://dovetail.prxu.org/70/66673fd4-6851-4b90-a762-7c0538c76626/CoryCombs_2021T_VO_Intro.mp3",
  ));
  String type = "chat";

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      //await _audioSource.clearCache();
      await _player.setAudioSource(_audioSource);
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _player.stop();
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, double, Duration?, PositionData>(
          _player.positionStream,
          _audioSource.downloadProgressStream,
          _player.durationStream,
          (position, downloadProgress, reportedDuration) {
        final duration = reportedDuration ?? Duration.zero;
        final bufferedPosition = duration * downloadProgress;
        return PositionData(position, bufferedPosition, duration);
      });

  //+++++++++++++++++++++++ End Audio Player ++++++++++++++++

  // List<Comment> list = [];
  int page = 1;
  bool _isLoading = false;
  ScrollController controller = ScrollController();

  void _scrollListener() {
    if (!_isLoading) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        commentListApiCall();
      }
    }
  }

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
    _init();
    if (type == CustomFileType.audio) {
      _audioSource = LockCachingAudioSource(Uri.parse(
        model!.attachments![0].url!,
      ));
    }
    if (type == CustomFileType.video) {
      flickManager = FlickManager(
          videoPlayerController: VideoPlayerController.network(
            model!.attachments![0].url!,
          ),
          autoPlay: true);
    }

    controller = ScrollController()..addListener(_scrollListener);
    commentListApiCall();
  }

  @override
  void dispose() {
    if (flickManager != null) flickManager?.dispose();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      appBar: AppBar(
        backgroundColor: colors.backgroundColor,
        leading: GestureDetector(
            onTap: () {
              navigatorKey.currentState!.pop();
            },
            child: Container(child: const Image(image: AssetImage(Images.ic_back)),padding: EdgeInsets.all(15),)),
        title: Text(
          "Details",
          style: regularBlack18,
        ),
        actions: [
          GestureDetector(
              onTap: () => {
                    navigatorKey.currentState!.pushNamed(
                        RouteName.grievanceRepliesScreen,
                        arguments: model)
                  },
              child:
                  (users != null && model != null && users?.id == model?.userId)
                      ? const Icon(
                          Icons.send_outlined,
                          size: 20,
                        )
                      : Container()),
          const SizedBox(
            width: 20,
          )
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          _grievanceProfileDetails(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //  _grievanceFollowDetails(),
                  (type == CustomFileType.video)
                      ? _grievanceVideo()
                      : Container(),
                  (type == CustomFileType.audio)
                      ? _grievanceAudio()
                      : Container(),
                  (type == CustomFileType.photo)
                      ? _grievanceImage()
                      : Container(),
                  (type == CustomFileType.pdf) ? _grievancePdf() : Container(),
                  _cardPostGrievanceChat(),
                  const SizedBox(height: 15),
                  _sendComment(),
                  const SizedBox(height: 15),
                  ListView.builder(
                      shrinkWrap: true,
                      controller: controller,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: commentList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CommentItemWidget(
                          commentList[index],
                          () {
                            _clickMakeLouder(index);
                          },
                        );
                      })
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _grievanceProfileDetails() {
    return GestureDetector(
      child: Container(
        color: colors.whiteTemp,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    "${model!.title}",
                    style: normalGray16.copyWith(color: colors.subtitle),
                  ),
                ),
                Text(
                  Utils.onlyDateConvert(model!.createdAt!),
                  style: regularGray10,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Ticket no : ${model!.ticketNo}",
              style: regularGray12,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: FadeInImage(
                      fadeInDuration: const Duration(milliseconds: 150),
                      image: (model!.company != null &&
                              model!.company!.logo!.isNotEmpty)
                          ? NetworkImage(model!.company!.logo!)
                          : const NetworkImage('https://cdn.osxdaily.com/wp-content.jpg'),
                      height: 20,
                      width: 20,
                      fit: BoxFit.cover,
                      imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                            Images.person_placeholder,
                            fit: BoxFit.cover,
                            height: 20,
                          ),
                      placeholderErrorBuilder: (context, error, stackTrace) => Image.asset(
                            Images.person_placeholder,
                            fit: BoxFit.cover,
                            height: 20,
                          ),
                      placeholder: const AssetImage(Images.person_placeholder)),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "${(model!.company!=null)?model!.company?.companyName:model!.companyName}",
                  style: regularBlack12,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _grievanceVideo() {
    var height = 180.0;
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
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
      ),
    );
  }

  _grievanceAudio() {
    return Container(
      margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
      padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: colors.grayLight,
              blurRadius: 3.0,
            ),
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            child: StreamBuilder<PlayerState>(
              stream: _player.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final processingState = playerState?.processingState;
                final playing = playerState?.playing;
                if (processingState == ProcessingState.loading ||
                    processingState == ProcessingState.buffering) {
                  return Container(
                    margin: const EdgeInsets.all(8.0),
                    width: 30.0,
                    height: 30.0,
                    child: const CircularProgressIndicator(),
                  );
                } else if (playing != true) {
                  return IconButton(
                    icon: const Icon(
                      Icons.play_arrow,
                      color: colors.whiteTemp,
                    ),
                    iconSize: 30.0,
                    onPressed: _player.play,
                  );
                } else if (processingState != ProcessingState.completed) {
                  return IconButton(
                    icon: const Icon(
                      Icons.pause,
                      color: colors.whiteTemp,
                    ),
                    iconSize: 30.0,
                    onPressed: _player.pause,
                  );
                } else {
                  return IconButton(
                    icon: const Icon(
                      Icons.replay,
                      color: colors.whiteTemp,
                    ),
                    iconSize: 30.0,
                    onPressed: () => _player.seek(Duration.zero),
                  );
                }
              },
            ),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    colors: [colors.firstColor, colors.secondColor])),
          ),
          Expanded(
            child: StreamBuilder<PositionData>(
              stream: _positionDataStream,
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return SeekBar(
                  duration: positionData?.duration ?? Duration.zero,
                  position: positionData?.position ?? Duration.zero,
                  bufferedPosition:
                      positionData?.bufferedPosition ?? Duration.zero,
                  onChangeEnd: _player.seek,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _grievanceImage() {
    var height = 180.0;
    return GestureDetector(
      onTap: () {
        navigatorKey.currentState!.pushNamed(RouteName.imageViewerScreen,
            arguments: model!.attachments![0].url!);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: colors.grayLight,
                blurRadius: 3.0,
              ),
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: FadeInImage(
              fadeInDuration: const Duration(milliseconds: 150),
              image: NetworkImage(model!.attachments![0].url!),
              height: height,
              width: deviceWidth,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                    Images.rectangle_placeholder,
                    fit: BoxFit.cover,
                    height: height,
                  ),
              placeholderErrorBuilder: (context, error, stackTrace) =>
                  Image.asset(
                    Images.rectangle_placeholder,
                    fit: BoxFit.cover,
                    height: height,
                  ),
              placeholder: const AssetImage(Images.rectangle_placeholder)),
        ),
      ),
    );
  }

  _grievancePdf() {
    var height = 180.0;
    return GestureDetector(
      onTap: () {
        navigatorKey.currentState!.pushNamed(RouteName.pdfViewerScreen,
            arguments: model!.attachments![0].url!);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: colors.grayLight,
                blurRadius: 3.0,
              ),
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: SizedBox(
              height: height,
              child: AbsorbPointer(
                child: SfPdfViewer.network(
                  model!.attachments![0].url!,
                  enableDoubleTapZooming: false,
                  canShowPaginationDialog: false,
                  canShowScrollHead: false,
                  canShowScrollStatus: false,
                  canShowPasswordDialog: false,
                ),
              )),
        ),
      ),
    );
  }

  _cardPostGrievanceChat() {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: colors.grayLight,
              blurRadius: 3.0,
            ),
          ]),
      child: Column(
        children: [_grievanceChat(), _boxLikeComment()],
      ),
    );
  }

  _grievanceChat() {
    return SizedBox(
      height: 200,
      child: Scrollbar(
        child: ListView.builder(
            itemCount: model!.replies!.length,
            itemBuilder: (BuildContext context, int index) {
              return (model!.replies![index].user?.userableType ==
                      Usertype.enduser)
                  ? ReceiveChatWidget(model!.replies![index],anonymous: model!.anonymous,):SendChatWidget(model!.replies![index],anonymous: model!.anonymous,);
            }),
      ),
    );
  }

  _boxLikeComment() {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _clickFeelYou();
              },
              child: Container(
                margin: const EdgeInsets.only(right: 5),
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    color: (model!.isFeel) ? colors.secondary : colors.whiteTemp),
                child: Image.asset(
                  Images.ic_feel,
                  color: (model!.isFeel) ? colors.whiteTemp : Colors.grey,
                ),
              ),
            ),
            Text(
              "I feel you",
              style: regularGray12,
            ),
            const Spacer(),
            Container(
              padding:
                  const EdgeInsets.only(left: 10, right: 2, top: 3, bottom: 3),
              decoration: BoxDecoration(
                color: colors.secondaryLight,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _clickMakeLouderGrievance();
                    },
                    child: Text(
                      (model!.isLouder) ? "Louder" : "Make It Louder",
                      style: regularGray10.copyWith(color: colors.secondary),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      navigatorKey.currentState!.pushNamed(RouteName.shareScreen,arguments:model);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 4, bottom: 4),
                      decoration: BoxDecoration(
                        color: colors.secondary,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          Text(
                            "Share",
                            style: regularWhite10,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  _sendComment() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 25),
        ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: FadeInImage(
              fadeInDuration: const Duration(milliseconds: 150),
              image: (users != null && users!.image!.isNotEmpty)
                  ? NetworkImage(users!.image!)
                  : const NetworkImage('https://yourlawnwise.com/wp-content/uploads/2017/08/photo-placeholder.png'),
              height: 35,
              width: 35,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                    Images.rectangle_placeholder,
                    fit: BoxFit.cover,
                    height: 35,
                  ),
              placeholderErrorBuilder: (context, error, stackTrace) =>
                  Image.asset(
                    Images.rectangle_placeholder,
                    fit: BoxFit.cover,
                    height: 35,
                  ),
              placeholder: const AssetImage(Images.rectangle_placeholder)),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: colors.grayLight, width: 1)),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              style: regularBlack14,
              controller: _commentController,
              decoration: InputDecoration(
                  suffixIcon: Container(
                    margin: const EdgeInsets.all(3),
                    width: 30,
                    height: 30,
                    child: GestureDetector(
                      onTap: () {
                        _clickSendComment();
                      },
                      child: const Icon(
                        Icons.send_outlined,
                        size: 25,
                        color: colors.whiteTemp,
                      ),
                    ),
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: colors.greenShado,
                            blurRadius: 2.0,
                          ),
                        ],
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                            colors: [colors.firstColor, colors.secondColor])),
                  ),
                  hintStyle: regularGray14,
                  hintText: "What's in your mind",
                  fillColor: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  void _clickSendComment() {
    String comment = _commentController.text.toString().trim();
    if (comment.isEmpty) {
      ToastUtils.setSnackBar(context, "Please write whats in your mind!");
      return;
    }
    makeCommentApi(model!.id!, comment);
  }

  Future<void> makeCommentApi(String grievanceId, String comment) async {
    try {
      await Provider.of<GrievanceProvider>(context, listen: false)
          .makeCommentApi(context, grievanceId, comment)
          .then((value) => {makeCommentResponse(value)});
    } on HttpException catch (error) {
    } catch (error) {

    }
  }

  void makeCommentResponse(bool value) {
    if (value) {
      setState(() {
        _commentController.text = "";
      });
      page = 1;
      commentListApiCall();
    }
  }

  Future<void> commentListApiCall() async {
    print(_isLoading);
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<GrievanceProvider>(context, listen: false)
            .getComment(context,page, model!.id!)
            .then((value) => {commentListResponse(value)});
      } on HttpException catch (error) {
        setState(() {
          _isLoading = false;
        });
        print(error);
      } catch (error) {
        setState(() {
          _isLoading = false;
        });
        print(error);
      }
    }
  }

  void commentListResponse(List<Comment> data) async {
    if (page == 1) commentList.clear();
    page = page + 1;
    setState(() {
      _isLoading = false;
      commentList.addAll(data);
    });
//     if(!list.isEmpty){
// searchProductApiCall();
//     }
  }

  void _clickMakeLouder(int index) {
    setState(() {
      commentList[index].isLouder = !commentList[index].isLouder!;
    });
    updateLouderApiCall(commentList[index].id!);
  }

  Future<void> updateLouderApiCall(String grievanceId) async {
    try {
      await Provider.of<GrievanceProvider>(context, listen: false)
          .updateLouderApi(context, grievanceId, LouderType.comment)
          .then((value) => {});
    } on HttpException catch (error) {
    } catch (error) {}
  }

  _clickFeelYou() {
    setState(() {
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

  _clickMakeLouderGrievance() {
    setState(() {
      model!.isLouder = !model!.isLouder;
    });
    updateLouderGrievanceApiCall(model!.id!);
  }

  Future<void> updateLouderGrievanceApiCall(String grievanceId) async {
    try {
      await Provider.of<GrievanceProvider>(context, listen: false)
          .updateLouderApi(context, grievanceId, LouderType.grievance)
          .then((value) => {});
    } catch (error) {}
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

  void getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    var userDate = prefs.getString(Constants.user);
    setState(() {
      users = Users.fromJson(json.decode(userDate!));
    });
  }
}
