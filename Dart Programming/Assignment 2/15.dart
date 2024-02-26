
import 'dart:io';

void main(){
  
  var marks,subject1,subject2,subject3,subject4,subject5,total;

   stdout.write("Enter the first subject marks : ");
   subject1=int.parse(stdin.readLineSync()!);

   stdout.write("Enter the second subject marks : ");
   subject2=int.parse(stdin.readLineSync()!);
    
   stdout.write("Enter the third subject marks : ");
   subject3=int.parse(stdin.readLineSync()!);

   stdout.write("Enter the Fourth subject marks : ");
   subject4=int.parse(stdin.readLineSync()!);

   stdout.write("Enter the Fifth subject marks : ");
   subject5=int.parse(stdin.readLineSync()!);

   print("total marks");
   print(total=subject1+subject2+subject3+subject4+subject5);
   marks = total * 100 / 500;
   
   if(marks > 90 && marks < 100){
    print("Distinction");
   }else if(marks > 60 && marks <=75){
     print("First class");
   }else if(marks > 50 && marks <= 60){
    print("second class");
   }else if(marks > 35 && marks <=50){
    print("Pass");
   }else(){
    print("Fail");
   };

}