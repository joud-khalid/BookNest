import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/firestore_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController pagesController = TextEditingController();
  final coverController = TextEditingController();

  String selectedStatus = "Want To Read";
  
  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    pagesController.dispose();
    super.dispose();
    coverController.dispose();
  }

Future<void> saveBook() async {
  try {
    print("🔥 Save button pressed");

    if (titleController.text.isEmpty ||
        authorController.text.isEmpty ||
        pagesController.text.isEmpty) {
      print("⚠️ Empty fields");
      return;
    }

    Book newBook = Book(
      title: titleController.text,
      author: authorController.text,
      totalPages: int.tryParse(pagesController.text) ?? 0,
      status: selectedStatus,
      coverUrl: coverController.text.trim(),
    );

    print("📚 Book created");

    await FirestoreService.addBook(newBook);

    print("☁️ Saved to Firestore");

    Navigator.pop(context);

  } catch (e) {
    print("❌ Firebase Error: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F4EF),

      appBar: AppBar(
        title: const Text("Add New Book"),
        backgroundColor: const Color(0xFFF8F4EF),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "📚 Add a Book",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B4F4F),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Start building your personal library ✨",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 30),

            CustomTextField(
              controller: titleController,
              hintText: "Book Title",
              icon: Icons.menu_book,
            ),

            const SizedBox(height: 16),

            CustomTextField(
              controller: authorController,
              hintText: "Author",
              icon: Icons.person,
            ),
            
            const SizedBox(height: 16),


            CustomTextField(
              controller: coverController,
              hintText: "Cover Image URL",
              icon: Icons.image_outlined,
            ),

            const SizedBox(height: 16),

            CustomTextField(
              controller: pagesController,
              hintText: "Total Pages",
              icon: Icons.numbers,
            ),

const SizedBox(height: 16),

Container(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(15),
  ),

  child: DropdownButtonFormField<String>(
    value: selectedStatus,
    decoration: const InputDecoration(
      border: InputBorder.none,
      prefixIcon: Icon(
        Icons.menu_book,
        color: Color(0xFF6B4F4F),
      ),
    ),

    items: const [
      DropdownMenuItem(
        value: "Reading",
        child: Text("📖 Reading"),
      ),

      DropdownMenuItem(
        value: "Finished",
        child: Text("⭐ Finished"),
      ),

      DropdownMenuItem(
        value: "Want To Read",
        child: Text("🔖 Want To Read"),
      ),
    ],

    onChanged: (value) {
      setState(() {
        selectedStatus = value!;
      });
    },
  ),
),

const SizedBox(height: 40),

CustomButton(
  text: "Save Book",
  onPressed: saveBook,
),          ],
        ),
      ),
    );
  }
}