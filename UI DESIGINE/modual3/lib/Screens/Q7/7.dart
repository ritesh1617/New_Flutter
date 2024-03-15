

import 'package:flutter/material.dart';

class CheckboxExample extends StatefulWidget {
  @override
  _CheckboxExampleState createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool isChecke = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              activeColor: Colors.amber,
              value: isChecke,
              onChanged: (value) {
                setState(() {
                  isChecke = value!;
                });
              },
            ),
            SizedBox(height: 20),
            if (isChecke)
              Text(
                'Ritesh Patel',
                style: TextStyle(fontSize: 19),
              ),
          ],
        ),
      ),
    );
  }
}