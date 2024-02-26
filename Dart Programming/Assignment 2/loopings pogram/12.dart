import 'dart:io';

void main() {
  var n;
  print("Enter number : ");
  n = int.parse(stdin.readLineSync()!);
  var i = n;
  while (i >= 1) {
    print("$i");
    i--;
  }
}