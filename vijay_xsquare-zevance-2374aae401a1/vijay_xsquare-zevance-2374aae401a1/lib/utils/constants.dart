import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:grievance/common/custom/info_dialog.dart';
import 'package:grievance/model/FileData.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/color.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

//onst String DOMAIN = "http://d709-103-156-144-178.ngrok.io";
const String DOMAIN = "https://zevance.com";
//const String DOMAIN = "http://1b86-103-156-144-251.ngrok.io";
const String BASE_URL = DOMAIN + "/api/v1";
const String BASE_URL_V2 = DOMAIN + "/api/v2";
const kDebugMode = true;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final Future<SharedPreferences> sharedPreferences =
    SharedPreferences.getInstance();

bool isLogin = false;
bool isCreateProfile = false;
double? deviceHeight;
double? deviceWidth;

class StatusBarStyle {
  static const String light = 'light';
  static const String dark = 'dark';
}

class StringConstant {
  static const String appName = 'Zevance';
  static const String channelID = 'ZevanceNotification';
  static const String channelName = 'General Notification';
  static const String channelDesc = 'Zevance Notifications';
}

class Constants {
  static const String id = 'id';
  static const String name = 'name';
  static const String choose_city = 'Choose City';
  static const String choose_state = 'Choose State';
  static const String choose_country = 'Choose Country';
  static const String isLogin = 'isLogin';
  static const String isCreateProfile = 'isCreateProfile';
  static const String email = 'email';
  static const String mobile_no = 'mobile_no';
  static const String country_code = 'country_code';
  static const String type = 'type';
  static const String profile_type = 'profile_type';
  static const String total = 'total';
  static const String token = 'token';
  static const String otp = 'otp';
  static const String first_name = 'first_name';
  static const String last_name = 'last_name';
  static const String headline = 'headline';
  static const String password = 'password';
  static const String page = 'page';
  static const String fcm_token = 'fcm_token';
  static const String user_id = 'user_id';
  static const String anonymous = 'anonymous';
  static const String user = 'user';
  static const String platform = 'platform';
  static const String create_profile = 'create_profile';
  static const String is_interest = 'is_interest';
  static const String category_ids = 'category_ids';
  static const String q = 'q';
  static const String filter = 'filter';
  static const String title = 'title';
  static const String grievance_detail = 'grievance_detail';
  static const String company_name = 'company_name';
  static const String company_id = 'company_id';
  static const String desired_outcome = 'desired_outcome';
  static const String desire_outcome_description = 'desire_outcome_description';
  static const String access_token = 'access_token';
  static const String authorization = 'Authorization';
  static const String grievance_id = 'grievance_id';
  static const String parent_grievance_id = 'parent_grievance_id';
  static const String rating = 'rating';
  static const String comment_id = 'comment_id';
  static const String feel = 'feel';
  static const String gst_cert = 'gst_cert';
  static const String address = 'address';
  static const String comment = 'comment';
  static const String status = 'status';
  static const String gst_no = 'gst_no';
  static const String cin_number = 'cin_number';
  static const String pan_number = 'pan_number';
  static const String county = 'country';
  static const String state = 'state';
  static const String city = 'city';
  static const String cin_cert = 'cin_cert';
  static const String pan_card = 'pan_card';
  static const String username = 'username';
  static const String pincode = 'pincode';
  static const String bio = 'bio';
  static const String profile_pic = 'profile_pic';
  static const String cover_image = 'cover_image';
  static const String attachment = 'attachment';
  static const String proof_of_purchase = 'proof_of_purchase';
  static const String media_type = 'media_type';
  static const String proof_media_type = 'proof_media_type';
  static const String gst_cert_media_type = 'gst_cert_media_type';
  static const String cin_cert_media_type = 'cin_cert_media_type';
  static const String pan_card_media_type = 'pan_card_media_type';
  static const String faq_url = 'https://zevance.com/faq';
  static const String privacy_url = 'https://zevance.com/privacy-policy';
  static const String terms_and_conditions_url =
      'https://zevance.com/terms-condition';
}

