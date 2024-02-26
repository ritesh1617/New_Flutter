
import 'dart:io';

void main() {
  var num, table,i;
  stdout.write("Enter your table : ");

  num = int.parse(stdin.readLineSync()!);

  for (i = 1; i <= 10; i++) {
    table = num * i;
    print(table);
  }
}
