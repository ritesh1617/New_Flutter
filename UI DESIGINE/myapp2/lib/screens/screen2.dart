
import 'package:flutter/material.dart';
import 'package:myapp2/screens/screen3.dart';

class screen4 extends StatefulWidget {
  const screen4({super.key});

  @override
  State<screen4> createState() => _screen4State();
}

class _screen4State extends State<screen4> {

TextEditingController _name=TextEditingController();

final _fromkey=GlobalKey<FormState>();


  @override  
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
           child: Padding(
             padding: const EdgeInsets.all(14),
             child: Form(
              key: _fromkey,
               child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    validator: (value) {
                      if(value!=null && value.isEmpty){
                        return "please enter your valid information";
                      }else{
                        return null;
                      }
                    },
                  ),
                  ElevatedButton(onPressed: (){
                  if(_fromkey.currentState!.validate()){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => home_screen(name: _name.text),));
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Succesfuly logged in"),backgroundColor: Colors.green,));
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please enter your information"),backgroundColor: Colors.red,));
                  }

                  }, child: Text("SUBMIT"))
                  
                ],
               ),
             ),
           ),
      ),
    );
  }
}