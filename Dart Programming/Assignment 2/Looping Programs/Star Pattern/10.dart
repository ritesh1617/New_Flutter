/*
1
2 3
4 5 6
7 8 9 10
11 12 13 14 15

 */
import 'dart:io';

void main() {

  var rows = 5; // Number of rows in the pattern
  var currentValue = 1; // Starting value

  for (int i = 1; i <= rows; i++) {
    for (int j = 1; j <= i; j++) {
      stdout.write('$currentValue ');
      currentValue++;
    }
    print(''); // Move to the next line after each row
  }
}
