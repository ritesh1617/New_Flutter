
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class cont extends StatefulWidget {
  const cont({Key? key}) : super(key: key);

  @override
  State<cont> createState() => _contState();
}

class _contState extends State<cont> {
  @override

  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 146, 7, 170),
      body:Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset("assets/Animation - 1710401108592.json"),
              Text("SET MOOD WITH \n    GOOD MUSIC",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white)),
               SizedBox(height: 10,),
               Lottie.asset("assets/Animation - 1710402271057.json"),
            ],
                
          ),
        ),

      )
    );
  }
}