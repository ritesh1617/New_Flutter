
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:myapp2/screens/screen3.dart';

// class screen1 extends StatefulWidget {
//   const screen1({super.key});

//   @override
//   State<screen1> createState() => _screen1State();
// }

// class _screen1State extends State<screen1> {

//   TextEditingController _name = TextEditingController();
//   TextEditingController _password=TextEditingController();
 
//     final _fromkey = GlobalKey<FormState>();

    


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           color: Colors.black,
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     margin: EdgeInsets.only(top: 100),
//                     height: 100,
//                     width: 100,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10,),bottomRight: Radius.circular(10))
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                       Container(
//                         height: 40,
//                         width: 40,
//                         decoration: BoxDecoration(
//                           color: Colors.black,
//                           borderRadius: BorderRadius.only(topLeft: Radius.circular(360),topRight: Radius.circular(360),bottomRight:Radius.circular(360) ),
//                         ),
//                       )
//                     ]),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 50,),
//               Container(
//                 height: 500,
//                 width: double.maxFinite,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),     
//                 ),
//                 child: Form(
//                   key: _fromkey,
//                   child: Column(
//                     children: [
//                       SizedBox(height: 40,),
//                       Text("Login",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 20),
//                         child: TextFormField(
//                           controller: _name,
//                            validator: (value) {
//                           if (value != null && value.isEmpty) {
//                           return 'Please enter your valid email';
//                          }else{
//                         return null;
//                        }
//                       },
//                           keyboardType: TextInputType.emailAddress,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12)
//                           ),
//                             hintText: "Email",
//                             labelText: "Email",
//                             suffixIcon: Icon(Icons.email),
//                           ),

//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 20),
//                         child: TextFormField(
//                           controller: _password,
//                           validator: (value) {
//                           if (value != null && value.isEmpty) {
//                           return 'Please enter your valid password';
//                          }else{
//                         return null;
//                        }
//                       },
//                           obscureText: true,
//                           decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12)
//                           ),
//                             hintText: "Password",
//                             labelText: "Password",
//                             suffixIcon: Icon(Icons.lock)
//                           ),
//                         ),
//                       ),
//                        ElevatedButton(onPressed: (){
//                 if (_fromkey.currentState!.validate()) {
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_Page())); 
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(" Successfully Logged in "),backgroundColor: Colors.green,)); 
//                 }else{
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Password "),backgroundColor: Colors.red,));
//                 }
//               }, child: Text("Submit"))
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }