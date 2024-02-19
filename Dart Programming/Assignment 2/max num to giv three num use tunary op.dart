
// 14. Write a program to find the Max number from the given three number using Ternary Operator

import 'dart:io';

void main() {

  var num1,num2,num3,maxNumber;

  stdout.write("Enter the first number: ");
  num1 = int.parse(stdin.readLineSync()!);

  stdout.write("Enter the second number: ");
  num2 = int.parse(stdin.readLineSync()!);

  stdout.write("Enter the third number: ");
  num3 = int.parse(stdin.readLineSync()!);

  maxNumber = (num1 >= num2)? (num1 >= num3 ? num1 : num3): (num2 >= num3 ? num2 : num3);

  print("The maximum number is: $maxNumber");
}
