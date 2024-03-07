/*
    1  
   1 2
  1 2 3
 1 2 3 4
1 2 3 4 5

 */
import 'dart:io';
void main() {
  var i,j;

  for (i = 0; i < 5; i++) {
    for (j = (5 - i); j > 1; j--) {
      stdout.write(" ");
    }
    for (int j = 0; j <= i; j++) {
      var n = 1;
      n = n + j;
      stdout.write("$n ");
    }
    print(" ");
  }
}