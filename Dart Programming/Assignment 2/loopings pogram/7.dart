import 'dart:io';

void main() {
  int number, remainder, reverseNumber = 0;

  stdout.write("Enter an integer: ");
  number = int.parse(stdin.readLineSync()!);

  while (number != 0) {
    remainder = number % 10;
    reverseNumber = reverseNumber * 10 + remainder;
    number ~/= 10;
  }

  print("Reversed number: $reverseNumber");
}
