


import 'dart:io';

void main() {
  var num1, num2, num3, num4, sum;
  print("Enter the First choice of your number");
  num1 = int.parse(stdin.readLineSync()!);
  print("Enter the Second choice of your number");
  num2 = int.parse(stdin.readLineSync()!);
  print("Enter the Third choice of your number");
  num3 = int.parse(stdin.readLineSync()!);
  print("Enthe the fourth choice of your number");
  num4 = int.parse(stdin.readLineSync()!);

  sum = num1 + num2 + num3 + num4;
  print("the summation of the given number is = $sum");
}
