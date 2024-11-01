import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wellzy/splash/splash_page.dart';
import 'package:wellzy/Views/auth/login_page.dart';
import 'package:wellzy/Views/auth/signup_page.dart';
import 'package:wellzy/Views/homepage/homepage.dart';
import 'package:wellzy/Views/auth/forgot_password_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    runApp(WellzyApp());
  } catch (e) {
    runApp(ErrorApp(error: e.toString()));
  }
}

class WellzyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wellzy',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
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

// ErrorApp widget to display a Firebase initialization error message
class ErrorApp extends StatelessWidget {
  final String error;

  ErrorApp({required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Initialization Error')),
        body: Center(
          child: Text(
            'Failed to initialize Firebase: $error',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
