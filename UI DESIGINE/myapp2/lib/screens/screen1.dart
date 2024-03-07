
import 'package:flutter/material.dart';

class loginscreen extends StatefulWidget {
  const loginscreen({super.key});

  @override
  State<loginscreen> createState() => _loginscreenState();
}

class _loginscreenState extends State<loginscreen> {

TextEditingController _username=TextEditingController();
TextEditingController _password=TextEditingController();

final _fromkey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/login.png"),fit: BoxFit.cover),
          
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 160,right: 130),
                child: Text("Welcome\nBack",style: TextStyle(color: Colors.white,fontSize: 30),),
              ),
              SizedBox(height: 110,),
              Container(
                margin: EdgeInsets.all(20),
                height: 400,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color : Color(0xFF4c505b),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _fromkey,
                    child: Column(
                      children: [
                        SizedBox(height: 60,),
                      TextFormField(
                         style: TextStyle(color: Colors.white),
                           decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(color: Colors.white),
                           ),
                            focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            ),
                           ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        validator: (value) {
                          if(value!=null && value.isEmpty){
                            return "Please enter valid information";
                          }else{
                            return null;
                          }
                        },
                          style: TextStyle(color: Colors.white),
                           decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            enabledBorder: OutlineInputBorder(
                           borderSide: BorderSide(color: Colors.white),
                           ),
                            focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                            ),
                           ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        margin: EdgeInsets.all(10),
                        height: 40,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        ),
                        child: TextButton(onPressed: (){
                          if(_fromkey.currentState!.validate()){
                            
                          }
                        }, child: Text("Login",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
                      ),
                      SizedBox(height: 20,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: (){}, child: Text("Forget password?",style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline,decorationColor: Colors.blue),)),
                        TextButton(onPressed: (){}, child: Text("Sign Up",style: TextStyle(color: Colors.blue,decoration: TextDecoration.underline,decorationColor: Colors.blue),))
                    
                      ],
                     )
                    ],),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}