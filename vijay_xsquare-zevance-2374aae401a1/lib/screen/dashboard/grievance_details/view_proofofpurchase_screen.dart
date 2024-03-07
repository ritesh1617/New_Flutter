import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:grievance/common/custom/info_dialog.dart';
import 'package:grievance/model/Attachment.dart';
import 'package:grievance/model/FileData.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/provider/GrievanceProvider.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flowder/flowder.dart';

class ViewProofOfPurchaseScreen extends StatefulWidget {
  final dynamic _argument;

  const ViewProofOfPurchaseScreen(this._argument, {Key? key}) : super(key: key);

  @override
  State<ViewProofOfPurchaseScreen> createState() =>
      _ViewProofOfPurchaseScreenState();
}

class _ViewProofOfPurchaseScreenState extends State<ViewProofOfPurchaseScreen>
    with TickerProviderStateMixin {
  Grievance? model;
  String type = "";

  FlickManager? flickManager;

  late bool _permissionReady;
  late String _localPath;

  late DownloaderUtils options;
  late DownloaderCore core;

  @override
  void initState() {
    super.initState();

    _permissionReady = false;

    if (widget._argument is Grievance) model = widget._argument as Grievance;

    if (model != null) {
      if (model!.proofOfPurchase!.mediaType != "") {
        type = model!.proofOfPurchase!.mediaType!;
      }
    }
    if (type == CustomFileType.video) {
      flickManager = FlickManager(
          videoPlayerController: VideoPlayerController.network(
            model!.proofOfPurchase!.image_path!,
          ),
          autoPlay: true);
    }

    _prepare();
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
              child: Container(
                child: const Image(
                  image: AssetImage(Images.ic_back),
                  color: colors.whiteTemp,
                ),
                padding: EdgeInsets.all(15.0),
              )),
          title: Text(
            "Replace Invoice",
            style: regularBlack18.copyWith(color: colors.whiteTemp),
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  if (_permissionReady)
                    downloadfile(model!.proofOfPurchase!.image_path!,model!.proofOfPurchase!.type!);
                  else
                    _retryRequestPermission();
                },
                child: Image.asset(
                  Images.icon_download,
                  width: 25,
                  height: 25,
                )),
            SizedBox(
              width: 15,
            )
          ],
          centerTitle: true,
        ),
        body: Column(
          children: [
            (type == CustomFileType.photo)
                ? Expanded(
                    child: FadeInImage(
                        fadeInDuration: const Duration(milliseconds: 150),
                        image:
                            NetworkImage(model!.proofOfPurchase!.image_path!),
                        width: deviceWidth,
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                              Images.rectangle_placeholder,
                              fit: BoxFit.cover,
                            ),
                        placeholderErrorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                              Images.rectangle_placeholder,
                              fit: BoxFit.cover,
                            ),
                        placeholder:
                            const AssetImage(Images.rectangle_placeholder)))
                : (type == CustomFileType.video)
                    ? Expanded(child: _grievanceVideo())
                    : (type == CustomFileType.pdf)
                        ? Expanded(child: _grievancePdf())
                        : Container(),
            GestureDetector(
              onTap: () {
                Utils.mediaPicker(context, true, true, false, false, true)
                    .then((value) {
                  // print("++++++");
                  if (value != null) {
                    setState(() {
                      FileData selectedProofFile = value as FileData;
                      addProofOfPurchase(model!.id!, selectedProofFile);
                    });
                    // print(selectedFile!.type);
                  }
                });
              },
              child: Container(
                  margin:
                      EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 25),
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 15, bottom: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: colors.firstColor),
                  child: Row(
                    children: [
                      Image.asset(
                        Images.icon_attach,
                        width: 20,
                        height: 20,
                        color: colors.whiteTemp,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Replace Invoice",
                        style: regularWhite18,
                      )
                    ],
                  )),
            )
          ],
        ));
  }

  _grievanceVideo() {
    var height = 180.0;
    return Container(
      child: ClipRRect(
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
      ),
    );
  }

  _grievancePdf() {
    return GestureDetector(
      onTap: () {
        navigatorKey.currentState!.pushNamed(RouteName.pdfViewerScreen,
            arguments: model!.proofOfPurchase!.image_path!);
      },
      child: Container(
        child: AbsorbPointer(
          child: SfPdfViewer.network(
            model!.proofOfPurchase!.image_path!,
            enableDoubleTapZooming: false,
            canShowPaginationDialog: false,
            canShowScrollHead: false,
            canShowScrollStatus: false,
            canShowPasswordDialog: false,
          ),
        ),
      ),
    );
  }

  void addProofOfPurchase(String grivanceID, FileData proofOfPurchase) async {
    ProgressDialog pr = ProgressDialog(context,
        type: ProgressDialogType.normal,
        isDismissible: false,
        showLogs: true,
        customBody: Container(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Please Wait.. Proof of purchase uploading..",
                  style: boldBlack14,
                )
              ],
            ),
          ),
        ));
    try {
      // Log user in

      pr.show();
      await Provider.of<GrievanceProvider>(context, listen: false)
          .addProofOfPurchase(context, grivanceID, proofOfPurchase)
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
    } else {
      ToastUtils.setSnackBar(context, "Something Wrong!");
    }
  }

  void uploadInvoiceSuccessDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return InfoDialogBox(
            title: "Invoice uploaded successfully",
            descriptions: "",
            titleCenter: true,
            closePress: () {
              navigatorKey.currentState!.pop();
            },
          );
        });
  }
  void fileDownloadSuccessfully() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return InfoDialogBox(
            title: "Invoice downloaded successfully",
            descriptions: "",
            titleCenter: true,
            closePress: () {

            },
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
  }


  Future<void> _retryRequestPermission() async {
    final hasGranted = await _checkPermission();

    if (hasGranted) {
      await _prepareSaveDir();
    }

    setState(() {
      _permissionReady = hasGranted;
    });
  }

  Future<void> _prepare() async {
    _permissionReady = await _checkPermission();

    if (_permissionReady) {
      await _prepareSaveDir();
    }
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;
    final savedDir = Directory(_localPath);
    final hasExisted = savedDir.existsSync();
    if (!hasExisted) {
      await savedDir.create();
    }
  }

  Future<bool> _checkPermission() async {
    if (Platform.isIOS) {
      return true;
    }

    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    if (Theme.of(context).platform == TargetPlatform.android &&
        androidInfo.version.sdkInt <= 28) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<String?> _findLocalPath() async {
    String? externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        externalStorageDirPath = await AndroidPathProvider.downloadsPath;
      } catch (e) {
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    return externalStorageDirPath;
  }

  void downloadfile(String url,String extension) async {
    ProgressDialog  pr = ProgressDialog(context,type: ProgressDialogType.normal, isDismissible:false, showLogs: true,customBody: Container(height: 70,child:
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Please Wait... Proof of purchase downloading..",style: boldBlack14,)
        ],
      ),
    ),));
    pr.show();
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    String filename="file_${timestamp}.${extension}";
    print('$_localPath/$filename');
    options = DownloaderUtils(
      progressCallback: (current, total) {
        final progress = (current / total) * 100;
        print('Downloading: $progress');
      },
      file: File('$_localPath/$filename'),
      progress: ProgressImplementation(),
      onDone: ()  {
        pr.hide();
        fileDownloadSuccessfully();
      },
      deleteOnCancel: true,
    );
    core = await Flowder.download(
        url,
        options);
  }
}
