// import 'package:flutter/material.dart';
// import 'package:myapp2/screens/screen3.dart';

// class Text_Fields_file extends StatefulWidget {
//   const Text_Fields_file({super.key});

//   @override
//   State<Text_Fields_file> createState() => _Text_Fields_fileState();
// }

// class _Text_Fields_fileState extends State<Text_Fields_file> {
//   TextEditingController _name =TextEditingController();
//   final _fromkey = GlobalKey<FormState>();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     dispose();
//   }
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: Container(
//         child: Form(
//           key: _fromkey,
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 50),
//                 child: TextFormField(
//                   controller: _name,
//                   validator: (value) {
//                     if (value != null && value.isEmpty) {
//                       return 'Please enter your name pro';
//                     }else{
//                       return null;
//                     }
//                   },
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12)
//                       ),
//                       hintText: "Name",
//                       labelText: "Name",
//                     suffixIcon: Icon(Icons.email) 
//                     ),
//                     // maxLength: 8,
//                     // obscureText: true,
                    
//                 ),
//               ),
//               ElevatedButton(onPressed: (){
//                 if (_fromkey.currentState!.validate()) {
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_Page(name: _name.text,))); 
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(" Successfully Logged in "),backgroundColor: Colors.green,)); 
//                 }else{
//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Password "),backgroundColor: Colors.red,));
//                 }
//               }, child: Text("Submit"))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }