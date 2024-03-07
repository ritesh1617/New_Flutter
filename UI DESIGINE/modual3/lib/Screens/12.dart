import 'package:flutter/material.dart';
import 'package:modual3/Screens/screen2.dart';

class login_page extends StatefulWidget {
  const login_page({super.key});

  @override
  State<login_page> createState() => _login_pageState();
}

class _login_pageState extends State<login_page> {

  RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

        RegExp regExp_email=RegExp( r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

TextEditingController _email=TextEditingController();
TextEditingController _pass=TextEditingController();

final _fromkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _fromkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Center(
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey,width: 3.0),
                          shape: BoxShape.circle
                        ),
                        child: Icon(Icons.person,color: Colors.grey,size: 50,),
                      ),
                    ),
                  ),
                   SizedBox(height: 10,),
                  Text("WELCOME BACK",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text("Sign in to continue",style: TextStyle(color: Colors.grey,fontSize: 16),),
                  SizedBox(height: 50,),
                  Container(
                    margin: EdgeInsets.all(16),
                    height: 50,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          color: Colors.grey,
                        ),
                      ]
                    ),
                    child: TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      style:TextStyle(color: Colors.greenAccent.shade400) ,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade100)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade100)
                          ),
                          hintText: "EMAIL",
                          hintStyle: TextStyle(color: Colors.grey),
                          labelText: "EMAIL",
                          labelStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.email,color: Colors.greenAccent.shade400,)
                        ),
                        validator: (value) {
                          if(value!is Null && value!.isEmpty){
                            return"Please Enter Your Valid Email";
                          }else if(regExp_email.hasMatch(value!)){
                            return null;
                          }else{
                            return null;
                          }
                        },
                    ),
                  ),
                   Container(
                    margin: EdgeInsets.all(16),
                    height: 50,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          color: Colors.grey,
                        ),
                      ]
                    ),
                    child: TextFormField(
                      controller: _pass,
                      keyboardType: TextInputType.number,
                      obscureText: true,
                      obscuringCharacter: "*",
                      style:TextStyle(color: Colors.greenAccent.shade400) ,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade100)
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade100)
                          ),
                          hintText: "PASSWORD",
                          hintStyle: TextStyle(color: Colors.grey),
                          labelText: "PASSWORD",
                          labelStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(Icons.lock,color: Colors.greenAccent.shade400,)
                        ),
                        validator: (value) {
                          if(value!is Null && value!.isEmpty){
                            return"Please Enter Your Valid Email";
                          }else if(regex.hasMatch(value!)){
                            return null;
                          }else{
                            return null;
                          }
                        },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Forgot Password?",style: TextStyle(color: Colors.greenAccent.shade400,fontSize: 14),),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: (){
                      if(_fromkey.currentState!.validate()){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Sucessfully"),backgroundColor: Colors.green,));
                        Navigator.push(context, MaterialPageRoute(builder: (context) => screen2(),));
        
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invlid Information"),backgroundColor: Colors.red,));
                      }
                    },
                    child: Container(
                      height: 50,
                      width: double.maxFinite,
                      margin: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.greenAccent.shade400,
                      ),
                      child: Center(child: Text("LOGIN",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have account?",style: TextStyle(fontSize: 12),),
                      SizedBox(width: 2,),
                      Text("create a new account",style: TextStyle(fontSize: 12,color: Colors.greenAccent.shade400),),
                    ],
                  ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}