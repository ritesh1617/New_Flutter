
import 'dart:io';

void main() {
  int num, fDigit, lDigit, sum;

  stdout.write("Enter a number: ");
  num = int.parse(stdin.readLineSync()!);

  lDigit = num % 10;

  if (num < 0) {
    num = -num;
  }

  while (num>= 10) {
    num ~/= 10;
  }
  fDigit = num;

  sum = fDigit + lDigit;

  print("Sum of the first and last digits is: $sum");
}
