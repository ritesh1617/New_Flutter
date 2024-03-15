

import 'package:flutter/material.dart';
import 'package:myapp/Custom%20Widget/container.dart';

class musicplay extends StatefulWidget {
  const musicplay({Key? key}) : super(key: key);

  @override
  State<musicplay> createState() => _musicplayState();
}

class _musicplayState extends State<musicplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Containerpro(
                  Height: 50,
                  Width: 50,
                  child: Icon(Icons.arrow_back),
                ),
              ],
            )
          ],
        ),
      ),
      
    );
  }
}