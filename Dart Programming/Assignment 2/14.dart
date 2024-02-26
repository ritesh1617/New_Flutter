
import 'dart:io';

void main(){
   
   var num1,num2,num3;
   
   stdout.write("Enter your First Num : ");
   num1=int.parse(stdin.readLineSync()!);

   stdout.write("Enter Your Second Num : ");
   num2=int.parse(stdin.readLineSync()!);

   stdout.write("Enter Your Third Num : ");
   num3=int.parse(stdin.readLineSync()!);
   
     (num1 > num2 && num1 > num3)
      ?print("num1 is greter")
       :(num2 > num3 && num2 > num1)
       ?print("num2 is Greter")
       :print("num3 is greter");
   
   }

 
   