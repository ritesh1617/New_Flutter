import 'dart:io';

void main() {

  stdout.write('Enter the base of the triangle: ');

  String baseInput = stdin.readLineSync() ?? '';
  
  double base = double.tryParse(baseInput) ?? 0.0;

  stdout.write('Enter the height of the triangle: ');

  String heightInput = stdin.readLineSync() ?? '';
  
  double height = double.tryParse(heightInput) ?? 0.0;

  double area = calculateTriangleArea(base, height);

  print('The area of the triangle with base $base and height $height is: $area');
}

double calculateTriangleArea(double base, double height) {
  return 0.5 * base * height;
}
