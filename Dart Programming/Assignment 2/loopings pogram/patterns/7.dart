/*
1
4 4
9 9 9
16 16 16 16
25 25 25 25 15

 */
import 'dart:io';

void main() {
  var i,j; 

  for (i = 1; i <= 5; i++) {
    for (j = 1; j <=i; j++) {
      int value = i* i;
      if (i == 5) {
        value = 15;
      }
      stdout.write('$value ');
    }
    print(''); 
  }
}
