import 'package:flutter/material.dart';

import 'ui/firstscreen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Weather App",
      home: firstscreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
