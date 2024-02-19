
/* 
19. Write a program of to find out the Area of Triangle, Rectangle and
Circle using If Condition.(Must Be Menu Driven)..
*/

import 'dart:io';
import 'dart:math';

void main() {
  var choice;

  print("Menu:");
  print("1. Area of Triangle");
  print("2. Area of Rectangle");
  print("3. Area of Circle");

  stdout.write("Enter your choice (1-3): ");
  choice = int.parse(stdin.readLineSync()!);

  if (choice >= 1 && choice <= 3) {
    switch (choice) {
      case 1:
        calculateTriangleArea();
        break;
      case 2:
        calculateRectangleArea();
        break;
      case 3:
        calculateCircleArea();
        break;
    }
  } else {
    print("Invalid choice. Please choose a number between 1 and 3.");
  }
}

void calculateTriangleArea() {
  var base, height,area;

  stdout.write("Enter the base of the triangle: ");
  base = double.parse(stdin.readLineSync()!);

  stdout.write("Enter the height of the triangle: ");
  height = double.parse(stdin.readLineSync()!);

  area = 0.5 * base * height;
  print("Area of the triangle: $area");
}

void calculateRectangleArea() {
  var length, width,area;

  stdout.write("Enter the length of the rectangle: ");
  length = double.parse(stdin.readLineSync()!);

  stdout.write("Enter the width of the rectangle: ");
  width = double.parse(stdin.readLineSync()!);

   area = length * width;
  print("Area of the rectangle: $area");
}

void calculateCircleArea() {
  var radius,area;

  stdout.write("Enter the radius of the circle: ");
  radius = double.parse(stdin.readLineSync()!);

  area = pi * pow(radius, 2);
  print("Area of the circle: $area");
}
