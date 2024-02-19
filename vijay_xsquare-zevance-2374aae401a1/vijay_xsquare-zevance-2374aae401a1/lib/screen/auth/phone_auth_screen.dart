import 'package:flutter/material.dart';
import 'package:grievance/common/custom/maskedtextcontroller.dart';
import 'package:grievance/common/widget/button.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import '../../common/widget/textfield.dart';
import '../../theme/color.dart';
import '../../theme/string.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen>
    with TickerProviderStateMixin {

  final MaskedTextController _numberController =
  MaskedTextController(mask: '000 000 0000');

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      body:  SingleChildScrollView(
        child: SizedBox(
          height: deviceHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  flex: 2,
                  child: Container()),
              SizedBox(
                width: deviceWidth!/1.7,
                child: Image.asset(
                  Images.splash_icon,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Text(
                  "Please confirm your country code and enter your phone number",
                  style: regularGray14,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Country",
                    style: regularBlack14,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: colors.grayLight, width: 1)),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  style: regularBlack14,
                  focusNode: FocusNode(),
                  enabled: false,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                      prefixIcon: Container(
                        alignment: Alignment.center,
                        width: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Image.asset(
                                Images.india_flag,
                              ),
                            ),
                            Container(
                              width: 1,
                              height: 30,
                              color: Colors.black12,
                              margin: const EdgeInsets.only(right: 10),
                            )
                          ],
                        ),
                      ),
                      hintStyle: regularBlack14,
                      hintText: "India",
                      fillColor: Colors.white),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Phone Number",
                    style: regularBlack14,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: colors.grayLight, width: 1)),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  style: regularBlack14,
                  controller: _numberController,
                  keyboardType: TextInputType.number,
                  enableInteractiveSelection: false,
                  decoration: InputDecoration(
                      prefixIcon: Container(
                        alignment: Alignment.center,
                        width: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Center(
                                  child: Text(
                                    "+91",
                                    style: regularBlack14,
                                  )),
                            ),
                            Container(
                              width: 1,
                              height: 30,
                              color: Colors.black12,
                              margin: const EdgeInsets.only(right: 10),
                            )
                          ],
                        ),
                      ),
                      hintStyle: regularGray14,
                      hintText: "123 123 1234",
                      fillColor: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Text(
                  "When you update your phone number, a 6 digit OTP will be sent via SMS to verify it.",
                  style: regularGray14,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CButton(
                title: "Send OTP",
                btnAnim: buttonAnimation,
                btnCntrl: buttonController,
                onBtnSelected: () async {
                  _clickSendOTP();
                },
              ),
              Expanded(flex: 1,child: Container(),),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Text(
                  "By signing up or Logging in, you agree to our",
                  style: regularGray14,
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Utils.launchInBrowser(Constants.privacy_url);
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                  child: Text(
                    "Privacy Policy.",
                    style: regularGray14.copyWith(color: colors.secondary),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _clickSendOTP() {
    var number=_numberController.text.toString().trim();
    if(number.isEmpty){
      ToastUtils.setSnackBar(context, "Please enter mobile number!");
    }else if(number.length!=12){
      ToastUtils.setSnackBar(context, "Please enter valid mobile number!");
    }else{
      navigatorKey.currentState!.pushNamed(RouteName.otpScreen,arguments: number);
    }
  }
}
