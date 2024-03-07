import 'package:myapp/Const/export.dart';

Widget Button_ ({String? title,onpress,Color? color,Color? textcolor,double? textsize}){
  return ElevatedButton(onPressed:onpress, child: title?.text.color(textcolor).size(textsize).make(),style: ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(color),
  ),);
}