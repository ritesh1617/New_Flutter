/*
      1
     21
    321
   4321
  54321    

 */

import 'dart:io';

void main() {
  int i, j,s, n = 5;

  for (i = 1; i <= n; i++) {

    // Add spaces before the numbers
    for (s = 1; s <= n - i; s++) {
      stdout.write(' ');
    }

    // Print numbers in descending order
    for (j = i; j >= 1; j--) {
      stdout.write('$j');
    }

    print("");
  }
}
