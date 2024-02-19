/*
if else
syntax:
if(condition){
  true statement;
}else{
  false statement;
}
*/

import 'dart:io';

void main(){
  var num;
  print('Enter your values here : ');
  num=int.parse(stdin.readLineSync()!);
  if(num>18){
    print("True statement");
  }else{
    print("False statement");
  }
}