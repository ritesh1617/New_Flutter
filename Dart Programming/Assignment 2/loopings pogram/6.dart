import 'dart:io';

void main() {
  print("Enter a number to print its table: ");
  var number = int.parse(stdin.readLineSync() !);

  if (number < 0) {
    print("Table is not defined for negative numbers.");
  } else {
    print("Table of $number:");

    for (int i = 1; i <= 10; i++) {
      int num = number * i;
      print("$number x $i = $num");
    }
  }
}