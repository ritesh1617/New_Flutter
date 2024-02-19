import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grievance/common/widget/button.dart';
import 'package:grievance/common/widget/textfield.dart';
import 'package:grievance/provider/GrievanceProvider.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class FeedBackScreen extends StatefulWidget {
  final dynamic argument;

  const FeedBackScreen(this.argument, {Key? key}) : super(key: key);

  @override
  _FeedBackScreenState createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen>
    with TickerProviderStateMixin {
  //Create Profile Controller

  //Button Animation
  Animation? buttonAnimation;
  AnimationController? buttonController;
  String grievance_id = "";
  double ratting = 3.0;

  final TextEditingController _feedbackController=TextEditingController();

  Future<void> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    deviceWidth = 500;
    grievance_id = widget.argument as String;
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
    return Scaffold(
      backgroundColor: colors.whiteTemp,
      appBar: AppBar(
        backgroundColor: colors.whiteTemp,
        leading: GestureDetector(
            onTap: () {

            },
            child: Container()),
        title: Text(
          "Rating And Review",
          style: regularBlack18,
        ),
        centerTitle: true,
      ),
      body:WillPopScope(
        onWillPop: () async{
          navigatorKey.currentState!.pushNamedAndRemoveUntil(
              RouteName.dashboardScreen, (route) => false);
          return false;
        },
        child: Column(
          children: [
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 250,
                    child: Image.asset(Images.ic_forgot_password)),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Your Grievance is",
                  style: regularGray18.copyWith(color: colors.grayTemp,fontSize: 24),
                ),
                Text(
                  "Closed Now",
                  style: boldBlack20.copyWith(color: colors.blackTemp),
                ),
              ],
            )),
            // const SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   margin: const EdgeInsets.only(left: 20, right: 20),
            //   height: 1,
            //   color: colors.grayLight,
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // Text(
            //   "Submit Feedback Here",
            //   style: semiBoldGrayBlue16.copyWith(color: colors.black54),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // RatingBar.builder(
            //   initialRating: 3,
            //   minRating: 1,
            //   direction: Axis.horizontal,
            //   allowHalfRating: true,
            //   itemCount: 5,
            //   itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
            //   itemBuilder: (context, _) => const Icon(
            //     Icons.star,
            //     color: Colors.amber,
            //   ),
            //   onRatingUpdate: (rating) {
            //     ratting = rating;
            //   },
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // CTextField(
            //   hintText: "Type your Feedback here",
            //   lable: "",
            //   controller: _feedbackController,
            //   line: 5,
            //   keyboardType: TextInputType.text,
            // ),

            // CButton(
            //   title: "Submit",
            //   btnAnim: buttonAnimation,
            //   btnCntrl: buttonController,
            //   onBtnSelected: () {
            //     _clickSave();
            //   },
            // ),
            CButton(
              title: "BACK TO HOME",
              btnAnim: buttonAnimation,
              btnCntrl: buttonController,
              onBtnSelected: ()  {
                navigatorKey.currentState!.pushNamedAndRemoveUntil(
                    RouteName.dashboardScreen, (route) => false);
              },
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }


  void _clickSave() {
    String feedback = _feedbackController.text.toString();


    if (feedback.isEmpty) {
      ToastUtils.setSnackBar(context, "Please write feedback!");
      return;
    }
    feedBackApi(feedback);
  }

  void feedBackApi(String feedback) async {
    try {
      // Log user in
      _playAnimation();
      await Provider.of<GrievanceProvider>(context, listen: false)
          .feedbackApi(context,grievance_id,feedback,ratting.toString())
          .then((value) {
        responseFeedBack(value);
      });
    } on HttpException catch (error) {
      await buttonController!.reverse();
      print(error);
    } catch (error) {
      await buttonController!.reverse();
      print(error);
    }
  }

  void responseFeedBack(bool value) async {
    await buttonController!.reverse();
    print("response code :" + value.toString());
    if (value) {
      ToastUtils.setSnackBar(context, "Feedback Sent Successfully!");
      navigatorKey.currentState!.pushNamedAndRemoveUntil(RouteName.dashboardScreen, (route) => false);
    }
  }
}
