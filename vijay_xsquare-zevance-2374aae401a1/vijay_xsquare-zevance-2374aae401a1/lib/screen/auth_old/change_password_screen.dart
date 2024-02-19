import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grievance/provider/AuthProvider.dart';
import 'package:grievance/theme/style.dart';
import 'package:grievance/utils/constants.dart';

import '../../common/widget/button.dart';
import '../../common/widget/textfield_pass.dart';
import '../../theme/color.dart';
import '../../theme/string.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with TickerProviderStateMixin {
  //Tabbar Controller
  late TabController _tabController;

  //Login Form Controller
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();

  //Button Animation
  Animation? buttonAnimation;
  AnimationController? buttonController;

  Future<void> _playAnimation() async {
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
        child: SizedBox(
          width: deviceWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              const FittedBox(
                child: Image(
                  image: AssetImage(Images.ic_change_password),
                ),
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
        Text("Reset Password",style: boldBlack24,),
        const SizedBox(height: 30,),
        CTextFieldPass(
          hintText: "********",
          lable: "New Password",
          controller: _passwordController,
        ),
        CTextFieldPass(
          hintText: "*******",
          lable: "Confirm Password",
          controller: _cpasswordController,
        ),
        const SizedBox(
          height: 10,
        ),
        CButton(
          title: "Reset",
          btnAnim: buttonAnimation,
          btnCntrl: buttonController,
          onBtnSelected: () async {
            _clickSave();
          },
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }

  void _clickSave(){
    String password=_passwordController.text.toString();
    String cPassword=_cpasswordController.text.toString();
 if(password.isEmpty){
      ToastUtils.setSnackBar(context, "Please enter password!");
      return;
    }
    else if(cPassword.isEmpty){
      ToastUtils.setSnackBar(context, "Please enter confirm password!");
      return;
    }
    else if(password!=cPassword){
      ToastUtils.setSnackBar(context, "Password not match!");
      return;
    }
    changePasswordApi(password);
  }

  void changePasswordApi(String password) async{
    try {
      // Log user in
      _playAnimation();
      await Provider.of<AuthProvider>(context, listen: false)
          .resetPassword(context,password)
          .then((value) {
        responseChangePassword(value);
      });
    } on HttpException catch (error) {
      await buttonController!.reverse();
      print(error);
    } catch (error) {
      await buttonController!.reverse();
      print(error);
    }
  }

  void responseChangePassword(bool value) async{
    await buttonController!.reverse();
    if(value){
      navigatorKey.currentState!.pushNamedAndRemoveUntil(RouteName.loginScreen, (route) => false);
    }
  }
}
