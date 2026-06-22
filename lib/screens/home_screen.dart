import 'package:flutter/material.dart';
import '../widgets/book_card.dart';
import '../widgets/library_stat_card.dart';
import 'add_book_screen.dart';
import '../services/firestore_service.dart';
import '../services/auth_service.dart';
import '../models/book.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Book>>(
      stream: FirestoreService.getBooks(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final books = snapshot.data!;

        final int finishedBooks =
            books.where((book) => book.status == "Finished").length;

        final int readingBooks =
            books.where((book) => book.status == "Reading").length;

        final int wantToReadBooks =
            books.where((book) => book.status == "Want To Read").length;

        const int yearlyGoal = 30;
        final double progress = finishedBooks / yearlyGoal;

        return Scaffold(
          backgroundColor: const Color(0xFFF8F4EF),

          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddBookScreen(),
                ),
              );
            },
            backgroundColor: const Color(0xFF6B4F4F),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            label: const Text(
              "Add Book",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,

                      children: [

                        const Text(
                          "📚 BookNest",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6B4F4F),
                          ),
                        ),

                        IconButton(
                          icon: const Icon(
                            Icons.logout,
                            color: Color(0xFF6B4F4F),
                          ),

                          onPressed: () async {
                            await AuthService.logout();
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Hello, Joud 👋",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const Text(
                      "What are you reading today?",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),

                    const SizedBox(height: 35),

                    const Text(
                      "Currently Reading",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Column(
                      children: books
                          .where(
                            (book) =>
                                book.status == "Reading",
                          )

                          .map(
                            (book) => BookCard(
                              title: book.title,
                              author: book.author,
                              currentPage: book.currentPage,
                              totalPages: book.totalPages,

                              onDelete: () async {
                                await FirestoreService
                                    .deleteBook(book.id);
                              },

                              onUpdate: () {
                                final pageController =
                                    TextEditingController();

                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                        "Update Progress",
                                      ),

                                      content: TextField(
                                        controller:
                                            pageController,
                                        keyboardType:
                                            TextInputType.number,

                                        decoration:
                                            const InputDecoration(
                                          hintText:
                                              "Enter current page",
                                        ),
                                      ),
                                                                            actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel"),
                                        ),

                                        TextButton(
                                          onPressed: () async {
                                            book.currentPage =
                                                int.tryParse(
                                                      pageController.text,
                                                    ) ??
                                                    book.currentPage;

                                            if (book.currentPage >=
                                                book.totalPages) {
                                              book.currentPage =
                                                  book.totalPages;
                                              book.status = "Finished";
                                            } else if (book.currentPage > 0) {
                                              book.status = "Reading";
                                            }

                                            await FirestoreService
                                                .updateBook(book);

                                            Navigator.pop(context);
                                          },
                                          child: const Text("Save"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          )
                          .toList(),
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      "My Library",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [
                        LibraryStatCard(
                          icon: "📖",
                          title: "Reading",
                          count: readingBooks.toString(),
                        ),

                        LibraryStatCard(
                          icon: "⭐",
                          title: "Finished",
                          count: finishedBooks.toString(),
                        ),

                        LibraryStatCard(
                          icon: "🔖",
                          title: "Want To Read",
                          count: wantToReadBooks.toString(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    const Text(
                      "🎯 2026 Reading Goal",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Container(
                      width: double.infinity,
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
                          Text(
                            "$finishedBooks / $yearlyGoal books",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 10),

                          ClipRRect(
                            borderRadius:
                                BorderRadius.circular(10),

                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 8,
                            ),
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            "Keep going! You are doing amazing 🤎",
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}