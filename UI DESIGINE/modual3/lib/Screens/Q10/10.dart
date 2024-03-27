

import 'package:flutter/material.dart';

class ColorAdjustmentScreen extends StatefulWidget {
  _ColorAdjustmentScreenState createState() => _ColorAdjustmentScreenState();
}

class _ColorAdjustmentScreenState extends State<ColorAdjustmentScreen> {
  double _redvalue = 0.0;
  double _greenvalue = 0.0;
  double _bluevalue = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Adjustment'),
      ),
      body: Container(
        color: Color.fromARGB(
          255,
          _redvalue.round(),
          _greenvalue.round(),
          _bluevalue.round(),

        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Slider(
                value: _redvalue,
                onChanged: (value) {
                  setState(() {
                    _redvalue = value;
                  });
                },
                min: 0.0,
                max: 255.0,
                divisions: 255,
                label: 'Red: $_redvalue',
              ),
              Slider(
                value: _greenvalue,
                onChanged: (value) {
                  setState(() {
                    _greenvalue = value;
                  });
                },
                min: 0.0,
                max: 255.0,
                divisions: 255,
                label: 'Green: $_greenvalue',
              ),
              Slider(
                value: _bluevalue,
                onChanged: (value) {
                  setState(() {
                    _bluevalue = value;
                  });
                },
                min: 0.0,
                max: 255.0,
                divisions: 255,
                label: 'Red: $_bluevalue',
              ),
            ],
          ),
        ),
      ),
    );
  }
}