import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/book.dart';

class FirestoreService {
  static final CollectionReference books =
      FirebaseFirestore.instance.collection('books');

  // ➕ Add book
  static Future<void> addBook(Book book) async {
    await books.add(book.toMap());
  }

  // 📚 Get all books in real time
  static Stream<List<Book>> getBooks() {
    return books.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Book.fromMap(
          doc.id,
          doc.data() as Map<String, dynamic>,
        );
      }).toList();
    });
  }

  // ✏️ Update reading progress and status
  static Future<void> updateBook(Book book) async {
    await books.doc(book.id).update(book.toMap());
  }

  // 🗑️ Delete book
  static Future<void> deleteBook(String id) async {
    await books.doc(id).delete();
  }
}