import 'package:flutter/material.dart';
import '../services/google_books_service.dart';

class BookSearchScreen extends StatefulWidget {
  const BookSearchScreen({super.key});

  @override
  State<BookSearchScreen> createState() =>
      _BookSearchScreenState();
}

class _BookSearchScreenState
    extends State<BookSearchScreen> {
  final searchController = TextEditingController();

  List<Map<String, dynamic>> books = [];

  bool isLoading = false;

  Future<void> searchBooks() async {
    if (searchController.text.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    try {
      final results =
          await GoogleBooksService.searchBooks(
        searchController.text,
      );

      print("📚 Books found: ${results.length}");

setState(() {
  books = results;
});
    } catch (e) {
  print("❌ GOOGLE BOOKS ERROR: $e");

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Error: $e"),
    ),
  );
}

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Books"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: searchController,

              decoration: InputDecoration(
                hintText: "Search for a book...",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: searchBooks,
                ),
              ),
            ),

            const SizedBox(height: 20),

            if (isLoading)
              const CircularProgressIndicator(),

            Expanded(
              child: ListView.builder(
                itemCount: books.length,

                itemBuilder: (context, index) {
                  final book = books[index];

                  return ListTile(
                    leading:
                        book['cover'] != ""
                            ? Image.network(
                                book['cover'],
                                width: 50,
                              )
                            : const Icon(
                                Icons.menu_book,
                              ),

                    title: Text(book['title']),
                    subtitle: Text(book['author']),

                    onTap: () {
                      Navigator.pop(
                        context,
                        book,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}