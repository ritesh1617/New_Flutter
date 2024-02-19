class A {
  void methodA() {
    print("Method from class A");
  }
}

class B extends A {
  void methodB() {
    print("Method from class B");
  }
}

class C extends B {
  void methodC() {
    print("Method from class C");
  }

  void callAllMethods() {
    methodA(); // Call method from class A
    methodB(); // Call method from class B
    methodC(); // Call method from class C
  }
}

void main() {
  var obj = C();
  obj.callAllMethods(); // Call all methods at once
}
