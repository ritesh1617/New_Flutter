//ProfileSettingScreen

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grievance/common/widget/AsyncTextFormField.dart';
import 'package:grievance/common/widget/button.dart';
import 'package:grievance/common/widget/textfield.dart';
import 'package:grievance/common/widget/textfield_pass.dart';
import 'package:grievance/model/FileData.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/provider/AuthProvider.dart';
import 'package:grievance/provider/GrievanceProvider.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:popover/popover.dart' show PopoverDirection, showPopover;

class ProfileSettingScreen extends StatefulWidget {
  ProfileSettingScreen({Key? key}) : super(key: key);

  @override
  _ProfileSettingScreenState createState() => _ProfileSettingScreenState();
}

class _ProfileSettingScreenState extends State<ProfileSettingScreen>
    with TickerProviderStateMixin {
  //Create Profile Controller
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _headLineController = TextEditingController(text: Lables.headline_common);
  final TextEditingController _pincodeController = TextEditingController();

  Users? users;
  bool isUsername = false;

  //Button Animation
  Animation? buttonAnimation;
  AnimationController? buttonController;

  Users? user;
  bool phoneDisable = true;
  var height = 150.0;

  FileData? fileProfilePic;
  FileData? fileCover;

  Future<bool> isValidUsername(String username) async {
    isUsername = await Provider.of<GrievanceProvider>(context, listen: false)
        .usernameVerifyApi(context, username);
    return isUsername;
  }

  Future<Null> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  @override
  void initState() {
    super.initState();


    getData();
    buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    buttonAnimation = Tween(
      begin: deviceWidth! - 40,
      end: 50.0,
    ).animate(CurvedAnimation(
      parent: buttonController!,
      curve: const Interval(
        0.0,
        0.150,
      ),
    ));
  }

  @override
  void dispose() {
    super.dispose();
    buttonController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        navigatorKey.currentState!.pop();
        return false;
      },
      child: Scaffold(
        backgroundColor: colors.backgroundColor,
        appBar: AppBar(
          backgroundColor: colors.backgroundColor,
          leading:GestureDetector(
              onTap: () {
                navigatorKey.currentState!.pop();
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                child: const Image(image: AssetImage(Images.ic_back)),
              )),
          title: Text(
            "Profile Settings",
            style: boldBlack18,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Stack(
                  children: [
                    (fileCover != null)
                        ? Image.file(
                      fileCover!.file,
                      height: height,
                      width: deviceWidth,
                      fit: BoxFit.cover,
                    )
                        : FadeInImage(
                        fadeInDuration: const Duration(milliseconds: 150),
                        image: (user != null &&
                            user?.coverImage != null &&
                            user!.coverImage!.isNotEmpty)
                            ? NetworkImage(user!.coverImage!)
                            : const NetworkImage('https://yourlawnwise.com/wp-content.png'),
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
                        placeholder: const AssetImage(Images.profile_cover)),
                    Center(
                      child:
                      GestureDetector(
                        onTap: () async {
                          Utils.photoPicker(context, ImageType.profile)
                              .then((value) {
                            if (value != null) {
                              setState(() {
                                fileProfilePic = value as FileData;
                              });
                            }
                          });
                        },
                        child: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 100),
                              decoration: BoxDecoration(
                                color: colors.grayLight,
                                borderRadius:
                                const BorderRadius.all(Radius.circular(50.0)),
                                border: Border.all(
                                  color: colors.whiteTemp,
                                  width: 4.0,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: (fileProfilePic != null)
                                    ? Image.file(
                                  fileProfilePic!.file,
                                  height: 90.0,
                                  width: 90.0,
                                  fit: BoxFit.cover,
                                )
                                    : FadeInImage(
                                    fadeInDuration:
                                    const Duration(milliseconds: 150),
                                    image: NetworkImage(
                                        (user != null && user!.image != null)
                                            ? user!.image!
                                            : BASE_URL),
                                    width: 90.0,
                                    height: 90.0,
                                    fit: BoxFit.cover,
                                    imageErrorBuilder:
                                        (context, error, stackTrace) =>
                                        Image.asset(
                                          Images.person_placeholder,
                                          fit: BoxFit.cover,
                                          width: 90.0,
                                          height: 90.0,
                                        ),
                                    placeholderErrorBuilder:
                                        (context, error, stackTrace) =>
                                        Image.asset(
                                          Images.person_placeholder,
                                          fit: BoxFit.cover,
                                          width: 90.0,
                                          height: 90.0,
                                        ),
                                    placeholder: const AssetImage(
                                        Images.person_placeholder)),
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 100),
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: colors.black38,
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(50.0)),
                                  border: Border.all(
                                    color: colors.whiteTemp,
                                    width: 4.0,
                                  ),
                                )),
                            const Positioned(
                              bottom: 40,
                              left: 40,
                              child: Icon(
                                Icons.edit_outlined,
                                color: colors.whiteTemp,
                                size: 25,
                              ),
                            )
                          ],
                        ),
                      ),

                    ),
                    Positioned(
                        right: 20,
                        top: 15,
                        child: GestureDetector(
                            onTap: () async {
                              Utils.photoPicker(context, ImageType.cover)
                                  .then((value) {
                                if (value != null) {
                                  setState(() {
                                    fileCover = value as FileData;
                                  });
                                }
                              });
                            },
                            child: Text(
                              "Edit",
                              style: regularWhite16,
                            )))
                  ],
                ),
                CTextField(
                  hintText: "Enter First Name",
                  lable: "First Name *",
                  controller: _firstNameController,
                  keyboardType: TextInputType.text,
                ),
                CTextField(
                  hintText: "Enter Last Name",
                  lable: "Last Name *",
                  controller: _lastNameController,
                  keyboardType: TextInputType.text,
                ),
                CTextField(
                  hintText: "Enter Headline",
                  lable: "Headline *",
                  line: 2,
                  infoVisible: true,
                  onInfo: (value) {
                    var c = value as BuildContext;
                    showPopover(
                      context: c,
                      bodyBuilder: (context) => Container(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          Lables.headline_msg,
                          style: regularBlack14,
                        ),
                      ),
                      width: deviceWidth! - 20,
                      onPop: () => {},
                      direction: PopoverDirection.top,
                      height: 70,
                      arrowDxOffset: (deviceWidth! / 2) - 30,
                    );
                  },
                  controller: _headLineController,
                  maxLength: 120,
                  keyboardType: TextInputType.text,
                ),
                CTextField(
                  hintText: "Enter phone number",
                  lable: "Phone Number",
                  readOnly: phoneDisable,
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                ),
                CTextField(
                  hintText: "Enter pincode",
                  lable: "Pincode",
                  controller: _pincodeController,
                  textInputFormatter: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                CButton(
                  title: "Update",
                  btnAnim: buttonAnimation,
                  btnCntrl: buttonController,
                  onBtnSelected: () async {
                    _clickSave();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getData() async {
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(Constants.user);
    print(data);
    if (data != null) {
      var responseData = await json.decode(data);

setState(() {
  user = Users.fromJson(responseData);
});
      print(user!.image);
      _firstNameController.text = (user!.userable!.firstName != null) ? user!.userable!.firstName! : "";
      _lastNameController.text = (user!.userable!.lastName != null) ? user!.userable!.lastName! : "";
      _headLineController.text = (user!.userable!.headline != null) ? user!.userable!.headline! : "";
      _pincodeController.text = (user!.userable!.pincode != null) ? user!.userable!.pincode! : "";

      _phoneNumberController.text = (user!.userable!.mobileNumber != null)
          ? "+91 ${user!.userable!.mobileNumber!}"
          : "";
    }
  }
  void _clickSave() {
    String fName = _firstNameController.text.toString().trim();
    String lName = _lastNameController.text.toString().trim();
    String headline = _headLineController.text.toString().trim();
    String pincode = _pincodeController.text.toString().trim();
    if (fName.isEmpty) {
      ToastUtils.setSnackBar(context, "Please enter first name!");
      return;
    } else if (lName.isEmpty) {
      ToastUtils.setSnackBar(context, "Please enter last name!");
      return;
    } else if (headline.isEmpty) {
      ToastUtils.setSnackBar(context, "Please enter headline!");
      return;
    }
    if (pincode.isNotEmpty && pincode.length != 6) {
      ToastUtils.setSnackBar(context, "Please enter valid pincode");
      return;
    }
    if (headline.isEmpty) {
      headline = Lables.headline_common;
    }
    createProfileApi(
        fName, lName, headline, pincode, fileProfilePic, fileCover);
  }
  void createProfileApi(String fName, String lName, String headline,
      String pincode, fileProfilePic, fileCover) async {
    try {
      // Log user in
      _playAnimation();
      await Provider.of<AuthProvider>(context, listen: false)
          .createProfile(context, fName, lName, headline, pincode,
          fileProfilePic, fileCover)
          .then((value) {
        responseCreateProfile(value);
      });
    } on HttpException catch (error) {
      await buttonController!.reverse();
      print(error);
    } catch (error) {
      await buttonController!.reverse();
      print(error);
    }
  }
  void responseCreateProfile(bool value) async {
    await buttonController!.reverse();
    print(value);
    if (value) {
      navigatorKey.currentState!
          .pop();
    }
  }
  void logout() async {
    var pref = await SharedPreferences.getInstance();
    pref.clear();
    navigatorKey.currentState!.pushNamedAndRemoveUntil(
        RouteName.phoneAuthScreen, (route) => false,
        arguments: 0);
  }
}
