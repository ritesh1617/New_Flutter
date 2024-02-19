import 'dart:io';

void main(){
  var num1,num2;
    print("Enter your number one here : ");
    num1 = int.parse(stdin.readLineSync()!);
    print("Enter your second number here : ");
    num2 = int.parse(stdin.readLineSync()!);
    fun(num1, num2);
}
void fun(int num1 ,int num2){

    var ans = num1 + num2;
    print("This is your ans $ans");
}