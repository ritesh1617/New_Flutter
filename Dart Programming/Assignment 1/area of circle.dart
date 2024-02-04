import 'dart:io';

void main() {
  
  stdout.write('Enter the radius of the circle: ');

  var radiusInput = stdin.readLineSync() ?? '';
  
  var radius = double.tryParse(radiusInput) ?? 0.0;

  var area = calculateCircleArea(radius);

  print('The area of the circle with radius $radius is: $area');
}

double calculateCircleArea(double radius) {
  return 3.14159 * radius * radius;
}
