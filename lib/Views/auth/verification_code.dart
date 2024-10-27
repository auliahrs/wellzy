import 'package:flutter/material.dart';
import 'package:wellzy/Views/auth/recover_password_page.dart';

class VerificationCodePage extends StatelessWidget {
  const VerificationCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0FBE2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE0FBE2),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF294B29)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // Logo
                ClipOval(
                  child: Image.asset(
                    'assets/images/google-icon.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),

                // Verification Text
                const Text(
                  'Verification',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF294B29),
                    fontFamily: 'Baloo',
                  ),
                ),
                const SizedBox(height: 10),

                // Instructions Text
                const Text(
                  'Enter the verification code we just sent you on your email address.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFB4B4B8),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Email Input TextField
                SizedBox(
                  width: 400,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your verification code',
                      hintStyle: const TextStyle(
                        color: Color(0xFFB4B4B8),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          color: Color(0xFFB4B4B8),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          color: Color(0xFFB4B4B8),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Verify Code Button
                SizedBox(
                  width: 400,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RecoverPasswordPage(),
                        ),
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
                      'Verify Code',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF294B29),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Resend code Text with navigation
                GestureDetector(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => RecoverPasswordPage(),
                    //   ),
                    // );
                  },
                  child: const Text(
                    'Resend code?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFB4B4B8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
