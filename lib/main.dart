import 'package:flutter/material.dart';
import 'package:wellzy/splash/splash_page.dart';
import 'package:wellzy/Views/auth/login_page.dart';
import 'package:wellzy/Views/auth/signup_page.dart';
import 'package:wellzy/Views/homepage/homepage.dart';
import 'package:wellzy/Views/auth/forgot_password_page.dart';

import 'Views/homepage/homepage.dart';

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
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/home': (context) => const HomePage(),
        '/forgot_password': (context) => const ForgotPasswordPage(),
      },
    );
  }
}
