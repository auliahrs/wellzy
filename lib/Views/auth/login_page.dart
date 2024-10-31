import 'package:flutter/material.dart';
import 'package:wellzy/Views/auth/signup_page.dart';
import 'package:wellzy/Views/homepage/homepage.dart';
import 'forgot_password_page.dart';
import 'package:wellzy/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuthService _authService =
      FirebaseAuthService(); // Initialize FirebaseAuthService

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Function to handle login
  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter both email and password")),
      );
      return;
    }

    // Attempt to login
    final user = await _authService.loginWithEmailAndPassword(email, password);
    if (user != null) {
      // Navigate to HomePage on successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login failed. Please check your credentials.")),
      );
    }
  }

  //login logic using the same signupwithgoogle logic
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

              // "Login" Text
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Baloo',
                  color: Color(0xFF294B29),
                ),
              ),
              const SizedBox(height: 30),

              // Username or Email TextField
              SizedBox(
                width: 400,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    label: Text(
                      'Email',
                      style: TextStyle(fontFamily: 'Baloo'),
                    ),
                    prefixIcon: const Icon(Icons.person),
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
              const SizedBox(height: 10),

              // Password TextField
              SizedBox(
                width: 400,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text(
                      'Password',
                      style: TextStyle(fontFamily: 'Baloo'),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'Password',
                    hintStyle: TextStyle(
                        fontFamily: 'Baloo',
                        color: Color.fromARGB(100, 0, 0, 0)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Login Button
              SizedBox(
                width: 400,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    backgroundColor: const Color(0xFF72B376),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF294B29),
                      fontFamily: 'Baloo',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Forgot Password and Sign Up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Forgot your password? ',
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
                            builder: (context) => const ForgotPasswordPage()),
                      );
                    },
                    child: const Text(
                      'Click here',
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
              const SizedBox(height: 60),

              // Divider with text "or login with"
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
                      "or login with",
                      style: TextStyle(fontSize: 14, fontFamily: 'Baloo'),
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
              const SizedBox(height: 10),

              // Login with Google account button
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
                    'Login with Google',
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

              // "Don't have an account? Sign up"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
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
                            builder: (context) => const SignupPage()),
                      );
                    },
                    child: const Text(
                      'Sign up',
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
