import 'package:booknest/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'screens/welcome_screen.dart';
import 'themes/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async{
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
print("🔥 Firebase app name: ${Firebase.app().name}");
print("🔥 Firebase project: ${Firebase.app().options.projectId}");
FirebaseFirestore.instance.settings = const Settings(
  persistenceEnabled: false,
);

  runApp(const BookNest());
}

class BookNest extends StatelessWidget {
  const BookNest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BookNest',
      theme: AppTheme.lightTheme,
      home: const WelcomeScreen(),
    );
  }
}