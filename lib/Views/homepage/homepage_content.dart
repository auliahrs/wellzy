import 'package:flutter/material.dart';
import 'package:wellzy/Views/auth/login_page.dart';

class Homepagecontent extends StatelessWidget {
  const Homepagecontent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Welcome Text
          const Text(
            'Welcome Admin!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF294B29), // Custom color
              fontFamily: 'Baloo',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),

          // Sign Out Button
          SizedBox(
            width: double
                .infinity, // Makes the button span the full width of the screen
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the login page on sign out
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
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
                'Sign Out',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontFamily: 'Baloo',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
