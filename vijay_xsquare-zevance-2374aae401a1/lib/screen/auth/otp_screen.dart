import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grievance/common/custom/info_dialog.dart';
import 'package:grievance/common/widget/button.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/provider/AuthProvider.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../theme/color.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  final dynamic argument;

  OTPScreen(
    this.argument, {
    Key? key,
  }) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> with TickerProviderStateMixin {
  var firebaseToken = "ssss";
  String otp = "";
  late String _verificationCode;
  int? _resendToken;
  //Button Animation
  Animation? buttonAnimation;
  AnimationController? buttonController;
  final _otpController = TextEditingController();

  String? number;
  String? phone;

  Future<Null> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  //Timer
  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: 35);

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }
  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }
  // Step 6
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }
  @override
  void initState() {
    super.initState();
    number = widget.argument as String;
    phone = number!.replaceAll(" ", "");

    _verifyPhone(phone!);
    //startTimer();
    getFcmToken();
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
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              navigatorKey.currentState!.pop();
            },
            child: const Icon(
              Icons.close,
              size: 30,
            )),
        backgroundColor: colors.backgroundColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Text(
              "Verify phone number",
              style: boldBlack20,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Text(
              "Check your SMS message, We've sent you the OTP at (+91) ${number!.replaceAll(" ", "-")}",
              style: regularGray14,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
            child: PinCodeTextField(
              appContext: context,
              pastedTextStyle: boldBlack14,
              textStyle: boldBlack14,
              length: 6,
              controller: _otpController,
              obscureText: false,
              obscuringCharacter: '*',
              blinkWhenObscuring: true,
              animationType: AnimationType.fade,
              validator: (v) {
                // if (v!.length < 4) {
                //   return "I'm from validator";
                // } else {
                return null;
                //   }d6
              },
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(10),
                  fieldHeight: 45,
                  fieldWidth: 45,
                  borderWidth: 1,
                  activeColor: colors.whiteTemp,
                  activeFillColor: colors.whiteTemp,
                  selectedFillColor: colors.whiteTemp,
                  inactiveFillColor: colors.whiteTemp,
                  errorBorderColor: colors.whiteTemp,
                  disabledColor: colors.black12,
                  inactiveColor: colors.black12,
                  selectedColor: colors.black54),
              cursorColor: Colors.black,
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              keyboardType: TextInputType.number,
              onCompleted: (v) {
                debugPrint("Completed");
              },
              // onTap: () {
              //   print("Pressed");
              // },
              onChanged: (value) {
                otp = value;
                debugPrint(value);
                setState(() {});
              },
              beforeTextPaste: (text) {
                debugPrint("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            ),
          ),
          CButton(
            title: "Login",
            btnAnim: buttonAnimation,
            btnCntrl: buttonController,
            onBtnSelected: () async {
              _clickVerifyOtp();
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
            child: Text(
              "Didn’t receive any code?",
              style: regularGray14,
              textAlign: TextAlign.center,
            ),
          ),
          (seconds=="00")?GestureDetector(
            onTap: () {
              ToastUtils.setSnackBar(context, "The code has been resent");
              _verifyPhone(phone!);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
              child: Text(
                "Re-send code",
                style: boldBlack14.copyWith(color: colors.secondary),
                textAlign: TextAlign.center,
              ),
            ),
          ):
          Text("resend OTP in 00:${seconds}",style: regularGray14,),
          const Expanded(child: SizedBox()),
        ],
      ),
    );
  }

  void _clickVerifyOtp() {

    if (otp.length == 6) {
      _verifyFirebaseOTP(phone!, otp);
    } else {
      ToastUtils.setSnackBar(context, "Please enter valid otp");
    }
  }

  void responseVerifyOtp(Users? value) async {
    await buttonController!.reverse();
    if (value != null) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return InfoDialogBox(
              title: "Verification Successfully",
              descriptions:
                  "Thank you for your support, we have successfully verified your mobile number. You can now proceed to home page",
              closePress: () {
                nextMove(value);
                //
              },
            );
          });
    }
  }

  void _verifyPhone(String phone) async {
    startTimer();
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91$phone',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            await buttonController!.reverse();
            if (value.user != null) {
              _otpController.text = credential.smsCode.toString();
              _verifyOtpApi(phone);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) async {
          await buttonController!.reverse();
          if(e.message!=null) {
            ToastUtils.setSnackBar(context, e.message!);
          } else {
            ToastUtils.setSnackBar(context, "Please check mobile number!");
          }
          navigatorKey.currentState!.pop();
        },
        codeSent: (String verificationID, int? resendToken) async {
          await buttonController!.reverse();
          _resendToken = resendToken;
          setState(() {
            _verificationCode = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) async {
          await buttonController!.reverse();
          setState(() {
            _verificationCode = verificationID;
          });
        },
        forceResendingToken: _resendToken,
        timeout: const Duration(seconds: 60));
  }

  void _verifyFirebaseOTP(String phone, String otp) async {
    print(otp);
    _playAnimation();
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationCode, smsCode: otp))
          .then((value) async {
        await buttonController!.reverse();
        if (value.user != null) {
          _verifyOtpApi(phone);
        } else {
          ToastUtils.setSnackBar(context, "Invalid OTP!");
        }
      });
    } catch (e) {
      await buttonController!.reverse();
      ToastUtils.setSnackBar(context, "Invalid OTP!");
    }
  }

  void _verifyOtpApi(String phone) async{
    await FirebaseAuth.instance.signOut();
    stopTimer();
    _playAnimation();
    await Provider.of<AuthProvider>(context, listen: false)
        .loginV2(context, phone,"+91",firebaseToken)
        .then((value) {
      responseVerifyOtp(value);
    });
  }

  void nextMove(Users user) async {
    await Future.delayed(Duration(seconds: 1));
    if(user.userable !=null && user.userable!.firstName!=null && user.userable!.firstName!="") {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(RouteName.dashboardScreen, (route) => false, arguments: user);
    }else{
      navigatorKey.currentState!.pushReplacementNamed(RouteName.createProfileScreen, arguments: true);
    }
  }

  void getFcmToken() async {
    if (Platform.isAndroid) {
      firebaseToken = (await FirebaseMessaging.instance.getToken())!;
      print("androidToken is " + firebaseToken);
    } else {
      firebaseToken = (await FirebaseMessaging.instance.getToken())!;
      print("iosToken is " + firebaseToken);
    }
  }
}
