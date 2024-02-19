
void main() {
  var list1 = [1, 2, 3, 4, 5];
  print(list1);

  var list2 = list1.reversed;

  var revlist = new List.from(list2);
  print(revlist);
}
