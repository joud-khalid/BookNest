class Book {
  final String id;
  final String title;
  final String author;
  final int totalPages;
  int currentPage;
  String status;

  Book({
    this.id = "",
    required this.title,
    required this.author,
    required this.totalPages,
    this.currentPage = 0,
    this.status = "Want To Read",
  });

  factory Book.fromMap(String id, Map<String, dynamic> data) {
    return Book(
      id: id,
      title: data['title'] ?? "",
      author: data['author'] ?? "",
      totalPages: data['totalPages'] ?? 0,
      currentPage: data['currentPage'] ?? 0,
      status: data['status'] ?? "Want To Read",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'totalPages': totalPages,
      'currentPage': currentPage,
      'status': status,
    };
  }
}