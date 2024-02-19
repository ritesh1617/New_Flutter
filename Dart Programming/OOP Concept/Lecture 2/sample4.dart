class Flutter{
  var name;
  var age;
  void setName(String name){
    this.name=name;
  }
 void setAge(int age){
  this.age=age;
 }
 String getName(){
  return name;
 }
 String getAge(){
  return age;
 }
}

void main(){
  var obj=Flutter();
  obj.setName("Ritesh");
  obj.setAge(20);
  print(obj.getName());
  print(obj.getAge());
}