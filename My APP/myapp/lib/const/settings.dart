import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier{

  bool _isVisible = false;
  bool get isVisible => _isVisible;

  //Strong password requirement
  RegExp strongPassword = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$');

  //Validated Email format
  RegExp emailRequirement = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  //General Validator
  validator(String value, String message){
    if(value.isEmpty){
      return message;
    }else{
      return null;
    }
  }


  //Phone number validator
  phoneValidator(String value){
    if(value.isEmpty){
      return "Phone is required";
    }else if(value.length <14){
      return "Phone number is not valid";
    }else {
      return null;
    }
  }

 
  //Password validator | Strong password
  passwordValidator(String value){
    if(value.isEmpty){
      return "Password is required";
    }else if(!strongPassword.hasMatch(value)){
    return "Password is not strong enough";
    }else{
      return null;
    }
  }

  //Confirm password
  confirmPass(String value1, String value2){
    if(value1.isEmpty){
      return "Re-enter your password";
    }else if(value1 != value2){
      return "Passwords don't match";
    }else{
      return null;
    }
  }

  //Email validator
  emailValidator(String value){
    if(value.isEmpty){
      return "Email is required";
    }else if(!emailRequirement.hasMatch(value)){
      return "Email is not valid";
    }else{
      return null;
    }
  }

  //Password show & hide
  void showHidePassword(){
    _isVisible =! _isVisible;
    notifyListeners();
  }

  //SnackBar Message
  showSnackBar(String message,context){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(message))
    );
  }

}