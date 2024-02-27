import 'dart:io';

void main() {
  int number, digit, maxDigit = -1;

  stdout.write("Enter an integer: ");
  number = int.parse(stdin.readLineSync()!);

  number = (number < 0) ? -number : number; 

  while (number > 0) {
    digit = number % 10;
    if (digit > maxDigit) {
      maxDigit = digit;
    }
    number ~/= 10;
  }

  print("Max number is: $maxDigit");
}
