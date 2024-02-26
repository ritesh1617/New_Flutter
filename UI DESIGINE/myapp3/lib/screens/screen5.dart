
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class screen5 extends StatefulWidget {
  const screen5({super.key});

  @override
  State<screen5> createState() => _screen5State();
}

class _screen5State extends State<screen5> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Center(child: Text("Expanded")),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 300,
                margin: EdgeInsets.only(left: 20,right: 20),
                color: Colors.red,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Row(
                  children: [
                    Container(
                      height: 260,
                      width: 250,
                      color: Colors.blue,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              height:50,
                              width: 50,
                              color: Colors.green,
                            ),
                          Container(
                          height: 50,
                          width: 50,
                          color: Colors.blue,
                        ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                             height: 100,
                             width: 100,
                             color: Colors.brown,
                            ),
                          ],
                        ),
                      ],
                    ),
                      
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}