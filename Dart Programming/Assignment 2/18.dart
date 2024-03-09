import 'dart:io';

void main() {
  print("*******************");
  print("This is your Menu");
  print("1.Addition");
  print("2.Substraction");
  print("3.Multiplication");
  print("4.Division");
  print("*******************");

  var add, sub, mul, div, choice, num1, num2;

  print("Enter Number 1 : ");
  num1 = int.parse(stdin.readLineSync()!);
  print("Enter Number 2 : ");
  num2 = int.parse(stdin.readLineSync()!);

  print("enter your choice: ");
  choice = int.parse(stdin.readLineSync()!);

  switch (choice) {
    case 1:
      add = num1 + num2;
      print(" This is Addition of number1 and number2 : $add ");

    case 2:
      sub = num1 - num2;
      print(" This is Substraction of number1 and number2  : $sub ");

    case 3:
      mul = num1 * num2;
      print(" This is Mulltiplication of number1 and number2 : $mul ");

    case 4:
      div = num1 / num2;
      print(" This is  Division of number1 and number2  : $div ");

    default:
      print("Invalid Choice");
  }
}