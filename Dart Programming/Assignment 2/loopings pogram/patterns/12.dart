/*

    1 
   2 2
  3 3 3
 4 4 4 4
5 5 5 5 5 

 */

import 'dart:io';

void main() {
  var row;
  var n = 1;
  stdout.write("Enter your numberS here : ");
  row = int.parse(stdin.readLineSync()!);
  for (int i = 0; i < row; i++) {
    for (int j = (row - i); j > 1; j--) {
      stdout.write(" ");
    }
    for (int j = 0; j <= i; j++) {
      stdout.write("$n ");
    }
    n++;
    stdout.writeln();
  }
}