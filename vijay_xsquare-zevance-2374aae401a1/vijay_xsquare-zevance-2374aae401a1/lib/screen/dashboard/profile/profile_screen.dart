import 'dart:convert';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:grievance/common/custom/info_dialog.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/provider/AuthProvider.dart';
import 'package:grievance/provider/ProfileProvider.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import '../../../model/Zevance.dart';

class ProfileScreen extends StatefulWidget {
  final dynamic _argument;

  const ProfileScreen(this._argument, {Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  Users? users;
  Zevance? zevance;

  @override
  void initState() {
    super.initState();
    users = widget._argument as Users;
    getUserDetails();
    callProfileDetailsApi();
    getZevanceDetails();
  }

  @override
  void dispose() {
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
            child: Container(
              padding: const EdgeInsets.all(15),
              child: const Image(image: AssetImage(Images.ic_back)),
            )),
        title: Text(
          "My Profile",
          style: boldBlack18,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _profileInfo(),
            Container(
              color: colors.backgroundColor,
              child: Container(
                padding: const EdgeInsets.only(top: 15),
                decoration: const BoxDecoration(
                    color: colors.whiteTemp,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25.0),
                        topLeft: Radius.circular(25.0))),
                child: _menuInfo(),
              ),
            ),
            Container(
              color: colors.whiteTemp,
              padding: const EdgeInsets.only(
                  left: 25, right: 25, top: 60, bottom: 40),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: regularBlack12,
                  children: [
                    const TextSpan(text: "Please find our "),
                    TextSpan(
                      text: 'Privacy policy, ',
                      style: regularBlack12.copyWith(color: colors.secondary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Utils.launchInBrowser(Constants.privacy_url);
                        },
                    ),
                    TextSpan(
                      text: 'FAQ and ',
                      style: regularBlack12.copyWith(color: colors.secondary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Utils.launchInBrowser(Constants.faq_url);
                        },
                    ),
                    TextSpan(
                      text: 'Terms of use ',
                      style: regularBlack12.copyWith(color: colors.secondary),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Utils.launchInBrowser(Constants.terms_and_conditions_url);
                        },
                    ),
                    const TextSpan(text: "in these links."),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _profileInfo() {
    var height = 150.0;
    return Container(
      color: colors.backgroundColor,
      child: Column(
        children: [
          Container(
            child: Stack(
              children: [
                (users != null && users!.coverImage != null)
                    ? FadeInImage(
                    fadeInDuration: const Duration(milliseconds: 150),
                    image: (users != null &&
                        users?.coverImage != null &&
                        users!.coverImage!.isNotEmpty)
                        ? NetworkImage(users!.coverImage!)
                        : const NetworkImage(
                        'https://yourlawnwise.com/wp-content.png'),
                    height: height,
                    width: deviceWidth,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Image.asset(
                          Images.profile_cover,
                          fit: BoxFit.cover,
                          width: deviceWidth,
                          height: height,
                        ),
                    placeholderErrorBuilder: (context, error, stackTrace) =>
                        Image.asset(
                          Images.profile_cover,
                          fit: BoxFit.cover,
                          width: deviceWidth,
                          height: height,
                        ),
                    placeholder: const AssetImage(Images.profile_cover))
                    : Image.asset(Images.rectangle_placeholder,
                        height: height, width: deviceWidth, fit: BoxFit.cover),
                Center(
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    margin: const EdgeInsets.only(top: 100),
                    decoration: BoxDecoration(
                      color: colors.grayLight,
                      image: DecorationImage(
                        image: NetworkImage(
                            (users != null && users!.image != null)
                                ? users!.image!
                                : BASE_URL),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                      border: Border.all(
                        color: colors.whiteTemp,
                        width: 4.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            "${users?.name}",
            style: boldBlack16,
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Text(
              "${users?.userable?.headline}",
              style: regularGray12,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            height: 1,
            color: colors.grayLight,
            margin:
                const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  NavigationMethod.moveToFollower(
                          FollowerType.follower, users!.id!,users!.followers!)
                      .then((value) => callProfileDetailsApi());
                },
                child: Column(
                  children: [
                    Text(
                      "${users?.followers}",
                      style: boldBlack14,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Followers",
                      style: regularGray12,
                    ),
                  ],
                ),
              )),
              Container(
                height: 30,
                width: 1,
                color: colors.grayTemp,
              ),
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  NavigationMethod.moveToFollower(
                          FollowerType.following, users!.id!,users!.following!)
                      .then((value) => callProfileDetailsApi());
                },
                child: Column(
                  children: [
                    Text(
                      "${users?.following}",
                      style: boldBlack14,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Following",
                      style: regularGray12,
                    ),
                  ],
                ),
              )),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  _menuInfo() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            navigatorKey.currentState!
                .pushNamed(RouteName.ticketManagementScreen, arguments: users);
          },
          child: _menuItem(Images.ic_ticket, "My Grievances", true),
        ),
        // GestureDetector(
        //   onTap: () {
        //     navigatorKey.currentState!.pushNamed(RouteName.notificationScreen);
        //   },
        //   child: _menuItem(Images.ic_notification, "Notifications", true),
        // ),
        GestureDetector(
          onTap: () {
            navigatorKey.currentState!
                .pushNamed(RouteName.profileSettingScreen)
                .then((value) => callProfileDetailsApi());
          },
          child: _menuItem(Images.ic_setting, "Profile Settings", true),
        ),
        // GestureDetector(
        //   onTap: () {
        //     navigatorKey.currentState!.pushNamed(RouteName.zivanceScreen,arguments: zevance).then((value){
        //       getZevanceDetails();
        //     });
        //   },
        //   child: _menuItem(Images.ic_z, "Zevance for Business", true),
        // ),
        // GestureDetector(
        //   onTap: () {
        //     navigatorKey.currentState!.pushNamed(RouteName.areaInterestScreen);
        //   },
        //   child: _menuItem(Images.ic_feel, "My Interest", true),
        // ),
        // GestureDetector(
        //   onTap: () {
        //     Utils.launchInBrowser(Constants.privacy_url);
        //   },
        //   child: _menuItem(Images.ic_privacy, "Privacy Policy", true),
        // ),
        // GestureDetector(
        //   onTap: () {
        //     Utils.launchInBrowser(Constants.terms_and_conditions_url);
        //   },
        //   child: _menuItem(Images.ic_terms_and_conditions, "Terms & Condition", true),
        // ),
        GestureDetector(
          onTap: () {
            _logoutConfirmDialog(context);
          },
          child: _menuItem(Images.ic_logout, "Logout", false),
        ),
        GestureDetector(
          onTap: () {
            _deleteAccountDialog(context);
          },
          child:
              _menuDeleteItem(Images.delete_menu_icon, "Delete Account", false),
        ),
      ],
    );
  }

  _menuItem(String icon, String name, bool next) {
    return Container(
      color: colors.whiteTemp,
      padding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[300]),
            child: Image.asset(
              icon,
              color: colors.blackTemp,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            name,
            style: boldBlack12,
          ),
          const Spacer(),
          (next)
              ? Container(
                  width: 25,
                  height: 30,
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    Images.ic_next_arrow,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  _menuDeleteItem(String icon, String name, bool next) {
    return Container(
      color: colors.whiteTemp,
      padding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 10),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.grey[300]),
            child: Image.asset(
              icon,
              color: colors.redDark,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            name,
            style: boldBlack12.copyWith(
              color: colors.redDark,
              decoration: TextDecoration.underline,
            ),
          ),
          const Spacer(),
          (next)
              ? Container(
                  width: 25,
                  height: 30,
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    Images.ic_next_arrow,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  void _logoutConfirmDialog(BuildContext context) {
    Utils.customConfirmDialog(context, "Are you sure you want to logout?",yes: "Logout")
        .then((value) {
      if (value == true) {
        logout();
      }
    });
    // return showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title:  Text('Logout',style: boldBlack16,),
    //       content:  Text('Are you sure you want to logout?',style: regularBlack14,),
    //       actions: [
    //         TextButton(
    //           child:  Text('Yes',style: regularBlack14.copyWith(color: colors.secondary),),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //
    //           },
    //         ),
    //         TextButton(
    //           child:  Text('No',style: regularBlack14,),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  void _deleteAccountDialog(BuildContext context) {
    Utils.customConfirmDialog(context, "Do you really want to delete?",yes: "Delete",yesButton: colors.redDark)
        .then((value) {
      if (value == true) {
        deleteAccountApiCall();
      }
    });
  }

  Future<void> deleteAccountApiCall() async {
    ProgressDialog   pr = ProgressDialog(context,type: ProgressDialogType.normal, isDismissible:false, showLogs: true,customBody: Container(height: 50,child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Please Wait...",style: boldBlack18,)
      ],
    ),));
    pr.show();
    try {
      await Provider.of<AuthProvider>(context, listen: false)
          .deleteAccountApi(context)
          .then((value) {
        pr.hide();
        if (value == true) {
          deleteAccountSuccessDialog();
        }
      });
    } on HttpException catch (error) {
    } catch (error) {}
  }

  void deleteAccountSuccessDialog(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return InfoDialogBox(
            title: "We have taken your request to delete your account. You will not be able to access your account or data anymore after 30 days.",
            descriptions:"",
            titleCenter: true,
            closePress: () {
            logout();
            },
          );
        });
  }

  void logout() async {
    var pref = await SharedPreferences.getInstance();
    pref.clear();
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
        RouteName.phoneAuthScreen, (route) => false,
        arguments: 0);
  }

  void callProfileDetailsApi() async {
    try {
      await Provider.of<ProfileProvider>(context, listen: false)
          .getProfile(context)
          .then((value) {
        if (value != null) {
          setState(() {
            users = value;
          });
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

  void getZevanceDetails() async {
    try {
      // Log user in

      await Provider.of<ProfileProvider>(context, listen: false)
          .getZevanceDetails()
          .then((value) {
        responseZevance(value);
      });
    } on HttpException catch (error) {
      //await buttonController!.reverse();
      print(error);
    } catch (error) {
      //await buttonController!.reverse();
      print(error);
    }
  }

  void responseZevance(Zevance? value) async {
    zevance = value;
  }

}
