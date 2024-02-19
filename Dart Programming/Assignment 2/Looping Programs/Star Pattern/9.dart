/*
1
4 4
9 9 9
16 16 16 16
25 25 25 25 15

 */
import 'dart:io';

void main() {
  int rows = 5; // Number of rows in the pattern

  for (int i = 1; i <= rows; i++) {
    for (int j = 1; j <=i; j++) {
      int value = i* i;
      if (i == rows) {
        value = 15;
      }
      stdout.write('$value ');
    }
    print(''); // Move to the next line after each row
  }
}
