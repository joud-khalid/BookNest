import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/book.dart';

class FirestoreService {

  // 📚 Get the current user's books collection
  static CollectionReference get books {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("No user logged in");
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('books');
  }


  // ➕ Add a book for the current user
  static Future<void> addBook(Book book) async {
    await books.add(book.toMap());
  }


  // 📚 Get current user's books in real time
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


  // ✏️ Update a book
  static Future<void> updateBook(Book book) async {
    await books.doc(book.id).update(book.toMap());
  }


  // 🗑️ Delete a book
  static Future<void> deleteBook(String id) async {
    await books.doc(id).delete();
  }
}