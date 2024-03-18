import 'package:flutter/material.dart';

class ImagesAroundText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/1.jpeg'),
                Image.asset('assets/2.jpeg'),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Ritesh',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/3.jpeg'),
                Image.asset('assets/4.jpeg'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}