import 'dart:io';

void main() {
  var a;
  print("Enter the year");
  a = int.parse(stdin.readLineSync()!);

  if (a % 4 == 0) {
    print("the year is leap year");
  } else {
    print('$a is not a leap year.');
  
}
}