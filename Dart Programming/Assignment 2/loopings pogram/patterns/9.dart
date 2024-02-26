import 'dart:io';
void main(){
  
    var i,j;
    for( i = 0 ; i< 6; i++)
    {
        for( j=2*(6-i);j>=0;j--){
            stdout.write(" ");
        }
        for(j = 0;j<=i;j++)
        {
            stdout.write("* ");
        }
            print("");

    }
}