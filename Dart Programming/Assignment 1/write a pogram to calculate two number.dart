import 'dart:io';

void main(){
  var num1,num2,Add,sub,multi,div;

  stdout.write("Enter your first number : ");
  num1 = int.parse(stdin.readLineSync()!);
  stdout.write("Enter your second numbre : ");
  num2 = int.parse(stdin.readLineSync()!);

  Add=num1+num2;
  sub=num1-num2;
  multi=num1*num2;
  div=num1/num2;

  print("This is your Add : $Add \nThis is your sub : $sub \nThis is Your Multi : $multi \nThis is Your Division $div");
}