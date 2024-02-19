
import 'dart:io';

void main() {
  int i, j, numbers, n = 5;
  stdout.write(" ");

  for(i=0;i<n;i++){
    stdout.write(" ");
    numbers = 1;
    stdout.write(" ");
    for(j = 0; j<=i;j++)
    
    {
      stdout.write(" ");
      stdout.write('$numbers ');
      numbers++;
    }
     print(" ");
  }
}