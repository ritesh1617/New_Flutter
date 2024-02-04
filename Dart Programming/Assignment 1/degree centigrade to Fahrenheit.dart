import 'dart:io';

void main() {

  var celsius,fahrenheit;
  print("Enter temperature in Celsius:");
   celsius = double.parse(stdin.readLineSync()!);

   fahrenheit = (celsius * 9/5) + 32;

  print("  Fahrenheit : $fahrenheit"); 
}
