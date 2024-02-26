

import 'package:flutter/material.dart';
import 'package:myapp2/screens/screen3.dart';

class screen3 extends StatefulWidget {
  const screen3({super.key});

  @override
  State<screen3> createState() => _screen3State();
}

class _screen3State extends State<screen3> {

  TextEditingController _email=TextEditingController();
  TextEditingController _password=TextEditingController();
  TextEditingController _fname=TextEditingController();
  TextEditingController _laname=TextEditingController();

  final _fromkey=GlobalKey<FormState>();

   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Form(
            key: _fromkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [       
                TextFormField(
                   controller: _fname,
                   validator: (value) {
                     if(value!=null && value.isEmpty ){
                      return "Please is Enter Your Name";
                     }else{
                      return null;
                     }
                   },
                   decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),),
                      prefixIcon: Icon(Icons.person),
                   ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _laname,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if(value!=null && value.isEmpty){
                     return "Please enter your last name"; 
                    }else{
                      return null;
                    }
                  },
                ),
                ElevatedButton(onPressed: (){
                  if(_fromkey.currentState!.validate()){
                    Navigator.push(context , MaterialPageRoute(builder: (context) => Home_Page(fname: _fname.text, lname: _laname.text,),));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Succesfully logged in"),backgroundColor: Colors.green,));
                          
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter Valid information"),backgroundColor: Colors.red,));
                  }
                }, 
                child: Text("Submit")),
                
            ],),
          ),
        ),
      ),
    );
  }
}