import '../themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../widgets/custom_button.dart';


void main() {
  runApp(const BookNest());
}

class BookNest extends StatelessWidget {
  const BookNest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BookNest',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFFAF7F2),
        fontFamily: 'Arial',
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "📚",
                style: TextStyle(fontSize: 70),
              ),

              const SizedBox(height: 20),

              const Text(
                "BookNest",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.darkText,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Your personal reading companion",
                style: TextStyle(
                  fontSize: 18,
                  color: AppTheme.lightText,
                ),
              ),

              const SizedBox(height: 50),

              CustomButton(
  text: "Start Reading",
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
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