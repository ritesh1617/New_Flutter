

import 'dart:io';

void main() {
  var num1, num2, num3;
  print("Enter the First choice of your number");
  num1 = int.parse(stdin.readLineSync()!);
  print("Enter the Second choice of your number");
  num2 = int.parse(stdin.readLineSync()!);
  print("Enter the Third choice of your number");
  num3 = int.parse(stdin.readLineSync()!);

  if (num1 > num2) {
    if (num1 > num3) {
      print("num1 is greater");
    }
  }
  if (num2 > num1) {
    if (num2 > num3) {
      print("num2 is greater");
    }
  } else
    () {
      print("num3 is greater num");
    };
}
