import 'package:flutter/material.dart';

class screen1 extends StatefulWidget {
  const screen1({super.key});

  @override
  State<screen1> createState() => _screen1State();
}

class _screen1State extends State<screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(14),
              height: 150,
              width: double.maxFinite,
              color: Colors.red,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.all(14),
                  height: 150,
                  width: 220,
                  color: Colors.blue,
                  ),
                  Container(
                     margin: EdgeInsets.all(14),
                  height: 150,
                  width: 220,
                  color: Colors.blue,
                  ),
                
              ],
            ),
             Row(
              children: [
                Container(
                  margin: EdgeInsets.all(14),
                  height: 150,
                  width: 220,
                  color: Colors.blue,
                  ),
                  Container(
                     margin: EdgeInsets.all(14),
                  height: 150,
                  width: 220,
                  color: Colors.blue,
                  ),
                
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(14),
                  height: 100,
                  width: 100,
                  color: Colors.yellow,
                  ),
                  Container(
                     margin: EdgeInsets.all(14),
                  height: 100,
                  width: 100,
                  color: Colors.yellow,
                  ),
                  Container(
                     margin: EdgeInsets.all(14),
                  height: 100,
                  width: 100,
                  color: Colors.yellow,
                  ),
                
              ],
            )
          ],
        ),
      ),
    );
  }
}