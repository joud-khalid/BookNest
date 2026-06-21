import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import 'signup_screen.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "📚",
              style: TextStyle(fontSize: 60),
            ),

            const SizedBox(height: 20),

            const Text(
              "Welcome Back",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkText,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Continue your reading journey",
              style: TextStyle(
                fontSize: 16,
                color: AppTheme.lightText,
              ),
            ),

            const SizedBox(height: 40),

            const CustomTextField(
  hintText: "Email",
  icon: Icons.email_outlined,
),

            const SizedBox(height: 20),

            const CustomTextField(
  hintText: "Password",
  icon: Icons.lock_outline,
  obscureText: true,
),

            const SizedBox(height: 30),

            CustomButton(
  text: "Sign In",
  onPressed: () {},
),

const SizedBox(height: 20),

Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    const Text(
      "Don't have an account?",
      style: TextStyle(
        color: AppTheme.lightText,
      ),
    ),

    TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignupScreen(),
          ),
        );
      },
      child: const Text(
        "Create Account",
        style: TextStyle(
          color: AppTheme.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ],
),
          ],
        ),
      ),
    );
  }
}