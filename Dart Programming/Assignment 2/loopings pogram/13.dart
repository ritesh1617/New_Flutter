import 'dart:io';

void main() {
  int num, digit, sum = 0;

  stdout.write("Enter a number: ");
  num = int.parse(stdin.readLineSync()!);

  while (num != 0) {
    digit = num % 10;   
    sum += digit;         
    num ~/= 10;         
  }

  print("$sum");
}
