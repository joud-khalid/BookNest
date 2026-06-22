import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String author;
  final String coverUrl;
  final int currentPage;
  final int totalPages;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;
  final VoidCallback onTap;

const BookCard({
  super.key,
  required this.title,
  required this.author,
  required this.coverUrl,
  required this.currentPage,
  required this.totalPages,
  required this.onDelete,
  required this.onUpdate,
  required this.onTap,
});

  @override
  Widget build(BuildContext context) {
    double progress =
    totalPages > 0 ? currentPage / totalPages : 0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
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
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

    // Book Cover
    ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: coverUrl.isNotEmpty
          ? Image.network(
              coverUrl,
              width: 80,
              height: 120,
              fit: BoxFit.cover,
            )
          : Container(
              width: 70,
              height: 100,
              color: Colors.grey.shade200,
              child: const Icon(
                Icons.menu_book,
                size: 40,
                color: Colors.grey,
              ),
            ),
    ),

    const SizedBox(width: 15),

    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.darkText,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            author,
            style: const TextStyle(
              fontSize: 16,
              color: AppTheme.lightText,
            ),
          ),
        ],
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
          

          const SizedBox(height: 15),

          Text(
            "Page $currentPage of $totalPages",
            style: const TextStyle(
              color: AppTheme.lightText,
            ),
          ),

          const SizedBox(height: 4),

Text(
  "${(progress * 100).toInt()}% completed",
  style: const TextStyle(
    color: AppTheme.primary,
    fontWeight: FontWeight.w600,
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
      ),
    );
  }
}
