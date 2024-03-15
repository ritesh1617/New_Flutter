import 'package:flutter/material.dart';
import 'package:travelapp/const/export.dart';
import 'package:travelapp/custom%20widget/ContainerPro.dart';

Widget MyListView() {

   final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
  ];

  return ListView.builder(
    itemCount: colors.length,
    itemBuilder: (BuildContext context, int index) {
      return Card(
        child: Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: colors[index],
          ),
        ),
      );
    },
  );
}