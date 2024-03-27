

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputNumberScren extends StatefulWidget {
  _InputNumberScrenState createState() => _InputNumberScrenState();
}

class _InputNumberScrenState extends State<InputNumberScren> {
  TextEditingController _firstNumberController = TextEditingController();
  TextEditingController _secondNumberController = TextEditingController();

  void _navigateToDisplayNumbersScreens(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DisplayNumbersScreen(
          firstNumber : int.parse(_firstNumberController.text),
          secondNumber : int.parse(_secondNumberController.text),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _firstNumberController,
              decoration: InputDecoration(labelText: "Enter the first number"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _secondNumberController,
              decoration: InputDecoration(labelText: "Enter the second number"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _navigateToDisplayNumbersScreens();
              },
              child: Text('Show Number'),
            ),
          ],
        ),
      ),
    );
  }
}

class DisplayNumbersScreen extends StatelessWidget {
  final int firstNumber;
  final int secondNumber;

  DisplayNumbersScreen({required this.firstNumber,required this.secondNumber});

  List<int> _generateNumbers() {
    List<int> numbers = [];
    for(int i = firstNumber; i <= secondNumber; i++) {
      numbers.add(i);
    }
    return numbers;
  }

  @override
  Widget build(BuildContext context) {
    List<int> numbers = _generateNumbers();
    return Scaffold(
      appBar: AppBar(
        title: Text('Display numbers'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[
            Text(
              'Numbers between $firstNumber and $secondNumber:',
              style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: numbers
              .map((numbers) => Text(
                numbers.toString(),
                style: TextStyle(fontSize: 16.0),
              ))
              .toList(),
            ),
          ],
        ),
      ),
    );
  }
}