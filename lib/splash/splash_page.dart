import 'package:flutter/material.dart';
import 'dart:async';

import '../Views/auth/login_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    // Splash screen for 3 seconds
    Timer(const Duration(seconds: 3), () {
      // Navigate to LoginPage after splash screen
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0FBE2),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/wellzy-logo.png',
              width: 120,
              height: 120,
            ),
          ],
        ),
      ),
    );
  }
}
