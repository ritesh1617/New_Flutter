import 'dart:io';
import 'dart:math';

void main() {
  while (true) {
    print("Menu:");
    print("1. Calculate Area of Triangle");
    print("2. Calculate Area of Rectangle");
    print("3. Calculate Area of Circle");
    print("4. Exit");
    stdout.write("Enter your choice (1/2/3/4): ");
    String choice = stdin.readLineSync() ?? '';

    if (choice == '1') {
      double base = getDoubleInput("Enter the base of the triangle: ");
      double height = getDoubleInput("Enter the height of the triangle: ");
      double area = 0.5 * base * height;
      print("Area of the triangle: $area square units");
    } else if (choice == '2') {
      double length = getDoubleInput("Enter the length of the rectangle: ");
      double width = getDoubleInput("Enter the width of the rectangle: ");
      double area = length * width;
      print("Area of the rectangle: $area square units");
    } else if (choice == '3') {
      double radius = getDoubleInput("Enter the radius of the circle: ");
      double area = pi * pow(radius, 2);
      print("Area of the circle: $area square units");
    } else if (choice == '4') {
      print("Exiting the program.");
      break;
    } else {
      print("Invalid choice. Please select a valid option (1/2/3/4).");
    }
  }
}

double getDoubleInput(String prompt) {
  stdout.write(prompt);
  String input = stdin.readLineSync() ?? '0';
  return double.tryParse(input) ?? 0;
}