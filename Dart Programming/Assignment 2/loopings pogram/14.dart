import 'dart:io';

void main() {
  int num, digit, maxDigit = -1;

  // Get user input
  stdout.write("Enter a number: ");
  num = int.parse(stdin.readLineSync()!);

  if (num < 0) {
    num = -num;
  }

  while (num > 0) {
    digit = num % 10;  
    if (digit > maxDigit) {
      maxDigit = digit;  
    }
    num ~/= 10;  
  }

  print("max digit is : $maxDigit");
}
