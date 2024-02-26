//17. Write Program use switch statement. Display Monday to Sunday

import 'dart:io';

void main(){
  var days;
  print("Enter Your Day Here :");
  days = int.parse(stdin.readLineSync()!);
  switch(days){
    case 1:
    print("MON");
    break;
     case 2:
    print("TUE");
    break;
     case 3:
    print("WED");
    break;
     case 4:
    print("THU");
    break;
     case 5:
    print("FRI");
    break;
     case 6:
    print("SAT");
    break;
     case 7:
    print("sun");
    break;
    default:
    print("Invalid Input");
    break;
  }
}