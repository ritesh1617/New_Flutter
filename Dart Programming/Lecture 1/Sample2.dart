import 'dart:io';
void main(){
  var name,age;
  print("Enter your name here ");
  name = stdin.readLineSync()!;
  print("Enter your age here ");
  age = int.parse(stdin.readLineSync()!);
  print("This is users name $name this is her or him age $age");
}