
/*
16.Write a program user enter the 5 subjects mark. You have to make a
total and find the percentage. percentage > 75 you have to print
“Distinction” percentage > 60 and percentage <= 75 you have to
print “First class” percentage >50 and percentage <= 60 you have to print
“Second class” percentage > 35 and percentage <= 50 you have to print
“Pass class” Otherwise print “Fail” 
*/



import 'dart:io';

void main() {

  var subject1,subject2,subject3,subject4,subject5,totalMarks,percentage;

  stdout.write("Enter marks for Subject 1: ");
  subject1 = int.parse(stdin.readLineSync()!);

  stdout.write("Enter marks for Subject 2: ");
  subject2 = int.parse(stdin.readLineSync()!);

  stdout.write("Enter marks for Subject 3: ");
  subject3 = int.parse(stdin.readLineSync()!);

  stdout.write("Enter marks for Subject 4: ");
  subject4 = int.parse(stdin.readLineSync()!);

  stdout.write("Enter marks for Subject 5: ");
  subject5 = int.parse(stdin.readLineSync()!);

   totalMarks = subject1 + subject2 + subject3 + subject4 + subject5;
   percentage = (totalMarks / 500) * 100;

  print("Total Marks: $totalMarks");
  print("Percentage: $percentage%");

  if (percentage > 75) {
    print("Result: Distinction");
  } else if (percentage > 60 && percentage <= 75) {
    print("Result: First class");
  } else if (percentage > 50 && percentage <= 60) {
    print("Result: Second class");
  } else if (percentage > 35 && percentage <= 50) {
    print("Result: Pass class");
  } else {
    print("Result: Fail");
  }
}
