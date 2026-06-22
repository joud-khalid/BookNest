import 'package:flutter/material.dart';
import '../models/book.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book book;

  const BookDetailsScreen({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    final double progress =
        book.totalPages > 0
            ? book.currentPage / book.totalPages
            : 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F4EF),

      appBar: AppBar(
        title: const Text("Book Details"),
        backgroundColor: const Color(0xFFF8F4EF),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center,

          children: [

            Center(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(16),

                child: book.coverUrl.isNotEmpty
                    ? Image.network(
                        book.coverUrl,
                        width: 180,
                        height: 260,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 180,
                        height: 260,
                        color: Colors.grey.shade300,
                        child: const Icon(
                          Icons.menu_book,
                          size: 80,
                        ),
                      ),
              ),
            ),

            const SizedBox(height: 25),

            Text(
              book.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              book.author,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(20),
              ),

              child: Column(
                children: [

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Pages"),
                      Text(
                        "${book.totalPages}",
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Current Page"),
                      Text(
                        "${book.currentPage}",
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Status"),
                      Text(book.status),
                    ],
                  ),

                  const SizedBox(height: 20),

                  LinearProgressIndicator(
                    value: progress,
                    minHeight: 10,
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "${(progress * 100).toInt()}% completed",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}