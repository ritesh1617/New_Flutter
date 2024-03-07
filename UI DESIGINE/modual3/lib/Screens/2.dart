
import 'package:flutter/material.dart';

class screen2M extends StatefulWidget {
  const screen2M({super.key});

  @override
  State<screen2M> createState() => _screen2MState();
}

class _screen2MState extends State<screen2M> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
             children: [
              TextFormField(
                 decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(20),
                  ),
                  ),
              ),
             ],
        ),
      ),
    );
  }
}