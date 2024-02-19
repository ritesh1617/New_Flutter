

import 'dart:io';

void main() {
  var first, last, sum;
  var n;
  print("Enter the Choice of your num");
  n = int.parse(stdin.readLineSync()!);

  last = n % 10;

  while (n >= 10) {
    n = n / 10;
    print(n);
  }
  first = n;
  sum = first + last;
  print(sum);
}
