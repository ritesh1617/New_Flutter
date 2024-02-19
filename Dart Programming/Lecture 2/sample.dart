/*syntax:
if(constion){
  true satement;
}
*/

import 'dart:io';

void main(){
  var num;
  print('Enter your values here');
  num=int.parse(stdin.readLineSync()!);
  if(num>18){
    print('False');
  }
}