import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wellzy/firebase_auth_implementation/firebase_auth_services.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final FirebaseAuthService _authService = FirebaseAuthService();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    User? user = await _authService.signUpWithEmailAndPassword(
      _emailController.text,
      _passwordController.text,
    );

    if (user != null) {
      // Navigate to Home or show success message
      Navigator.pushReplacementNamed(context, '/home'); // Replace with actual route
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signup failed. Please try again.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0FBE2),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              ClipOval(
                child: Image.asset(
                  'assets/images/google-icon.png',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),

              // "Sign Up" Text
              const Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Baloo',
                  color: Color(0xFF294B29),
                ),
              ),
              const SizedBox(height: 20),

              // Full name TextField
              SizedBox(
                width: 400,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    hintText: 'Full Name',
                    hintStyle: const TextStyle(fontFamily: 'Baloo'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Email TextField
              SizedBox(
                width: 400,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    hintText: 'Email',
                    hintStyle: const TextStyle(fontFamily: 'Baloo'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Password TextField
              SizedBox(
                width: 400,
                height: 50,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'Password',
                    hintStyle: const TextStyle(fontFamily: 'Baloo'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Confirm password TextField
              SizedBox(
                width: 400,
                height: 50,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'Confirm password',
                    hintStyle: const TextStyle(fontFamily: 'Baloo'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Sign up Button
              SizedBox(
                width: 400,
                height: 50,
                child: ElevatedButton(
                  onPressed: _signUp,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    backgroundColor: const Color(0xFF72B376),
                  ),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF294B29),
                      fontFamily: 'Baloo',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),

              // Divider with text "or sign up with"
              const Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: Color(0xFF294B29),
                      height: 1.5,
                      thickness: 1.5,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "or sign up with",
                      style: TextStyle(fontSize: 14, fontFamily: 'Baloo',),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Color(0xFF294B29),
                      height: 1.5,
                      thickness: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Social Media Sign up Buttons
              SizedBox(
                width: 400,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Google login logic
                  },
                  icon: ClipOval(
                    child: Image.asset(
                      'assets/images/google-icon.png',
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                  ),
                  label: const Text(
                    'Sign Up with Google',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF294B29),
                      fontFamily: 'Baloo',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    backgroundColor: const Color(0xFF72B376),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
