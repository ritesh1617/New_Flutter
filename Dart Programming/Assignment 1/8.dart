import 'dart:io';

void main() {

  var subject1,subject2,subject3,subject4,subject5,sum,totalMarks,percentage;
  print("Enter marks for Subject 1:");
   subject1 = double.parse(stdin.readLineSync()!);

  print("Enter marks for Subject 2:");
  subject2 = double.parse(stdin.readLineSync()!);

  print("Enter marks for Subject 3:");
   subject3 = double.parse(stdin.readLineSync()!);

  print("Enter marks for Subject 4:");
  subject4 = double.parse(stdin.readLineSync()!);

  print("Enter marks for Subject 5:");
  subject5 = double.parse(stdin.readLineSync()!);

   sum = subject1 + subject2 + subject3 + subject4 + subject5;

   totalMarks = 500; 
   percentage = (sum / totalMarks) * 100;

  print("Total Marks: $sum");
  print("Percentage: $percentage%");
}
