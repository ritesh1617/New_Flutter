/*
syntax:
for(i;c;u){
  body of loop
}
*/

import 'dart:io';

void main(){
  List? Numbers =<int>[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15];
  var newmember;
  print("Enter the number which you want to add in list");
  newmember=int.parse(stdin.readLineSync()!);
  Numbers.addAll(newmember);
  for(int i=0;i<Numbers.length;i++){
    print(Numbers[i]);
  }
}