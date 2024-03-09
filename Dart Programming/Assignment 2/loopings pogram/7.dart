import 'dart:io';

void main() {
  print("Enter a number: ");
  var number = int.parse(stdin.readLineSync()!);
  
  String Number = number.toString();
  String reverseNumber = reverseString(Number);
  
  int reversedNumber = int.parse(reverseNumber);
  
  print("Reverse Number: $reversedNumber");
}

String reverseString(String input) {
  return String.fromCharCodes(input.runes.toList().reversed);
}