

import 'dart:io';

void main() {
  var n, table;
  print("enter your input");
  n = int.parse(stdin.readLineSync()!);
  for (int i = 1; i <= 10; i++) {
    table = n * i;
    print(table);
  }
}
