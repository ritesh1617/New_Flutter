import 'dart:io';

void main(){
  var numbers ,numbres2;
  print("enter the value of 1 : ");
  numbers = stdin.readLineSync()!;
  print("Enter your values for 2 : ");
  numbres2 = stdin.readLineSync()!;
  var ans = fun(numbers, numbres2);
  print("This is your answer $ans");
}
fun(var num1,var num2){
   
  return num1+num2;
}