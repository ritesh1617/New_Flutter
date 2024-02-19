import 'dart:io';

void main() {
  loan();
}

void loan() {
  var uname,
      prof,stu,salir,selfemp,yearly_inc,monthly_inc;

  stdout.write("Enter Your name:");
  uname = stdin.readLineSync()!;
  print("Hello $uname welcome to our Bank");
  print()
  switch (prof) {
    case 1://///////////////////////
      print("You are a Student..?");
      break;

    case 2:
      print("You are a Salaried..?");
      break;

    case 3:
      print("You are a Self Employed..?");
      break;
    default:
      print("Please Enter Valid choice");
  }
}