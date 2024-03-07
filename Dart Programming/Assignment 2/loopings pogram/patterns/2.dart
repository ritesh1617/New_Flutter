/*
1
12
123
1234
12345
 */

import 'dart:io';

void main() {
  var i,j;

  for (i = 1; i <= 5; i++) {
    for (j = 1; j <= i; j++) {
      stdout.write(j);
    }
    print('');
  }
}