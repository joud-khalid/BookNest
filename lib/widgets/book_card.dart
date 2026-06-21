import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String author;
  final int currentPage;
  final int totalPages;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;

const BookCard({
  super.key,
  required this.title,
  required this.author,
  required this.currentPage,
  required this.totalPages,
  required this.onDelete,
  required this.onUpdate,
});

  @override
  Widget build(BuildContext context) {
    double progress = currentPage / totalPages;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      "📖 $title",
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppTheme.darkText,
      ),
    ),

    IconButton(
      onPressed: onDelete,
      icon: const Icon(
        Icons.delete_outline,
        color: Colors.red,
      ),
    ),
  ],
),
          const SizedBox(height: 5),

          Text(
            author,
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.lightText,
            ),
          ),

          const SizedBox(height: 15),

          Text(
            "Page $currentPage of $totalPages",
            style: const TextStyle(
              color: AppTheme.lightText,
            ),
          ),

          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: AppTheme.background,
              valueColor: const AlwaysStoppedAnimation(
                AppTheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 12),

TextButton.icon(
  onPressed: onUpdate,
  icon: const Icon(
    Icons.edit,
    color: AppTheme.primary,
  ),
  label: const Text(
    "Update Progress",
    style: TextStyle(
      color: AppTheme.primary,
      fontWeight: FontWeight.bold,
    ),
  ),
),
        ],
      ),
    );
  }
}
