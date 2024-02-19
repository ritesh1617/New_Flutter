import 'dart:io';

void main() {
  var a, b = 0, c;
  bool choice = false;
  var name;
  while (true) {
    print("Welcome to my res");
    print("1). P = rs 250");
    print("2). B = rs 200");
    print("3). s = rs 100");
    print("4). D = rs 180");
    print("5). P = rs 250");
    print("Enter  your choice here what you want to order ");
    a = int.parse(stdin.readLineSync()!);
    print("QUI ?");
    c = int.parse(stdin.readLineSync()!);
    var itemPrice = 0;

    switch (a) {
      case 1:
        b = c * 250;
        break;
      case 2:
        b = c * 200;
        break;
      case 3:
        b = c * 150;
        break;
      case 4:
        b = c * 180;
        break;
      case 5:
        b = c * 250;
        break;
      default:
        print("Invalid input");
        continue;
    }
    
     b += itemPrice;

    print("Do you want to oder anything else ? yes or no");
    name = stdin.readLineSync()!;
    if (name.toString() == "yes" ||
        name.toString() == "YES" ||
        name.toString() == "y") {
    } else if (name.toString() == "NO" ||
        name.toString() == "no" ||
        name.toString() == "n") {
      choice = true;
      break;
    }
  }
   print("Total Price: Rs $b");
}