/*
1
12
123
1234
12345


 */

import 'dart:io';

void main() {
  int i, j, numbers, n = 5;

  for(i=0;i<n;i++){
    stdout.write(" ");
    numbers = 1;
    for(j = 0; j<=i;j++)
    
    {
     
      stdout.write('$numbers ');
      numbers++;
    }
        print("");

  }

}