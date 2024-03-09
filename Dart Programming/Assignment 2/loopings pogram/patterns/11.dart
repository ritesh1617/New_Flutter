/*
1
10
101
1010
10101

 */


import 'dart:io';

void main() {
  for (int i = 1; i <= 5; i++) {
    for (int j = 1; j <= i; j++) {
      if (j % 2 == 0) {
        stdout.write("0");
      } else {
        stdout.write("1");
      }
    }
    print("");
  }
}