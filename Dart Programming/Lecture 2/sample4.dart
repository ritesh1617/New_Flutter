/*
switch case:
syntax:
switch(exp){
  case1:
  statement;
  break;
  default;
  statement;
  break;
}
*/

import 'dart:io';

void main(){
  var days;
  print("Enter Your Day Here :");
  days = int.parse(stdin.readLineSync()!);
  switch(days){
    case 1:
    print("Monday");
    break;
     case 2:
    print("Thu");
    break;
     case 3:
    print("Wens");
    break;
     case 4:
    print("Thus");
    break;
     case 5:
    print("Fri");
    break;
     case 6:
    print("Sat");
    break;
     case 7:
    print("sun");
    break;
    default:
    print("Invalid Input");
    break;
  }
}