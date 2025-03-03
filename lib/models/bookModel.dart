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
    final imageLinks = volumeInfo['imageLinks'];

    String? thumbnailUrl;
    if (imageLinks != null && imageLinks['thumbnail'] != null) {
      String url = imageLinks['thumbnail'].toString();
      // Replace 'http' with 'https' to force secure connection
      url = url.replaceFirst(RegExp(r'^http:'), 'https:');
      // Optional: Remove any problematic query parameters (e.g., 'edge=curl')
      url = url.replaceAll(RegExp(r'&edge=curl'), '');
      if (url.isNotEmpty) {
        thumbnailUrl = url;
      }
    }
print('Thumbnail URL: $thumbnailUrl');
    return Book(
      id: json['id'],
      title: volumeInfo['title'] ?? 'No Title',
      author: (volumeInfo['authors'] != null && volumeInfo['authors'].isNotEmpty)
          ? volumeInfo['authors'][0]
          : 'Unknown Author',
      thumbnailUrl: thumbnailUrl,
    );
  }
}