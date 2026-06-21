import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';
import 'home_screen.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),

              const Text(
                "📚",
                style: TextStyle(fontSize: 60),
              ),

              const SizedBox(height: 20),

              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkText,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Start your reading journey",
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.lightText,
                ),
              ),

              const SizedBox(height: 40),

              const CustomTextField(
  hintText: "Name",
  icon: Icons.person_outline,
),

              const SizedBox(height: 20),

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
  text: "Create Account",
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  },
),
            ],
          ),
        ),
      ),
    );
  }
}