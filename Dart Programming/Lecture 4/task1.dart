

import 'dart:io';

void main(){
     var name,a,annualincome,monthlyincome,loanamout;
     stdout.write("Enter Your Name");
     name=stdin.readLineSync()!;
     print("Hello $name welcome to our finance");
     print("1.Student");
     print("2.Salired");
     print("3.Self employeed");
     stdout.write("Are you a student,salired,self employed ?? : ");
     a = int.parse(stdin.readLineSync()!);



     switch(a){
        case 1:
        stdout.write("You are student:");
        stdout.write("Enter Your annual Income");
        annualincome = int.parse(stdin.readLineSync()!);
        student(annualincome, name);
        break;

      case 2:
      stdout.write("You are salired");
      stdout.write("Enter your monthly income : ");
      monthlyincome = int.parse(stdin.readLineSync()!);
      salired(monthlyincome, name);
      break;

      case 3:
      stdout.write("You are selfemployeed");
      stdout.write("Enter your annual income: ");
      annualincome = int.parse(stdin.readLineSync()!);
      Selfemployeed(annualincome, name);
      break;

       default:
      print("Invalid Choice");
      break;
     }
}

     
student(int annualincome, String name) {
  var monthlyincome = annualincome / 12;
  print("Monthly income : $monthlyincome");
  // monthlyincome = int.parse(stdin.readLineSync()!);
  var sum = (monthlyincome / 5);
  print("Sum : $sum");
  // sum = int.parse(stdin.readLineSync()!);
  if (monthlyincome >= 70000) {
    print("thank you can get this much of loan fomr our finance : $sum,$name");
  } else if (monthlyincome < 70000 && monthlyincome >= 50000) {
    print("thank you can get this much of loan fomr our finance : $sum,$name");
  } else if (monthlyincome < 50000 && monthlyincome >= 30000) {
    print("thank you can get this much of loan fomr our finance : $sum,$name");
  } else if (monthlyincome < 30000 && monthlyincome >= 18000) {
    print("thank you can get this much of loan fomr our finance : $sum,$name");
  } else {
    print("thank you can get this much of loan fomr our finance : $sum,$name");
  }
}

salired(int monthlyincome, String name) {
  var sum = (monthlyincome / 5);
  print("Sum : $sum");
  // sum = int.parse(stdin.readLineSync()!);
  if (monthlyincome >= 70000) {
    print("thank you can get this much of loan fomr our finance : $sum,$name");
  } else if (monthlyincome < 70000 && monthlyincome >= 50000) {
    print("thank you can get this much of loan fomr our finance : $sum,$name");
  } else if (monthlyincome < 50000 && monthlyincome >= 30000) {
    print("thank you can get this much of loan fomr our finance : $sum,$name");
  } else if (monthlyincome < 30000 && monthlyincome >= 18000) {
    print("thank you can get this much of loan fomr our finance : $sum,$name");
  } else {
    print("thank you can get this much of loan fomr our finance : $sum,$name");
  }
}

Selfemployeed(int annualincome, String name) {
  var monthlyincome = annualincome / 12;
  stdout.write("Monthly income : $monthlyincome");
  // monthlyincome = int.parse(stdin.readLineSync()!);
  var sum = (monthlyincome / 5);
  print("Sum : $sum");
  // sum = int.parse(stdin.readLineSync()!);
  if (monthlyincome >= 70000) {
    print("thank you can get this much of loan fomr our finance : $sum,$name");
  } else if (monthlyincome < 70000 && monthlyincome >= 50000) {
    print("thank you can get this much of loan fomr our finance : $sum,$name");
  } else if (monthlyincome < 50000 && monthlyincome >= 30000) {
    print("thank you can get this much of loan fomr our finance : $sum,$name");
  } else if (monthlyincome < 30000 && monthlyincome >= 18000) {
    print("thank you can get this much of loan fomr our finance : $sum,$name");
  } else {
    print("thank you can get this much of loan fomr our finance : $sum,$name");
  }



}
 
     