/*
     * 
    * *
   * * *
  * * * *
 * * * * *
* * * * * *
 */
import 'dart:io';
void main() {
  

  
  for (int i = 1; i <= 6; i++) {
    for (int j =6 - i; j > 0; j--) {
      stdout.write(" ");
    }
    for (int k = 1; k <= i; k++) {
      stdout.write("* ");
    }
    print("");
  }
}  