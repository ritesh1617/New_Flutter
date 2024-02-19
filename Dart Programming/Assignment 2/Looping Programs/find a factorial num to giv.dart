import 'dart:io';

void main() {
  int i, factorial = 1, num;
  print("Enter the number ");
  num = int.parse(stdin.readLineSync()!);
  for (i = 1; i <= num; i++) {
    factorial = factorial * i;
  }
  print("The factorial of given number is  = $factorial");
}
