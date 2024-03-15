
import 'package:flutter/material.dart';

class list_diveder extends StatefulWidget {
  const list_diveder({Key? key}) : super(key: key);

  @override
  State<list_diveder> createState() => _list_divederState();
}

class _list_divederState extends State<list_diveder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemBuilder: (context,int ind){
            return ListTile(
              title: Container(
                child: Column(
                  children: [
                    Text("$ind",style: TextStyle(fontWeight: FontWeight.bold),),
                    Divider(
                      thickness: 2,
                      color: Colors.red,
                    )
                  ],
                ),
              ),
            );
          }
          ),
      ),
    );
  }
}