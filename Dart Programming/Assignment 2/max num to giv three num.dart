
/*
13. Write a program to find the Max number from the given three
number using Nested If
*/ 

import 'dart:io';

void main() {

  var num1,num2,num3;

  stdout.write("Enter the first number: ");
  num1 = int.parse(stdin.readLineSync()!);

  stdout.write("Enter the second number: ");
  num2 = int.parse(stdin.readLineSync()!);

  stdout.write("Enter the third number: ");
  num3 = int.parse(stdin.readLineSync()!);

  if (num1 >= num2) {
    if (num1 >= num3) {
      print("The maximum number is: $num1");
    } else {
      print("The maximum number is: $num3");
    }
  } else {
    if (num2 >= num3) {
      print("The maximum number is: $num2");
    } else {
      print("The maximum number is: $num3");
    }
  }
}
