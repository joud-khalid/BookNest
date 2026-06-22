import 'package:flutter/material.dart';

import '../themes/app_theme.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

import '../services/auth_service.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signup() async {
    try {
      setState(() {
        isLoading = true;
      });

      final userCredential =
    await AuthService.signUp(
  emailController.text.trim(),
  passwordController.text.trim(),
);

await FirebaseFirestore.instance
    .collection('users')
    .doc(userCredential.user!.uid)
    .set({
  'name': nameController.text.trim(),
  'email': emailController.text.trim(),
});
      
      if (!mounted) return;

      Navigator.of(context).popUntil((route) => route.isFirst);

    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),

        child: SingleChildScrollView(
          child: Column(
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

              const SizedBox(height: 40),

              CustomTextField(
                controller: nameController,
                hintText: "Name",
                icon: Icons.person_outline,
              ),

              const SizedBox(height: 20),

              CustomTextField(
                controller: emailController,
                hintText: "Email",
                icon: Icons.email_outlined,
              ),

              const SizedBox(height: 20),

              CustomTextField(
                controller: passwordController,
                hintText: "Password",
                icon: Icons.lock_outline,
                obscureText: true,
              ),

              const SizedBox(height: 30),

              isLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      text: "Create Account",
                      onPressed: signup,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}