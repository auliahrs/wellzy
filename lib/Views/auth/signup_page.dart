import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wellzy/Views/auth/login_page.dart';
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
  final TextEditingController _confirmPasswordController =
      TextEditingController();

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

    if (user != null) {avigate to Home or show success message
      Navigator.pushReplacementNamed(
          context, '/home'); // R
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signup failed. Please try again.")),
      );
    }
  }

  void _signUpWithGoogle() async {
    User? user = await _authService.signUpWithGoogle();
    if (user != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Google sign-up failed. Please try again.")),
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
              Image.asset(
                'assets/images/wellzy-logo.png',
                width: 120,
                height: 120,
              ),

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
                  controller:
                      _usernameController, // Connect the controller here
                  decoration: InputDecoration(
                    label: Text(
                      'Full Name',
                      style: TextStyle(fontFamily: 'Baloo'),
                    ),
                    prefixIcon: const Icon(Icons.person),
                    hintText: 'name',
                    hintStyle: TextStyle(
                        fontFamily: 'Baloo',
                        color: Color.fromARGB(100, 0, 0, 0)),
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
                  controller: _emailController, // Connect the controller here
                  decoration: InputDecoration(
                    label: Text(
                      'Email',
                      style: TextStyle(fontFamily: 'Baloo'),
                    ),
                    prefixIcon: const Icon(Icons.email),
                    hintText: 'email@email.com',
                    hintStyle: TextStyle(
                        fontFamily: 'Baloo',
                        color: Color.fromARGB(100, 0, 0, 0)),
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
                  controller:
                      _passwordController, // Connect the controller here
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text(
                      'Password',
                      style: TextStyle(fontFamily: 'Baloo'),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'password',
                    hintStyle: TextStyle(
                        fontFamily: 'Baloo',
                        color: Color.fromARGB(100, 0, 0, 0)),
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
                  controller:
                      _confirmPasswordController, // Connect the controller here
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text(
                      'Confirm Password',
                      style: TextStyle(fontFamily: 'Baloo'),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'confirm password',
                    hintStyle: TextStyle(
                        fontFamily: 'Baloo',
                        color: Color.fromARGB(100, 0, 0, 0)),
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
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Baloo',
                      ),
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

              // Sign up with Google account Buttons
              SizedBox(
                width: 400,
                child: ElevatedButton.icon(
                  onPressed: _signUpWithGoogle,
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
              // "Already have an account? Sign up"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF294B29),
                      fontFamily: 'Baloo',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF294B29),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Baloo',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
