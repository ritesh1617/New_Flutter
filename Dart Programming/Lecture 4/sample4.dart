import 'dart:io';

void main(){
  var name,age;
  print("Enter your name here : ");
  name = stdin.readLineSync()!;
  print("Enter your age here : ");
  age = int.parse(stdin.readLineSync()!);
  fun(age, name);
}
void fun(int age,String name){
  print("Hello $name ");
  if (age>18) {
      print("You can use this app ");
  }else{
    print("You can't use this app");
  }
}