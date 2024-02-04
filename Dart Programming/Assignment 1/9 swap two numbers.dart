import 'dart:io';

void main() {

   var num1,num2;
   print("Enter the first number:");
   num1 = double.parse(stdin.readLineSync()!);

   print("Enter the second number:");
   num2 = double.parse(stdin.readLineSync()!);

  num1 = num1 + num2;
  num2 = num1 - num2;
  num1 = num1 - num2;

  print("After swapping:");
  print("First number: $num1");
  print("Second number: $num2");
}
