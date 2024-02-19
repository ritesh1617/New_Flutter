
// 11. Write a Program to check the given year is leap year or not

import 'dart:io';

void main() {
  // Get user input
  stdout.write('Enter a year: ');
  int year = int.parse(stdin.readLineSync()!);

  // Check if the year is a leap year and print the result
  if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
    print('$year is a leap year.');
  } else {
    print('$year is not a leap year.');
  }
}
