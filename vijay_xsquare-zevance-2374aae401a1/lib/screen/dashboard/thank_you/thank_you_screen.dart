
import 'package:flutter/material.dart';
import 'package:grievance/common/widget/button.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';

class ThankyouScreen extends StatefulWidget {
  final dynamic _argument;
  const ThankyouScreen(this._argument,{Key? key}) : super(key: key);

  @override
  _ThankyouScreenState createState() => _ThankyouScreenState();
}

class _ThankyouScreenState extends State<ThankyouScreen> with TickerProviderStateMixin{

  //Create Profile Controller

  //Button Animation
  Animation? buttonAnimation;
  AnimationController? buttonController;

  Future<Null> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }

  Grievance? model;

  @override
  void initState() {
    super.initState();
    model=widget._argument as Grievance;
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
      onWillPop: () async{
        navigatorKey.currentState!.pushNamedAndRemoveUntil(RouteName.dashboardScreen, (route) => false);
        return false;
      },
      child: Scaffold(
        backgroundColor: colors.whiteTemp,
        appBar: AppBar(
          backgroundColor: colors.whiteTemp,
          leading: Container(),
          // leading: GestureDetector(onTap: (){
          //   navigatorKey.currentState!.pop();
          // },
          //     child: Container(child: const Image(image: AssetImage(Images.ic_back)),width: 20,padding: const EdgeInsets.all(15.0),)),
          title: Text("Thank You",style: boldBlack20,),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Image.asset(Images.ic_thank_you),
            const SizedBox(height: 20,),
            Text("Grievance Submitted",style: boldBlack24,),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Text("Your ticket number is\n${model!.ticketNo}",style: regularBlack16,textAlign: TextAlign.center,),
            ),
            const Expanded(child: SizedBox()),
            CButton(
              title: "Back To Home",
              btnAnim: buttonAnimation,
              btnCntrl: buttonController,
              onBtnSelected: () async {
                navigatorKey.currentState!.pushNamedAndRemoveUntil(RouteName.dashboardScreen, (route) => false);
              },
            ),
            // CButton(
            //   title: "Share",
            //   btnAnim: buttonAnimation,
            //   btnCntrl: buttonController,
            //   onBtnSelected: () async {
            //     navigatorKey.currentState!.pushNamed(RouteName.shareScreen,arguments: model);
            //   },
            // ),
            // CButton(
            //   title: "Submit Another Grievance",
            //   btnAnim: buttonAnimation,
            //   btnCntrl: buttonController,
            //   onBtnSelected: () async {
            //     navigatorKey.currentState!.pop(201);
            //   },
            // ),
            const SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }
}
