class Book {
  final String title;
  final String author;

  Book({required this.title, required this.author});

  factory Book.fromJson(Map<String, dynamic> json) {
    final authors = json['author_name'] as List?;
    return Book(
      title: json['title'] ?? 'No Title',
      author: (authors != null && authors.isNotEmpty)
          ? authors.first.toString()
          : 'Unknown Author',
    );
  }
}
