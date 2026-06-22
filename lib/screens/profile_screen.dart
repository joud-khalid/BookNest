import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatelessWidget {
  final int totalBooks;
  final int finishedBooks;
  final int readingBooks;
  final int wantToReadBooks;
  final int yearlyGoal;

  const ProfileScreen({
    super.key,
    required this.totalBooks,
    required this.finishedBooks,
    required this.readingBooks,
    required this.wantToReadBooks,
    required this.yearlyGoal,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F4EF),

      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: const Color(0xFFF8F4EF),
        elevation: 0,
      ),

      body: FutureBuilder<DocumentSnapshot>(
  future: FirebaseFirestore.instance
      .collection('users')
      .doc(user!.uid)
      .get(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final data =
        snapshot.data!.data()
            as Map<String, dynamic>;

    final String userName =
        data['name'] ?? 'Reader';

    return Padding(
      padding: const EdgeInsets.all(24),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [

          Center(
            child: CircleAvatar(
              radius: 45,
              backgroundColor:
                  const Color(0xFF6B4F4F),
              child: Text(
                userName[0].toUpperCase(),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight:
                      FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Center(
            child: Text(
              userName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),

          Center(
            child: Text(
              user.email ?? "",
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),

          const SizedBox(height: 40),

          Text("📚 Total Books: $totalBooks"),
          const SizedBox(height: 10),

          Text("⭐ Finished: $finishedBooks"),
          const SizedBox(height: 10),

          Text("📖 Reading: $readingBooks"),
          const SizedBox(height: 10),

          Text("🔖 Want To Read: $wantToReadBooks"),

          const SizedBox(height: 30),

          const Text(
            "🎯 Goal Progress",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "$finishedBooks / $yearlyGoal books",
          ),

          const Spacer(),

          SizedBox(
            width: double.infinity,

            child: ElevatedButton(
              onPressed: () async {
                await AuthService.logout();
              },

              child: const Text(
                "Logout",
              ),
            ),
          ),
        ],
      ),
    );
  },
),
    );
  }
}