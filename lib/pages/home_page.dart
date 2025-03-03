import 'package:book_finder/auth/database_helper.dart';
import 'package:book_finder/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/bookModel.dart';
import '../theme/theme_manager.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key,});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State <HomePage> {
  final ApiService _apiService = ApiService();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  List<Book> _books = [];
  bool _isLoading = false;

  void _searchBooks(String query) async {
    setState(()=> _isLoading = true);
    try{
      final results = await _apiService.searchBooks(query);
      setState(() {
        _books = results.map((json) => Book.fromJson(json)).toList();
      });
    }catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error fetching books")),
          );
    } finally {
      setState(() => _isLoading = false);
    }
  }


  @override
  Widget build(BuildContext context){
    Provider.of<ThemeManager>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Book Finder'),
          actions: [
            IconButton(
              onPressed: (){
                Provider.of<ThemeManager>(context, listen: false).toggleTheme();
              }, icon: const Icon(Icons.brightness_6),
            )
          ],
        ),
        body: Column(
          children: [
            Padding(padding: EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _searchBooks,
              decoration: InputDecoration(
                hintText: 'Search for a book',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            ),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: _books.length,
                itemBuilder: (context, index) {
                  final book = _books[index];
                  return ListTile(
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: buildBookThumbnail(book.thumbnailUrl),
                    ),
                    title: Text(book.title),
                    subtitle: Text(book.author),
                    trailing: IconButton(
                      icon: Icon(Icons.favorite_border),
                      onPressed: () => _databaseHelper.addFavorite(book),
                    ),
                  );
                },
              ),
            ),
          ],
        )
    );
  }

  Widget buildBookThumbnail(String? thumbnailUrl) {
    if (thumbnailUrl != null && thumbnailUrl.isNotEmpty) {
      return Image.network(
        thumbnailUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.broken_image); // Fallback for failed images
        },
      );
    } else {
      return Icon(Icons.image_not_supported); // Placeholder for missing images
    }
  }

}