import 'dart:io';

void main() {

  var number,result;
  
  print("Enter a number:");
  number = int.parse(stdin.readLineSync()!);
                
   result = (number > 0) ? "positive" : (number < 0) ? "negative" : "zero";

  print("$number is $result.");
}