

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();
  String result = '';
  String operation = '';

  void calculate() {

    var num1,num2;
    var res;
       num1 = double.tryParse(num1Controller.text)?? 0.0;
       num2 = double.tryParse(num2Controller.text) ?? 0.0;

       res = 0;

    switch (operation) {
      case 'Addition':
        res = num1 + num2;
        break;
      case 'Subtraction':
        res = num1 - num2;
        break;
      case 'Multiplication':
        res = num1 * num2;
        break;
        
      case 'Division': 
       res = num1 / num2;
        break;
    }
    setState(() {
      result = res.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: num1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                 border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24)
                ),
                labelText: 'Number 1',
              ),
            ),
            10.heightBox,
            TextField(
              controller: num2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24)
                ),
                labelText: 'Number 2',
              ),
            ),
            SizedBox(height: 20),
            Text('Choose operation:'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Radio(
                  activeColor: Colors.red,
                  value: 'Addition',
                  groupValue: operation,
                  onChanged: (value) {
                    setState(() {
                      operation = value!;
                    });
                  },
                ),
                Text('Add'),
                Radio(
                  activeColor: Colors.red,
                  value: 'Subtraction',
                  groupValue: operation,
                  onChanged: (value) {
                    setState(() {
                      operation = value!;
                    });
                  },
                ),
                Text('Subtraction'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Radio(
                  activeColor: Colors.red,
                  value: 'Multiplication',
                  groupValue: operation,
                  onChanged: (value) {
                    setState(() {
                      operation = value!;
                    });
                  },
                ),
                Text('Multiply'),
                Radio(
                  activeColor: Colors.red,
                  value: 'Division',
                  groupValue: operation,
                  onChanged: (value) {
                    setState(() {
                      operation = value!;
                    });
                  },
                ),
                Text('Division'),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green)),
              onPressed: () {
                calculate();
              },
              child: Text('Calculate',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 20),
            Text(
              'Result: $result',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}