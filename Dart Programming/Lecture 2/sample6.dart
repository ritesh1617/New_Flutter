import 'dart:io';

void main() {

  var number;
  print("Enter a number: ");
  number = int.parse(stdin.readLineSync()!);

  // Check if the number is positive, negative, or zero
  if (number > 0) {
    print("$number is  M1");
  } else if (number < 0) {
    print("$number is N-1");
  } else {
    print("$number is zero");
  }
}
