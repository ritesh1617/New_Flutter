
import 'package:myapp/const/export.dart';

Widget textfield({String? title,String? hinttext,String? labeltext,String? lable,controller,pass,icon,String? Function(String?)? value}){
  return Column(
    children: [

      TextFormField(
        validator: value,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: blue),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: yellow),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: red,
            )
          ),
          hintText: hinttext,
          labelText: labeltext,
        ),
      )
    ],
  );
}