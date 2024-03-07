
import 'package:flutter/material.dart';
import 'package:grievance/common/widget/PostChatWidget.dart';
import 'package:grievance/common/widget/button.dart';
import 'package:grievance/model/Grievance.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ShareScreen extends StatefulWidget {
  final dynamic _argument;
   const ShareScreen(this._argument,{Key? key}) : super(key: key);

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> with TickerProviderStateMixin {
  Grievance? grievance;

  //Button Animation
  Animation? buttonAnimation;
  AnimationController? buttonController;
  final GlobalKey _globalKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    grievance=widget._argument as Grievance;
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      appBar: AppBar(
        backgroundColor: colors.backgroundColor,
        leading: GestureDetector(
            onTap: () {
              navigatorKey.currentState!.pop();
            },
            child: Container(padding: const EdgeInsets.all(15),child: const Image(image: AssetImage(Images.ic_back)),)),
        title: Text(
          "Share",
          style: boldBlack18,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          RepaintBoundary(
              key: _globalKey,
              child: PostChatWidget(model: grievance,hideBottom: true,)),
          const SizedBox(height: 30,),
          CButton(
            title: "Share",
            btnAnim: buttonAnimation,
            btnCntrl: buttonController,
            onBtnSelected: () async {
              Utils.shareTile(_globalKey,context);
            },
          ),
          const SizedBox(height: 30,),
        ],),
      ),
    );
  }
}
