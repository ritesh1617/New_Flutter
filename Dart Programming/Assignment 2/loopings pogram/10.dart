import 'dart:io';

void main() {
  int number, sum = 0;

  
  stdout.write("Enter a number: ");
  number = int.parse(stdin.readLineSync()!);

  for (int i = 1; i <= number; ++i) {
    sum += i;
  }

  print("The summation of numbers from 1 to $number is: $sum");
}
