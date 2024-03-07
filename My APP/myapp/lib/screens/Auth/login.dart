

import 'package:flutter/material.dart';
import 'package:myapp/Custom%20Widget/Textfeild.dart';
import 'package:myapp/Custom%20Widget/bgscreen.dart';
import 'package:myapp/const/export.dart';
import 'package:myapp/const/settings.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final provider = SettingsProvider();

  @override
  Widget build(BuildContext context) {
    return Back_screen(
      child: Padding(
        padding: const EdgeInsets.only(),
        child: Scaffold(
          backgroundColor: grey,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: textfield(
                      controller: _email,
                      hinttext:emailhint,
                      value: (value) =>emailValidator(valid_email),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: textfield(
                      
                      controller: _pass,
                      hinttext: passhint,
                      value: (value) => passwordValidator(valid_pass),
                        
                    ),
                  ),
                  TextButton(
                    onPressed: () {                    },
                    child: 'Forgot password'.text.make(),
                  ),
                  25.heightBox,
                  // ElevatedButton(onPressed: (){
                  //   if(_formKey.currentState!.validate()){
                  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>home_screen()));
                  //   }else{
                  //     return null;
                  //   }
                  // }, child: Text(login)),
                  Button_(
                    color: red,
                    title: login,
                    textcolor: white,
                    onpress: (){
                      if(_formKey.currentState!.validate()){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=>home_screen()));
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(login_message),backgroundColor: green,));
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(login_faild_mess),backgroundColor: red,));
                      }
                    }
                
                  )
                ],
              ),
            ),
          ),
        ).paddingOnly(top: 350).box.height(context.screenHeight / 1.1).width(context.screenWidth - 40).rounded.clip(Clip.antiAlias).makeCentered(),
      ),
      context: context,
    );
  }
}

//for emailvalidation
 emailValidator(String value){
    if(value.isEmpty){
      return "Email is required";
    }else if(!emailRequirement.hasMatch(value)){
      return "Email is not valid";
    }else{
      return null;
    }
  }  RegExp emailRequirement = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

//for password validation
passwordValidator(String value){
    if(value.isEmpty){
      return "Password is required";
    }else if(!strongPassword.hasMatch(value)){
    return "Password is not strong enough";
    }else{
      return null;
    }
  }  RegExp strongPassword = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');
