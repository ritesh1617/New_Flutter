import 'dart:io';

void main() {

  var number,result;
  
  print("Enter a number:");
  number = double.parse(stdin.readLineSync()!);

   result = (number > 0) ? "m1" : (number < 0) ? "n-1" : "zero";

  print(" The Number is : $result.");
}       