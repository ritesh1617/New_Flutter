
import 'dart:io';

void main() {
  int i, j, n=1;

  for(i=1;i<=5;i++){
    
    for(j = 1; j<i+1;j++)
    {
      stdout.write('${n++} ');
     
    }
    print("");
  }

}