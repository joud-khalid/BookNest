import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class LibraryStatCard extends StatelessWidget {
  final String icon;
  final String title;
  final String count;

  const LibraryStatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 10,
        ),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),

        child: Column(
          children: [
            Text(
              icon,
              style: const TextStyle(
                fontSize: 26,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.lightText,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              count,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}