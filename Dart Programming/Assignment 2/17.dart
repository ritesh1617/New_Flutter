import 'dart:io';

void main() {
  print("This is your menu : ");
  print("1.Addition");
  print("2.Substraction");
  print("3.Multiplication");
  print("4.Dvision");

  var addition, subtration, multiplication, division, choice, a, b;

  print("Enter first number : ");
  a = int.parse(stdin.readLineSync()!);
  print("Enter second number : ");
  b = int.parse(stdin.readLineSync()!);

  print("enter your choice: ");
  choice = int.parse(stdin.readLineSync()!);

  switch (choice) {
    case 1:
      addition = a + b;
      print(" Addition : $addition ");

    case 2:
      subtration = a - b;
      print("Substraction : $subtration ");

    case 3:
      multiplication = a * b;
      print("Mulltiplication : $multiplication ");

    case 4:
      division = a / b;
      print(" Division : $division ");

    default:
      print("Invalid Choice");
  }
}