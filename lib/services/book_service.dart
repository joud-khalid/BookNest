import '../models/book.dart';

class BookService {
  static final List<Book> _books = [
    Book(
      title: "The Hobbit",
      author: "J.R.R. Tolkien",
      totalPages: 310,
      currentPage: 120,
      status: "Reading",
      description: "",
    ),
  ];

  static List<Book> get books => _books;

  static void addBook(Book book) {
    _books.add(book);
  }

  static void removeBook(Book book) {
    _books.remove(book);
  }
}