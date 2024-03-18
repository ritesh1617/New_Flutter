

import 'package:flutter/material.dart';

class ColorScreen extends StatefulWidget {
  @override
  _ColorState createState() => _ColorState();
}

class _ColorState extends State<ColorScreen> {
  Color? selectedColor = Colors.red; // Changed type to Color?

  void setColor(Color? color) { // Changed type to Color?
    setState(() {
      selectedColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: Container(
        color: selectedColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RadioListTile(
                title: Text('Red'),
                value: Colors.red,
                groupValue: selectedColor,
                onChanged: setColor,
              ),
              RadioListTile(
                title: Text('Green'),
                value: Colors.green,
                groupValue: selectedColor,
                onChanged: setColor,
              ),
              RadioListTile(
                title: Text('Blue'),
                value: Colors.blue,
                groupValue: selectedColor,
                onChanged: setColor,
              ),
              SizedBox(height: 20),
             
            ],
          ),
        ),
      ),
    );
  }
}