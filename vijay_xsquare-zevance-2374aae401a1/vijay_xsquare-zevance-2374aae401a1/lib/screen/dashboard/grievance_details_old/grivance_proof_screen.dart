import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grievance/common/widget/CommentItemWidget.dart';
import 'package:grievance/common/widget/RecieveChatWidget.dart';
import 'package:grievance/common/widget/SendChatWidget.dart';
import 'package:grievance/model/Comment.dart';
import 'package:grievance/model/Grievance.dart';
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
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

const kUrl =
    "https://www.mediacollege.com/downloads/sound-effects/nature/forest/rainforest-ambient.mp3";

class GrievanceProofScreen extends StatefulWidget {
  final dynamic _argument;

  const GrievanceProofScreen(this._argument, {Key? key}) : super(key: key);

  @override
  _GrievanceProofScreenState createState() => _GrievanceProofScreenState();
}

class _GrievanceProofScreenState extends State<GrievanceProofScreen>
    with TickerProviderStateMixin {
  Grievance? model;

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
          "Purchase Proof",
          style: regularBlack18,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
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
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ],
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

}
