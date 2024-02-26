import 'dart:io';

void main() {
  var num1, num2, num3;

  stdout.write("Enter your First number : ");
  num1 = int.parse(stdin.readLineSync()!);

  stdout.write("Enter your  Second  number: ");
  num2 = int.parse(stdin.readLineSync()!);

  stdout.write("Enter your Third  number : ");
  num3 = int.parse(stdin.readLineSync()!);

  if (num1 > num2) {
    if (num1 > num3) {
      print("num1 is Greater");
    }
  }
  if (num2 > num1) {
    if (num2 > num3) {
      print("num2 is Greater");
    }
  } else
    () {
      print("num3 isGgreater ");
    };
}
