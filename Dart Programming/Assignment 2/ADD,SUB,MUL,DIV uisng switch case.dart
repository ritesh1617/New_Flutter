
/* 
18. Write a Program of Addition, Subtraction ,Multiplication and
Division using Switch case.(Must Be Menu Driven)
*/


import 'dart:io';

void main() {

  var num1, num2,choice;

  stdout.write("Enter first number: ");
  num1 = double.parse(stdin.readLineSync()!);

  stdout.write("Enter second number: ");
  num2 = double.parse(stdin.readLineSync()!);

  print("Menu:");
  print("1. Addition");
  print("2. Subtraction");
  print("3. Multiplication");
  print("4. Division");

  stdout.write("Enter your choice (1-4): ");
  choice = int.parse(stdin.readLineSync()!);

  switch (choice) {
    case 1:
      print("Result: ${num1 + num2}");
      break;
    case 2:
      print("Result: ${num1 - num2}");
      break;
    case 3:
      print("Result: ${num1 * num2}");
      break;
    case 4:
      if (num2 != 0) {
        print("Result: ${num1 / num2}");
      } else {
        print("Cannot divide by zero.");
      }
      break;
    default:
      print("Invalid choice. Please choose a number between 1 and 4.");
  }
}