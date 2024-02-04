//ar
// + -  *  / %

import 'dart:io';

void main(){
  var num1,num2,ans;

  stdout.write("Enter your first number : ");
  num1 = int.parse(stdin.readLineSync()!);
  stdout.write("Enter your second numbre : ");
  num2 = int.parse(stdin.readLineSync()!);
  ans=num1+num2;
  print("This is your answer : $ans");
}