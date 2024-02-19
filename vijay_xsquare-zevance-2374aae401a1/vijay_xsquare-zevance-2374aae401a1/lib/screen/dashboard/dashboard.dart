import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grievance/common/custom/info_dialog.dart';
import 'package:grievance/common/widget/PostChatWidget.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/provider/GrievanceProvider.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../theme/color.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  List<Grievance> list = [];
  int page = 1;
  bool _isLoading = false;
  Users? users;

  int notificationCount = 0;

  ScrollController controller = ScrollController();

  void _scrollListener() {
    if (!_isLoading) {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        grievanceListApiCall();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getUserDetails();
    controller = ScrollController()..addListener(_scrollListener);
    grievanceListApiCall();
    getNotificationCount();
    getFcmToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      appBar: _appBar(),
      body: RefreshIndicator(
        color: colors.primary,
        onRefresh: () {
          return Future.delayed(
            const Duration(microseconds: 10),
            () {
              page = 1;
              grievanceListApiCall();
              getNotificationCount();
            },
          );
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: controller,
              child: Column(
                children: [
                  // _storyList(),
                  _postItemWidget(),
                  (_isLoading && page == 1)
                      ? shimmer(context)
                      : _grievanceWidget(),
                  const SizedBox(
                    height: 200,
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _bottomNavigation(),
            )
          ],
        ),
      ),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: colors.whiteTemp,
      automaticallyImplyLeading: false,
      title: GestureDetector(
          onTap: _scrollToTop,
          child: Container(
            padding: const EdgeInsets.only(top: 25, bottom: 25),
            child: Image.asset(Images.ic_zevance, height: 30),
          )),
      centerTitle: false,
      actions: [
        GestureDetector(
          onTap: () {
            navigatorKey.currentState!
                .pushNamed(RouteName.searchGrievanceScreen);
          },
          child: Container(
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
            height: 35,
            width: 35,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                color: Colors.grey[200]),
            child: Image.asset(Images.ic_search),
          ),
        ),
        // GestureDetector(
        //   onTap: () {
        //     navigatorKey.currentState!.pushNamed(RouteName.notificationScreen).then((value) {
        //       getNotificationCount();
        //     });
        //   },
        //   child: Stack(
        //     children: [
        //       Container(
        //         margin: const EdgeInsets.only(
        //             top: 10, bottom: 10, left: 0, right: 10),
        //         height: 35,
        //         width: 35,
        //         padding: EdgeInsets.all(9),
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(4.0),
        //             color: Colors.grey[200]),
        //         child: Image.asset(Images.notification_dash),
        //       ),
        //       (notificationCount != 0)
        //           ? Positioned.directional(
        //               top: 0,
        //               textDirection: Directionality.of(context),
        //               end: 0,
        //               child: Container(
        //                 decoration: const BoxDecoration(
        //                     shape: BoxShape.circle,
        //                     gradient: LinearGradient(colors: [
        //                       colors.firstColor,
        //                       colors.secondColor
        //                     ]),
        //                     color: colors.primary),
        //                 child: Center(
        //                   child: Padding(
        //                     padding: EdgeInsets.all(5),
        //                     child: Text(
        //                       "${notificationCount}",
        //                       style: TextStyle(
        //                           fontSize: 12,
        //                           fontWeight: FontWeight.bold,
        //                           color: Theme.of(context).colorScheme.white),
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             )
        //           : Container()
        //     ],
        //   ),
        // ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }

  _storyItemWidget(int index) {
    return GestureDetector(
      onTap: () {
        navigatorKey.currentState!.pushNamed(RouteName.companyProfileScreen);
      },
      child: SizedBox(
        width: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 55.0,
              height: 55.0,
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                color: colors.grayLight,
                image: DecorationImage(
                  image: NetworkImage('https://i.pravatar.cc/150?img=$index'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
                border: Border.all(
                  color: (index == 1) ? colors.primary : colors.blackTemp,
                  width: 2.0,
                ),
              ),
            ),
            Text(
              "Angle Den",
              style: regularBlack10,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  _postItemWidget() {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      color: colors.whiteTemp,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              navigatorKey.currentState!
                  .pushNamed(RouteName.profileScreen, arguments: users);
            },
            child: Container(
              margin: const EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                color: colors.grayLight,
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                border: Border.all(
                  color: colors.grayLight,
                  width: 2.0,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22.0),
                child: FadeInImage(
                    fadeInDuration: const Duration(milliseconds: 150),
                    image: (users != null && users!.image!.isNotEmpty)
                        ? NetworkImage(users!.image!)
                        : const NetworkImage(
                            'https://cdn.osxdaily.com/wp-content/uploads/2015/04/photos.jpg'),
                    width: 40.0,
                    height: 40.0,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Image.asset(
                          Images.person_placeholder,
                          fit: BoxFit.cover,
                          width: 40.0,
                          height: 40.0,
                        ),
                    placeholderErrorBuilder: (context, error, stackTrace) =>
                        Image.asset(
                          Images.person_placeholder,
                          fit: BoxFit.cover,
                          width: 40.0,
                          height: 40.0,
                        ),
                    placeholder: const AssetImage(Images.person_placeholder)),
              ),
            ),
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                navigatorKey.currentState!
                    .pushNamed(RouteName.addGrievanceScreen);
              },
              child: Container(
                margin: const EdgeInsets.only(left: 5, right: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: colors.grayLight, width: 1)),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  style: regularBlack14,
                  focusNode: FocusNode(),
                  enabled: false,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.add_outlined,
                        size: 20,
                      ),
                      hintStyle: regularGray14,
                      hintText: "Add Your Grievance",
                      fillColor: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _storyList() {
    return Container(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return _storyItemWidget(index);
        },
      ),
    );
  }

  _divider() {
    return Container(
      height: 1,
      color: Colors.grey[300],
      margin: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 15,
      ),
    );
  }

  _grievanceWidget() {
    return ListView.builder(
        // padding: const EdgeInsets.only(top: 7.5),
        itemCount: list.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext ctxt, int index) {
          return PostChatWidget(
            model: list[index],
            userID: users!.id,
            onMakeLouder: () => {_clickMakeLouder(index)},
            onFeelYou: () => {_clickFeelYou(index)},
            onMenuClick: () => {_clickGrievanceMenu(index)},
          );
        });
  }

  _bottomNavigation() {
    return Container(
      height: 90,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 35),
            padding: const EdgeInsets.all(5.0),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            height: 55,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _scrollToTop,
                    child: Container(
                      color: colors.whiteTemp,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 6, right: 6),
                            child: const Icon(
                              Icons.home_filled,
                              size: 25,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            "Home",
                            style: boldGray12.copyWith(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 100,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      navigatorKey.currentState!
                          .pushNamed(RouteName.cameraScreen, arguments: false);
                    },
                    child: Container(
                      color: colors.whiteTemp,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 6, right: 6),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 25,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            "Camera",
                            style: boldGray12.copyWith(color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              navigatorKey.currentState!
                  .pushNamed(RouteName.addGrievanceScreen);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 40,
                  height: 50,
                  margin: const EdgeInsets.only(top: 0),
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: colors.greenShado,
                          blurRadius: 10.0,
                        ),
                      ],
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          colors: [colors.firstColor, colors.secondColor])),
                  child: const Icon(
                    Icons.add,
                    size: 25,
                    color: colors.whiteTemp,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Submit Grievance",
                  style: regularPrimary12,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> grievanceListApiCall() async {
    if (kDebugMode) {
      print(_isLoading);
    }
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<GrievanceProvider>(context, listen: false)
            .getGrievanceByPageAndType(context, page, DataType.all)
            .then((value) => {grievanceListResponse(value)});
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

  void grievanceListResponse(List<Grievance> data) async {
    if (page == 1) list.clear();
    page = page + 1;
    setState(() {
      _isLoading = false;
      list.addAll(data);
    });
//     if(!list.isEmpty){
// searchProductApiCall();
//     }
  }

  Widget shimmer(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Shimmer.fromColors(
        baseColor: Theme.of(context).colorScheme.simmerBase,
        highlightColor: Theme.of(context).colorScheme.simmerHigh,
        child: SingleChildScrollView(
          child: Column(
            children: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                .map((_) => Padding(
                      padding: const EdgeInsetsDirectional.only(bottom: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              height: 180.0,
                              color: Theme.of(context).colorScheme.white,
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }

  _clickGrievanceMenu(int index) {
    Utils.grievancePostMenu(context).then((value) => {
          if (value != null && value == true)
            {
              Utils.customConfirmDialog(
                      context, "Are you sure you want to hide this post?")
                  .then((value) {
                if (value == true) {
                  hidePostApiCall(list[index].id!, index);
                }
              })
            }
        });
  }

  _clickFeelYou(int index) {
    setState(() {
      if (list[index].isFeel) {
        list[index].totalFeel =
            (int.parse(list[index].totalFeel!) - 1).toString();
      } else {
        list[index].totalFeel =
            (int.parse(list[index].totalFeel!) + 1).toString();
      }
      list[index].isFeel = !list[index].isFeel;
    });
    updateFeelApiCall(list[index].id!);
  }

  Future<void> updateFeelApiCall(String grievanceId) async {
    try {
      await Provider.of<GrievanceProvider>(context, listen: false)
          .updateFeelYouApi(context, grievanceId)
          .then((value) => {

      });
    } on HttpException catch (error) {
    } catch (error) {}
  }

  Future<void> hidePostApiCall(String grievanceId, int index) async {

    try {
      await Provider.of<GrievanceProvider>(context, listen: false)
          .hidePostApi(context, grievanceId)
          .then((value) {
        if (value == true) {
          setState(() {
            list[index].isHide = !list[index].isHide;
          });
          hidePostSuccessDialog();
        }
      });
    } on HttpException catch (error) {
    } catch (error) {}
  }

  void hidePostSuccessDialog(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return InfoDialogBox(
            title: "Post hidden successfully!",
            descriptions:"",
            closePress: () {
              // nextMove(value);
              //
            },
          );
        });
  }

  _clickMakeLouder(int index) {
    setState(() {
      if (list[index].isLouder) {
        list[index].totalLoud =
            (int.parse(list[index].totalLoud!) - 1).toString();
      } else {
        list[index].totalLoud =
            (int.parse(list[index].totalLoud!) + 1).toString();
      }
      list[index].isLouder = !list[index].isLouder;
    });
    updateLouderApiCall(list[index].id!);
  }

  Future<void> getNotificationCount() async {
    try {
      await Provider.of<GrievanceProvider>(context, listen: false)
          .getNotificationCount()
          .then((value) {
        setState(() {
          notificationCount = value;
        });
      });
    }  catch (error) {}
  }

  Future<void> updateLouderApiCall(String grievanceId) async {
    try {
      await Provider.of<GrievanceProvider>(context, listen: false)
          .updateLouderApi(context, grievanceId, LouderType.grievance)
          .then((value) => {});
    } on HttpException catch (error) {
    } catch (error) {}
  }

  void getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    var userDate = prefs.getString(Constants.user);
    setState(() {
      users = Users.fromJson(json.decode(userDate!));
    });
  }

  void _scrollToTop() {
    controller.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  void getFcmToken() async {
    if (Platform.isAndroid) {
     var firebaseToken = (await FirebaseMessaging.instance.getToken())!;
      print("androidToken is " + firebaseToken);
    } else {
      var  firebaseToken = (await FirebaseMessaging.instance.getToken())!;
      print("iosToken is " + firebaseToken);
    }
  }
}
