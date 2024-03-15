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
                Image.asset('assets/left_top_image.png'),
                Image.asset('assets/right_top_image.png'),
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
                Image.asset('assets/left_bottom_image.png'),
                Image.asset('assets/right_bottom_image.png'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}