import 'package:flutter/material.dart';
import 'package:wellzy/Views/auth/signup_page.dart';
import '../homepage/homepage.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
              const SizedBox(height: 10),

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
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    hintText: 'Username or Email',
                    hintStyle: const TextStyle(fontFamily: 'Baloo'),
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
              const SizedBox(height: 20),

              // Login Button
              SizedBox(
                width: 400,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
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

              // Login with Google button
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
