import 'dart:io';

void main() {

  var principal,rateOfInterest,timeInYears,simpleInterest;
  print("Enter principal amount:");
   principal = double.parse(stdin.readLineSync()!);

  print("Enter rate of interest:");
   rateOfInterest = double.parse(stdin.readLineSync()!);

  print("Enter time in years:");
   timeInYears = double.parse(stdin.readLineSync()!);

   simpleInterest = (principal * rateOfInterest * timeInYears) / 100;

  print("Simple Interest: $simpleInterest");
}
