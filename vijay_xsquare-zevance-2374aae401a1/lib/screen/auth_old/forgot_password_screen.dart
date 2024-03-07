import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/provider/AuthProvider.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';

import '../../common/widget/button.dart';
import '../../common/widget/textfield.dart';
import '../../common/widget/textfield_pass.dart';
import '../../theme/color.dart';
import '../../theme/string.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with TickerProviderStateMixin {
  //Tabbar Controller
  late TabController _tabController;

  //Login Form Controller
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _mobileOrEmailController =
      TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  late String _verificationCode;
  bool isPassword = false;

  //Button Animation
  Animation? buttonAnimation;
  AnimationController? buttonController;

  Future<Null> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  @override
  void initState() {
    super.initState();

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
    _tabController.dispose();
    buttonController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          width: deviceWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              const Image(
                image: AssetImage(Images.ic_forgot_password),
                width: 230,
                height: 260,
              ),
              const SizedBox(
                height: 50,
              ),
              getLoginForm()
            ],
          ),
        ),
      ),
    );
  }

  Widget getLoginForm() {
    return Column(
      children: [
        Text(
          "Forgot Password",
          style: boldBlack24,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "We have sent  the code verification to\n" +
              "your Email or Mobile Number",
          style: regularGray14,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 30,
        ),
        CTextField(
          hintText: "Email / Phone Number",
          lable: "Email / Phone Number",
          controller: _mobileOrEmailController,
        ),
        (isPassword)
            ? CTextFieldPass(
                lable: "Enter Your OTP here",
                controller: _otpController,
              )
            : Container(),
        const SizedBox(
          height: 10,
        ),
        CButton(
          title: (isPassword)?"Verify OTP":"Get OTP",
          btnAnim: buttonAnimation,
          btnCntrl: buttonController,
          onBtnSelected: () async {
            (isPassword) ? _clickVerifyOtp() : _clickForgotPassword();
          },
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  void _clickForgotPassword() {
    var email = _mobileOrEmailController.text.toString();
    if (!forgotPasswordValidation(email)) {
      return;
    }
    var type = "";
    if (isEmail(email)) {
      type = "email";
    } else if (isPhone(email)) {
      type = "mobile";
    }

    _forgotPasswordApi(context, email, type);
  }

  void _clickVerifyOtp() {
    var email = _mobileOrEmailController.text.toString();
    var otp = _otpController.text.toString();

    var type = "";
    if (isEmail(email)) {
      type = "email";
    } else if (isPhone(email)) {
      type = "mobile";
    }
    if (type == "email") {
      _verifyOtpApi(email, type, otp);
    } else if (type == "mobile") {
      _verifyFirebaseOTP(email, otp);
    }
  }

  bool forgotPasswordValidation(String email) {
    if (email == "") {
      ToastUtils.setSnackBar(context, "Please enter email id or mobile number");
      return false;
    } else if (!isEmail(email) && !isPhone(email)) {
      ToastUtils.setSnackBar(
          context, "Please enter valid email id or mobile number");
      return false;
    }
    return true;
  }

  void _forgotPasswordApi(
      BuildContext context, String email, String type) async {
    try {
      // Log user in
      _playAnimation();
      await Provider.of<AuthProvider>(context, listen: false)
          .forgotPassword(context, email, type)
          .then((value) {
        responseforgotPassword(value, email, type);
      });
    } on HttpException catch (error) {
      await buttonController!.reverse();
      print(error);
    } catch (error) {
      await buttonController!.reverse();
      print(error);
    }
  }

  void _verifyOtpApi(String email, String type, String otp) async {
    try {
      // Log user in
      _playAnimation();
      await Provider.of<AuthProvider>(context, listen: false)
          .verifyOtp(context, email, type, otp)
          .then((value) {
        responseVerifyOtp(value);
      });
    } on HttpException catch (error) {
      await buttonController!.reverse();
      print(error);
    } catch (error) {
      await buttonController!.reverse();
      print(error);
    }
  }

  void responseforgotPassword(bool value, String email, String type) async {
    await buttonController!.reverse();
    //navigatorKey.currentState!.pushNamed(RouteName.createProfileScreen);

    if (value) {
      if (type == "email") {
        setState(() {
          isPassword = true;
        });
      } else if (type == "mobile") {
        _verifyPhone(email);
      }
    }
  }

  void responseVerifyOtp(Users? value) async {
    await buttonController!.reverse();
    if (value != null) {
      navigatorKey.currentState!.pushNamed(RouteName.changePasswordScreen);
    }
  }

  void _verifyPhone(String phone) async {
    _playAnimation();
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            await buttonController!.reverse();
            if (value.user != null) {
              _verifyOtpApi(phone, "mobile", "");
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) async {
          await buttonController!.reverse();
          ToastUtils.setSnackBar(context, "Please check mobile number!");
        },
        codeSent: (String verificationID, int? resendToken) async {
          await buttonController!.reverse();
          setState(() {
            isPassword = true;
          });
          setState(() {
            _verificationCode = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) async {
          await buttonController!.reverse();
          setState(() {
            isPassword = true;
          });
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: const Duration(seconds: 120));
  }

  void _verifyFirebaseOTP(String phone, String otp) async {
    _playAnimation();
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationCode, smsCode: otp))
          .then((value) async {
        await buttonController!.reverse();
        if (value.user != null) {
          _verifyOtpApi(phone, "mobile", "");
        } else {
          ToastUtils.setSnackBar(context, "Invalid OTP!");
        }
      });
    } catch (e) {
      await buttonController!.reverse();
      ToastUtils.setSnackBar(context, "Invalid OTP!");
    }
  }
}
