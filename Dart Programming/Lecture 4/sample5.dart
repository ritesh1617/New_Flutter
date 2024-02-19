import 'dart:io';

void main(){
  var name = fun();
  print("Hello user $name");
}
String fun(){
  var name;
  print("User will enetr there name here : ");
  name = stdin.readLineSync()!;
  return name;
}