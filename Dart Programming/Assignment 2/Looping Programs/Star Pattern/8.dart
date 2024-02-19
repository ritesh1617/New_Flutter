import 'dart:io';

void main() {
  int i, j, numbers=1, n = 5;

  for(i=1;i<=n;i++){
    
    for(j = 1; j<i+1;j++)
    {
      stdout.write('${numbers++} ');
     
    }
    stdout.writeln();
  }

}