//list
//list list_name=[];
//IMP

import 'dart:math';

void main(){
  Random random=Random();
  List name=[1,2,3,4,5,6,7,8,9,10,"Name","Name2","Name3"];
  print(name[random.nextInt(name.length)]);
}