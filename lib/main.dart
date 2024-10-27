import 'package:flutter/material.dart';
import 'package:wellzy/splash/splash_page.dart';

void main() {
  runApp(WellzyApp());
}

class WellzyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wellzy',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SplashPage(),
    );
  }
}