class Usertype {
  static const String user = 'App\\Models\\User';
  static const String enduser = 'App\\Models\\EndUser';
  static const String company = 'App\\Models\\Company';
}

class SocialType {
  static const String google = 'google';
  static const String apple = 'apple';
  static const String facebook = 'facebook';
}

class FollowerType {
  static const String following = 'following';
  static const String follower = 'follower';
}

class DataType {
  static const String all = 'all';
  static const String personal = 'personal';
}

class LouderType {
  static const String grievance = 'grievance';
  static const String comment = 'comment';
}

class ImageType {
  static const String profile = 'profile';
  static const String cover = 'cover';
}

class CustomFileType {
  static const String camera = 'camera';
  static const String photo = 'photo';
  static const String video = 'video';
  static const String audio = 'audio';
  static const String pdf = 'pdf';
}

class FollowType {
  static const String company = 'company';
  static const String user = 'user';
}

class Utils {
  static DateTime date(String date) {
    var str = date.replaceAll("T", " ");
    str = str.replaceAll("Z", " ");
    var inputFormat = DateFormat('yyyy-MM-dd hh:mm:ss');
    var inputDate = inputFormat.parse(str, true).toLocal(); // <-- dd/MM 24H format
    return inputDate;
  }

  static String dateConvert(String date) {
    var str = date.replaceAll("T", " ");
    str = str.replaceAll("Z", " ");
    var inputFormat = DateFormat('yyyy-MM-dd hh:mm:ss');
    var inputDate =
        inputFormat.parse(str, true).toLocal(); // <-- dd/MM 24H format
    var outputFormat = DateFormat('dd MMM yyyy hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static String onlyTimeConvert(String date) {
    var str = date.replaceAll("T", " ");
    str = str.replaceAll("Z", " ");
    var inputFormat = DateFormat('yyyy-MM-dd hh:mm:ss');
    var inputDate =
        inputFormat.parse(str, true).toLocal(); // <-- dd/MM 24H format
    var outputFormat = DateFormat('hh:mm a');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

  static String onlyDateConvert(String date) {
    var str = date.replaceAll("T", " ");
    str = str.replaceAll("Z", " ");
    var inputFormat = DateFormat('yyyy-MM-dd hh:mm:ss');
    var inputDate =
        inputFormat.parse(str, true).toLocal(); // <-- dd/MM 24H format

    var outputFormat = DateFormat('dd MMM yyyy');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }

/*  static Future<dynamic> mediaPicker(BuildContext context, bool camera, bool photo,
      bool audio, bool video, bool pdf) async {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
            margin:
                const EdgeInsets.only(left: 15, right: 15, bottom: 30, top: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(Icons.drag_handle_outlined),
                (camera)
                    ? ListTile(
                        leading: const Icon(Icons.camera_alt),
                        title: const Text('Camera'),
                        onTap: () async {
                          dynamic result=await navigatorKey.currentState!
                              .pushNamed(RouteName.cameraScreen,arguments: true);
                          FileData? data;
                          try {
                            if (result != null) {
                              data = result as FileData;
                            }
                          } catch (e) {
                            return;
                          }
                          Navigator.pop(context, data);
                        },
                      )
                    : Container(),
            (photo)
                    ? ListTile(
                        leading: const Icon(Icons.photo),
                        title: const Text('Photo'),
                        onTap: () async {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(type: FileType.image);
                          FileData? data;
                          try {
                            if (result != null) {
                              File file = File(result.files.single.path!);
                              data = FileData(CustomFileType.photo, file);
                            }
                          } catch (e) {
                            return;
                          }
                          Navigator.pop(context, data);
                        },
                      )
                    : Container(),
                (video)
                    ? ListTile(
                        leading: const Icon(Icons.videocam),
                        title: const Text('Video'),
                        onTap: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            allowMultiple: false,
                            type: FileType.video,
                          );
                          FileData? data;
                          try {
                            if (result != null) {
                              File file = File(result.files.single.path!);
                              data = FileData(CustomFileType.video, file);
                            }
                          } catch (e) {}

                          Navigator.pop(context, data);
                        },
                      )
                    : Container(),
                (pdf)
                    ? ListTile(
                        leading: const Icon(Icons.insert_drive_file_sharp),
                        title: const Text('PDF'),
                        onTap: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            allowMultiple: false,
                            type: FileType.custom,
                            allowedExtensions: ['pdf'],
                          );
                          FileData? data;
                          try {
                            if (result != null) {
                              File file = File(result.files.single.path!);
                              data = FileData(CustomFileType.pdf, file);
                            }
                          } catch (e) {}

                          Navigator.pop(context, data);
                        },
                      )
                    : Container(),
                (audio)
                    ? ListTile(
                  leading: const Icon(Icons.music_note),
                  title: const Text('Audio'),
                  onTap: () async {
                    FilePickerResult? result =
                    await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.custom,
                      allowedExtensions: ['mp3'],
                    );
                    FileData? data;
                    try {
                      if (result != null) {
                        File file = File(result.files.single.path!);
                        data = FileData(CustomFileType.audio, file);
                      }
                    } catch (e) {}
                    print(data?.type);
                    Navigator.pop(context, data);
                  },
                )
                    : Container(),
              ],
            ),
          );

        });
  }*/

/*  static Future<dynamic> photoPicker(BuildContext context, String type) async {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
            margin:
                const EdgeInsets.only(left: 15, right: 15, bottom: 30, top: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(Icons.drag_handle_outlined),
                ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text('Camera'),
                  onTap: () async {
                    FileData? data;
                    XFile? image=null;
                    try {
                      image = await ImagePicker().pickImage(
                        // source: type == 1 ? ImageSource.camera : ImageSource.gallery,
                          source: ImageSource.camera,
                          imageQuality: 100);
                    }catch(e){

                    }
                    if (image != null) {
                      CroppedFile? croppedFile = await ImageCropper().cropImage(
                          sourcePath: image.path,
                          aspectRatioPresets: Platform.isAndroid
                              ? [
                                  (type == ImageType.profile)
                                      ? CropAspectRatioPreset.square
                                      : CropAspectRatioPreset.ratio16x9,
                                ]
                              : [
                                  (type == ImageType.profile)
                                      ? CropAspectRatioPreset.square
                                      : CropAspectRatioPreset.ratio16x9,
                                ],
                          // androidUiSettings: const AndroidUiSettings(
                          //     toolbarTitle: 'Cropper',
                          //     toolbarColor: colors.primary,
                          //     toolbarWidgetColor: Colors.white,
                          //     initAspectRatio: CropAspectRatioPreset.original,
                          //     lockAspectRatio: false),
                          // iosUiSettings: const IOSUiSettings(
                          //   title: 'Cropper',
                          // )
                      );
                      if (croppedFile != null) {
                        data = FileData(CustomFileType.photo, File(croppedFile.path));
                      }
                    }
                    Navigator.pop(context, data);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text('Gallery'),
                  onTap: () async {
                    FileData? data;
                    XFile? image = await ImagePicker().pickImage(
                        // source: type == 1 ? ImageSource.camera : ImageSource.gallery,
                        source: ImageSource.gallery,
                        imageQuality: 100);
                    if (image != null) {
                      CroppedFile? croppedFile = await ImageCropper().cropImage(
                          sourcePath: image.path,
                          aspectRatioPresets: Platform.isAndroid
                              ? [
                                  (type == ImageType.profile)
                                      ? CropAspectRatioPreset.square
                                      : CropAspectRatioPreset.ratio16x9,
                                ]
                              : [
                                  (type == ImageType.profile)
                                      ? CropAspectRatioPreset.square
                                      : CropAspectRatioPreset.ratio16x9,
                                ],
                          // androidUiSettings: const AndroidUiSettings(
                          //     toolbarTitle: 'Cropper',
                          //     toolbarColor: colors.primary,
                          //     toolbarWidgetColor: Colors.white,
                          //     initAspectRatio: CropAspectRatioPreset.original,
                          //     lockAspectRatio: false),
                          // iosUiSettings: const IOSUiSettings(
                          //   title: 'Cropper',
                          // )
                      );
                      if (croppedFile != null) {
                        data = FileData(CustomFileType.photo, File(croppedFile.path));
                      }
                    }
                    Navigator.pop(context, data);
                  },
                ),
              ],
            ),
          );
        });
  }*/

  static Future<dynamic> mediaPicker(BuildContext context, bool camera,
      bool photo, bool audio, bool video, bool pdf) {
    var menuList = <CupertinoActionSheetAction>[];
    if (camera) {
      menuList.add(CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () async {
          dynamic result = await navigatorKey.currentState!
              .pushNamed(RouteName.cameraScreen, arguments: true);
          FileData? data;
          try {
            if (result != null) {
              data = result as FileData;
            }
          } catch (e) {
            return;
          }
          Navigator.pop(context, data);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 15,
            ),
            Image.asset(
              Images.icon_camera,
              width: 20,
              height: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Camera',
              style: regularBlack16,
            ),
          ],
        ),
      ));
    }
    if (photo) {
      menuList.add(CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () async {
          FilePickerResult? result =
              await FilePicker.platform.pickFiles(type: FileType.image);
          FileData? data;
          try {
            if (result != null) {
              File file = File(result.files.single.path!);
              data = FileData(CustomFileType.photo, file);
            }
          } catch (e) {
            return;
          }
          Navigator.pop(context, data);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 15,
            ),
            Image.asset(
              Images.icon_image,
              width: 20,
              height: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Image',
              style: regularBlack16,
            ),
          ],
        ),
      ));
    }
    if (video) {
      menuList.add(CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            allowMultiple: false,
            type: FileType.video,
          );
          FileData? data;
          try {
            if (result != null) {
              File file = File(result.files.single.path!);
              data = FileData(CustomFileType.video, file);
            }
          } catch (e) {}

          Navigator.pop(context, data);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 15,
            ),
            Image.asset(
              Images.icon_video,
              width: 20,
              height: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Video',
              style: regularBlack16,
            ),
          ],
        ),
      ));
    }
    if (pdf) {
      menuList.add(CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            allowMultiple: false,
            type: FileType.custom,
            allowedExtensions: ['pdf'],
          );
          FileData? data;
          try {
            if (result != null) {
              File file = File(result.files.single.path!);
              data = FileData(CustomFileType.pdf, file);
            }
          } catch (e) {}

          Navigator.pop(context, data);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 15,
            ),
            Image.asset(
              Images.icon_file,
              width: 20,
              height: 20,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'Document',
              style: regularBlack16,
            ),
          ],
        ),
      ));
    }
    if (audio) {
      menuList.add(CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () async {
          FilePickerResult? result = await FilePicker.platform.pickFiles(
            allowMultiple: false,
            type: FileType.custom,
            allowedExtensions: ['mp3'],
          );
          FileData? data;
          try {
            if (result != null) {
              File file = File(result.files.single.path!);
              data = FileData(CustomFileType.audio, file);
            }
          } catch (e) {}
          print(data?.type);
          Navigator.pop(context, data);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 15,
            ),
            const Icon(
              Icons.audiotrack_outlined,
              color: colors.secondary,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'Audio',
              style: regularBlack16,
            ),
          ],
        ),
      ));
    }
    menuList.add(CupertinoActionSheetAction(
      isDestructiveAction: true,
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        'Cancel',
        style: boldBlack16.copyWith(color: colors.secondary),
      ),
    ));
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: menuList,
      ),
    );
  }
  static Future<dynamic> grievancePostMenu(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        builder: (context) {
          return Container(
            margin:
            const EdgeInsets.only(left: 15, right: 15, bottom: 30, top: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 10,),
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 45,
                          height: 5,
                          margin: const EdgeInsets.only(top: 8),
                          decoration: const BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.all(Radius.circular(3.0))
                          ),
                        ),
                      ],
                    ),
                     GestureDetector(
                       onTap: (){
                         Navigator.pop(context, false);
                       },
                       child: const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Icon(Icons.close_outlined,size: 25,),
                          )),
                     )
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context, true);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hide Post",style: boldBlack14,),
                        Text("Instantly hide this post from your personal feed",style: regularBlack12,)
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  static Future<dynamic> photoPicker(BuildContext context, String type) {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () async {
              FileData? data;
              XFile? image = null;
              try {
                image = await ImagePicker().pickImage(
                    // source: type == 1 ? ImageSource.camera : ImageSource.gallery,
                    source: ImageSource.camera,
                    imageQuality: 100);
              } catch (e) {}
              if (image != null) {
                CroppedFile? croppedFile = await ImageCropper().cropImage(
                  sourcePath: image.path,
                  aspectRatioPresets: Platform.isAndroid
                      ? [
                          (type == ImageType.profile)
                              ? CropAspectRatioPreset.square
                              : CropAspectRatioPreset.ratio16x9,
                        ]
                      : [
                          (type == ImageType.profile)
                              ? CropAspectRatioPreset.square
                              : CropAspectRatioPreset.ratio16x9,
                        ],
                  // androidUiSettings: const AndroidUiSettings(
                  //     toolbarTitle: 'Cropper',
                  //     toolbarColor: colors.primary,
                  //     toolbarWidgetColor: Colors.white,
                  //     initAspectRatio: CropAspectRatioPreset.original,
                  //     lockAspectRatio: false),
                  // iosUiSettings: const IOSUiSettings(
                  //   title: 'Cropper',
                  // )
                );
                if (croppedFile != null) {
                  data = FileData(CustomFileType.photo, File(croppedFile.path));
                }
              }
              Navigator.pop(context, data);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 15,
                ),
                Image.asset(
                  Images.icon_camera,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Camera',
                  style: regularBlack16,
                ),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () async {
              FileData? data;
              XFile? image = await ImagePicker().pickImage(
                  // source: type == 1 ? ImageSource.camera : ImageSource.gallery,
                  source: ImageSource.gallery,
                  imageQuality: 100);
              if (image != null) {
                CroppedFile? croppedFile = await ImageCropper().cropImage(
                  sourcePath: image.path,
                  aspectRatioPresets: Platform.isAndroid
                      ? [
                          (type == ImageType.profile)
                              ? CropAspectRatioPreset.square
                              : CropAspectRatioPreset.ratio16x9,
                        ]
                      : [
                          (type == ImageType.profile)
                              ? CropAspectRatioPreset.square
                              : CropAspectRatioPreset.ratio16x9,
                        ],
                  // androidUiSettings: const AndroidUiSettings(
                  //     toolbarTitle: 'Cropper',
                  //     toolbarColor: colors.primary,
                  //     toolbarWidgetColor: Colors.white,
                  //     initAspectRatio: CropAspectRatioPreset.original,
                  //     lockAspectRatio: false),
                  // iosUiSettings: const IOSUiSettings(
                  //   title: 'Cropper',
                  // )
                );
                if (croppedFile != null) {
                  data = FileData(CustomFileType.photo, File(croppedFile.path));
                }
              }
              Navigator.pop(context, data);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 15,
                ),
                Image.asset(
                  Images.icon_image,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Gallery',
                  style: regularBlack16,
                ),
              ],
            ),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: boldBlack16.copyWith(color: colors.secondary),
            ),
          ),
        ],
      ),
    );
  }

  static void shareTile(GlobalKey globalKey,BuildContext context) async {
    //For normal dialog
    ProgressDialog   pr = ProgressDialog(context,type: ProgressDialogType.normal, isDismissible:false, showLogs: true,customBody: Container(height: 50,child: Column(
     mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Please Wait...",style: boldBlack18,)
      ],
    ),));
    pr.show();
    final RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage(pixelRatio: 10);
    final directory = (await getApplicationDocumentsDirectory()).path;
    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List pngBytes = byteData!.buffer.asUint8List();
    File imgFile = File('$directory/photo.png');
    await imgFile.writeAsBytes(pngBytes);
    await Share.shareFiles([imgFile.path]);
    pr.hide();
  }

  static Future<void> launchInBrowser(String url) async {
    if(!url.startsWith("http")){
      url="https://$url";
    }
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  static String getNumberCount(String? numberToFormat) {
    //return numberToFormat;
    numberToFormat ??= "0";
    if (int.parse(numberToFormat) > 999) {
      return NumberFormat.compactCurrency(
        decimalDigits: 2,
        symbol:
            '', // if you want to add currency symbol then pass that in this else leave it empty.
      ).format(int.parse(numberToFormat));
    } else {
      return numberToFormat;
    }
  }

  static Widget getCommentAndLouder(String? totalComment,String? totalLouder,Grievance model,VoidCallback? onComment) {
    //return numberToFormat;
    totalComment ??= "0";
    int comments=int.parse(totalComment);
    var commentText = comments.toString();
    if (comments> 999) {
      commentText = NumberFormat.compactCurrency(
        decimalDigits: 2,
        symbol:
        '', // if you want to add currency symbol then pass that in this else leave it empty.
      ).format(comments);
    }

    totalLouder ??= "0";
    int louder=int.parse(totalLouder);
    var louderText = louder.toString();
    if (louder> 999) {
      louderText = NumberFormat.compactCurrency(
        decimalDigits: 2,
        symbol:
        '', // if you want to add currency symbol then pass that in this else leave it empty.
      ).format(louder);
    }

   return Row(
     children: [
       (comments==0)?Container():GestureDetector(
         onTap:onComment,
         child: Container(
           padding: EdgeInsets.only(top: 10,bottom:10),
           child: Text(
               (comments==1)?"1 Comment":"$commentText Comments",style: regularGray12,
           ),
         ),
       ),
       (louder==0)?Container():GestureDetector(
         onTap:() {
           navigatorKey.currentState!.pushNamed(RouteName.louderScreen,arguments: model);
         },
         child: Container(
           padding: EdgeInsets.only(top: 10,bottom:10),
           child: Text(
               (comments!=0)?" - $louderText X Louder":"$louderText X Louder"
             ,style: regularGray12,
           ),
         ),
       ),
       SizedBox(width: 10,)
     ],
   );
  }

  static Widget getNumberFeelYou(String? numberToFormat, bool? isFeel) {
    //return numberToFormat;
    numberToFormat ??= "0";
    isFeel ??= false;
    if (numberToFormat.isNotEmpty) {
      var count = int.parse(numberToFormat);
      if (count == 0) {
        return Container();
      }
      var text = "";
      if (isFeel && count == 1) {
        text = "you";
      } else if (isFeel && count == 2) {
        text = "you and 1 other";
      } else if (isFeel && count > 2) {
        count = count - 1;
        var c = count.toString();
        if (count > 999) {
          c = NumberFormat.compactCurrency(
            decimalDigits: 2,
            symbol:
                '', // if you want to add currency symbol then pass that in this else leave it empty.
          ).format(count);
        }
        text = "you and $c others";
      } else {
        var c = count.toString();
        if (count> 999) {
          c = NumberFormat.compactCurrency(
            decimalDigits: 2,
            symbol:
            '', // if you want to add currency symbol then pass that in this else leave it empty.
          ).format(count);
        }
        text = "$c";
      }
      return Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Image.asset(
            isFeel ? Images.ic_feel_selected : Images.ic_feel,
            width: 15,
            height: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            text,
            style: regularGray12,
          )
        ],
      );
    } else {
      return Container();
    }
    // if (int.parse(numberToFormat) > 999) {
    //   return NumberFormat.compactCurrency(
    //     decimalDigits: 2,
    //     symbol:
    //         '', // if you want to add currency symbol then pass that in this else leave it empty.
    //   ).format(int.parse(numberToFormat));
    // } else  if ( == 0) {
    //   return "0";
    // } else {
    //   return "<1K";
    // }
  }

  static String timeAgo(String date, {bool numericDates = false}) {
    try {
      var str = date.replaceAll("T", " ");
      str = str.replaceAll("Z", " ");
      var inputFormat = DateFormat('yyyy-MM-dd hh:mm:ss');
      var inputDate = inputFormat.parse(str, true).toLocal();

      // var outputFormat = DateFormat('dd MMM yyyy hh:mm:ss aaa');
      // var outputDate = outputFormat.format(inputDate);
      // return outputDate;

      final date2 = DateTime.now();
      final difference = date2.difference(inputDate);

      if ((difference.inDays / 7).floor() >= 1) {
        return (numericDates) ? '1 week ago' : onlyDateConvert(date);
      } else if (difference.inDays >= 2) {
        return '${difference.inDays} days ago';
      } else if (difference.inDays >= 1) {
        return (numericDates) ? '1 day ago' : 'Yesterday';
      } else if (difference.inHours >= 2) {
        return '${difference.inHours} hours ago';
      } else if (difference.inHours >= 1) {
        return (numericDates) ? '1 hour ago' : 'An hour ago';
      } else if (difference.inMinutes >= 2) {
        return '${difference.inMinutes} minutes ago';
      } else if (difference.inMinutes >= 1) {
        return (numericDates) ? '1 minute ago' : 'A minute ago';
      } else if (difference.inSeconds >= 3) {
        return '${difference.inSeconds} seconds ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return "";
    }
  }
  static String chatTimeAgo(DateTime d) {
    try {
      var date=DateTime(d.year,d.month,d.day);
      final now = DateTime.now();
      final date2 = DateTime(now.year,now.month,now.day);
      final difference = date2.difference(date);
      print("+++ "+ date.day.toString()+ " +++ "+date2.day.toString());
      print("===> "+ difference.inDays.toString());
      if (difference.inDays == 1) {
        return  'Yesterday';
      }else if (difference.inDays == 0) {
        return  'Today';
      }else{
        var outputFormat = DateFormat('dd MMM yyyy');
        var outputDate = outputFormat.format(date);
        return outputDate;
      }
    } catch (e) {
      return "";
    }
  }

  static String timeAgoForPost(String date, {bool numericDates = false}) {
    try {
      print("============ $date ============");
      var str = date.replaceAll("T", " ");
      str = str.replaceAll("Z", " ");
      var inputFormat = DateFormat('yyyy-MM-dd hh:mm:ss');
      var inputDate = inputFormat.parse(str, true).toLocal();

      // var outputFormat = DateFormat('dd MMM yyyy hh:mm:ss aaa');
      // var outputDate = outputFormat.format(inputDate);
      // return outputDate;

      final date2 = DateTime.now();
      final difference = date2.difference(inputDate);
      if ((difference.inDays / 7).floor() >= 1) {
        return (numericDates) ? '1w' : onlyDateConvert(date);
      } else if (difference.inDays >= 2) {
        return '${difference.inDays}d';
      } else if (difference.inDays >= 1) {
        return (numericDates) ? '1d' : 'Yesterday';
      } else if (difference.inHours >= 2) {
        return '${difference.inHours}h';
      } else if (difference.inHours >= 1) {
        return (numericDates) ? '1h' : '1h';
      } else if (difference.inMinutes >= 2) {
        return '${difference.inMinutes}min';
      } else if (difference.inMinutes >= 1) {
        return (numericDates) ? '1min' : 'A minute ago';
      } else if (difference.inSeconds >= 3) {
        return '${difference.inSeconds}sec';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return "";
    }
  }

  static int getTime(String date) {
    try {
      var str = date.replaceAll("T", " ");
      str = str.replaceAll("Z", " ");
      var inputFormat = DateFormat('yyyy-MM-dd hh:mm:ss');
      var inputDate = inputFormat.parse(str, true).toLocal();

      // var outputFormat = DateFormat('dd MMM yyyy hh:mm:ss aaa');
      // var outputDate = outputFormat.format(inputDate);
      // return outputDate;

      final date2 = DateTime.now();
      final difference = date2.difference(inputDate);
      var hours = difference.inDays * 24;
      var total = difference.inHours + hours;
      return total;
    } catch (e) {
      return 0;
    }
  }

  static Future<dynamic> customConfirmDialog(BuildContext context, String title,{String yes="Yes",String no="No",Color yesButton=colors.secondary}) {
    return  showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return  Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child:Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(15.0),
                  margin: const EdgeInsets.only(top: 25.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: 15,),
                      Text(title,style: regularBlack14,textAlign: TextAlign.center,),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap:(){
                              Navigator.pop(context,false);
                            },
                            child: Container(
                              width: 85,
                              height: 30,
                            decoration: BoxDecoration(
                              color: colors.grayTemp,
                              borderRadius: const BorderRadius.all(Radius.circular(15.0))
                            ),
                            child: Center(child: Text(no, style: boldWhite14,)),
                        ),
                          ),
                          const SizedBox(width: 30,),
                          GestureDetector(
                            onTap: (){
                              Navigator.pop(context,true);
                            },
                            child: Container(
                              width: 85,
                              height: 30,
                            decoration:  BoxDecoration(
                              color: yesButton,
                              borderRadius: const BorderRadius.all(Radius.circular(15.0))
                            ),
                            child: Center(child: Text(yes, style: boldWhite14,)),
                        ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class NavigationMethod {
  static void moveToGrievanceDetails(Grievance model) {
    navigatorKey.currentState!.pushNamed(RouteName.grievanceDetailsScreen, arguments: model);
  }

  static Future<dynamic> moveToFollower(String type, String user_id,String total,{String profile_type="user"}) {
    var argument = HashMap<String, String>();
    argument[Constants.type] = type;
    argument[Constants.user_id] = user_id;
    argument[Constants.total] = total;
    argument[Constants.profile_type] = profile_type;
    return navigatorKey.currentState!.pushNamed(RouteName.followersScreen, arguments: argument);
  }
}

class ToastUtils {
  static void showToast(String str) {
    // Fluttertoast.showToast(
    //     msg: str,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.grey,
    //     textColor: Colors.black87,
    //     fontSize: 16.0);
  }

  static void setSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        textAlign: TextAlign.center,
        style: TextStyle(color: Theme.of(context).colorScheme.fontColor),
      ),
      elevation: 1.0,
      backgroundColor: colors.primary,
    ));
  }

  static void showErrorDialog(String message, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
}

class ConnectionChecker {
  static Future<bool> check(BuildContext context) async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      ConnectivityResult result = await Connectivity().checkConnectivity();
      if (result == ConnectivityResult.mobile) {
        return true;
      } else if (result == ConnectivityResult.wifi) {
        return true;
      }
    } on PlatformException catch (e) {}
    _noInternetConnectionDialog(context);
    return false;
  }

  static Future _noInternetConnectionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'No Connection!',
            style: boldBlack16,
          ),
          content: Text(
            'Check your internet connection to proceed further',
            style: regularBlack14,
          ),
          actions: [
            TextButton(
              child: Text(
                'Okay',
                style: regularBlack14.copyWith(color: colors.secondary),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

bool isEmail(String em) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = RegExp(p);
  return regExp.hasMatch(em);
}

bool isPhone(String input) =>
    RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
        .hasMatch(input);
