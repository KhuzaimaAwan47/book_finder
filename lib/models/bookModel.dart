class Book {
  final String id;
  final String title;
  final String author;
  final String? thumbnailUrl;

  Book({
    required this.id,
    required this.title,
    required this.author,
    this.thumbnailUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'];
    return Book(
      id: json['id'],
      title: volumeInfo['title'] ?? 'No Title',
      author: (volumeInfo['authors'] != null && volumeInfo['authors'].isNotEmpty)
          ? volumeInfo['authors'][0]
          : 'Unknown Author',
      thumbnailUrl: volumeInfo['imageLinks']?['thumbnail'],
    );
  }
}