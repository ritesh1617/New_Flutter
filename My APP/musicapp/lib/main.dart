import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:musicapp/const/theme.dart';
import 'package:musicapp/screens/playSong.dart';
import 'package:musicapp/screens/songPage.dart';
import 'package:musicapp/screens/splash_Screen/spash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player',
      theme: darkTheme,
      home: SongPage(),
    );
  }
}
