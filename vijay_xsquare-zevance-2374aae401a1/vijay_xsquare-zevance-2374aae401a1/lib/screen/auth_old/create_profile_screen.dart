
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grievance/common/widget/AsyncTextFormField.dart';
import 'package:grievance/common/widget/textfield_pass.dart';
import 'package:grievance/model/UserModel.dart';
import 'package:grievance/provider/AuthProvider.dart';
import 'package:grievance/provider/GrievanceProvider.dart';
import 'package:grievance/theme/color.dart';
import 'package:grievance/theme/string.dart';
import 'package:grievance/theme/style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../../common/widget/button.dart';
import '../../common/widget/textfield.dart';
import '../../utils/constants.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> with TickerProviderStateMixin{

  //Create Profile Controller
  final TextEditingController _firstNameController=TextEditingController();
  final TextEditingController _lastNameController=TextEditingController();
  final TextEditingController _phoneNumberController=TextEditingController();
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final TextEditingController _confirmPasswordController=TextEditingController();
  final TextEditingController _usernameController=TextEditingController();

  bool isUsername=false;
  //Button Animation
  Animation? buttonAnimation;
  AnimationController? buttonController;

  UserModel? user;
  bool phoneDisable=false;
  bool emailDisable=false;

  Future<bool> isValidUsername(String username) async {
    isUsername=await Provider.of<GrievanceProvider>(context, listen: false)
        .usernameVerifyApi(context,username);
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
    return Scaffold(
      backgroundColor: colors.backgroundColor,
      appBar: AppBar(
        backgroundColor: colors.backgroundColor,
        leading: GestureDetector(onTap: (){
          navigatorKey.currentState!.pop();
        }, child: Container(child: const Image(image: AssetImage(Images.ic_back)),padding: EdgeInsets.all(15),)),
        title: Text("Create Profile",style: regularBlack18,),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CTextField(
              hintText: "Jack",
              lable: "First Name",
              controller: _firstNameController,
              keyboardType: TextInputType.text,
            ),
            CTextField(
              hintText: "denny",
              lable: "Last Name",
              controller: _lastNameController,
              keyboardType: TextInputType.text,
            ),
            AsyncTextFormField(
              controller: _usernameController,
              validationDebounce: const Duration(milliseconds: 500),
              validator: isValidUsername,
              hintText: "Enter Username",
              lable: "Username",
            ),
            CTextField(
              hintText: "91 8855995563",
              lable: "Phone Number",
              readOnly: phoneDisable,
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
            ),
            CTextField(
              hintText: "abc@gmail.com",
              lable: "Email Address",
              readOnly: emailDisable,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            CTextFieldPass(
              hintText: "******",
              lable: "Password",
              controller: _passwordController,
              keyboardType: TextInputType.text,
            ),
            CTextFieldPass(
              hintText: "*******",
              lable: "Confirm Password",
              controller: _confirmPasswordController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 10,
            ),
            CButton(
              title: "Create Profile",
              btnAnim: buttonAnimation,
              btnCntrl: buttonController,
              onBtnSelected: () async {
                _clickSave();
              },
            ),
          ],
        ),
      ),
    );
  }
  void getData() async{
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getString(Constants.user);
    print(data);
    if(data!=null) {
      var responseData = await json.decode(data);
      user=UserModel.fromJson(responseData);
      _firstNameController.text=(user!.firstName!=null)?user!.firstName!:"";
      _lastNameController.text=(user!.lastName!=null)?user!.lastName!:"";
      _emailController.text=(user!.email!=null)?user!.email!:"";
      _phoneNumberController.text=(user!.mobileNo!=null)?user!.mobileNo!:"";

      if(user!.email!=null&&user!.email!=""){
        setState(() {
          emailDisable=true;
        });
      }
      if(user!.mobileNo!=null&&user!.mobileNo!=""){
        setState(() {
          phoneDisable=true;
        });
      }
    }
  }
  void _clickSave(){
    String fName=_firstNameController.text.toString();
    String lName=_lastNameController.text.toString();
    String username = _usernameController.text.toString();
    String email=_emailController.text.toString();
    String mobile=_phoneNumberController.text.toString();
    String password=_passwordController.text.toString();
    String cPassword=_confirmPasswordController.text.toString();

    if(fName.isEmpty){
      ToastUtils.setSnackBar(context, "Please enter first name!");
      return;
    }
    else if(lName.isEmpty){
      ToastUtils.setSnackBar(context, "Please enter last name!");
      return;
    }
    else if (username.isEmpty) {
      ToastUtils.setSnackBar(context, "Please enter username!");
      return;
    }
    else if (!isUsername) {
      ToastUtils.setSnackBar(context, "Please enter valid username!");
      return;
    }
    else if(mobile.isNotEmpty && !isPhone(mobile)){
      ToastUtils.setSnackBar(context, "Please enter valid mobile number!");
      return;
    }
    else if(email.isNotEmpty && !isEmail(email)){
      ToastUtils.setSnackBar(context, "Please enter valid email!");
      return;
    }

    else if(password.isEmpty){
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
    createProfileApi(fName,lName,username,email,mobile,password);
  }

  void createProfileApi(String fName, String lName,  String username, String email, String mobile, String password) async{
    try {
      // Log user in
      _playAnimation();
      // await Provider.of<AuthProvider>(context, listen: false)
      //     .createProfile(context, fName,lName,username,email,mobile,password)
      //     .then((value) {
      //   responseCreateProfile(value);
      // });
    } on HttpException catch (error) {
      await buttonController!.reverse();
    print(error);
    } catch (error) {
    await buttonController!.reverse();
    print(error);
    }
  }

  void responseCreateProfile(bool value) async{
    await buttonController!.reverse();
    if(value){
      navigatorKey.currentState!.pushNamed(RouteName.areaInterestScreen);
    }
  }
}
