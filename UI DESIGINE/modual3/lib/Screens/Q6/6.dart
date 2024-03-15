import 'package:flutter/material.dart';

class FontSize extends StatefulWidget {
  @override
  _FontSizeState createState() => _FontSizeState();
}

class _FontSizeState extends State<FontSize> {
  double _fontSize = 20.0;

  void _increaseFontSize() {
    setState(() {
      _fontSize += 3.0;
    });
  }

  void _decreaseFontSize() {
    setState(() {
      if (_fontSize > 3.0) {
        _fontSize -= 3.0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ritesh',
              style: TextStyle(fontSize: _fontSize),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _increaseFontSize,
                ),
                SizedBox(width: 20),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: _decreaseFontSize,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}