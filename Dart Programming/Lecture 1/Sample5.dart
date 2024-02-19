/*
 Syntax : 
 (condtion) ?exp1 : exp2;
 -------------------------------------------------------
   Re op  
   > < >= <= == 
   ------------------------------------------
   log op  
   && || !=
   ----------------------------------------------------------
   using condtional or tarnnry op find
   posi or neg
   odd or even 
 */

import 'dart:io';

void main(){
  var age;
  print("Enter your age here : ");
  age = int.parse(stdin.readLineSync()!);
  // (age > 25 )?print("True"):print("False");
  // (age  > 0 && age < 100)?print("Human"):print("God");
  (age  > 0 || age < 0)?print("Human"):print("God");
}
          