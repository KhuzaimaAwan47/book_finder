import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/bookModel.dart';
import '../models/userModel.dart';

class DatabaseHelper {
  final databaseName = "books.db";

  String users =
      "create table users (userId INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT UNIQUE , password TEXT, email TEXT)";

  String books =
      "create table favorites(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT, author TEXT, thumbnailUrl TEXT)";

Future<Database> initDB() async{
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, databaseName);
  return openDatabase(
      path, version: 1,
      onCreate: (db, version) {
    db.execute(users);
    db.execute(books);
  });
}


//LoginFunction
  Future<bool> login(Users user) async {
    final Database db = await DatabaseHelper().initDB();

    var result = await db.rawQuery(
        "select * from users where username = '${user.email}' and password = '${user.password}");
    if(result.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }

//SignUp Function
  Future<int> signUp(Users user) async {
    final Database db = await DatabaseHelper().initDB();

    return db.insert('users', user.toMap());

  }

  //Add Favorite Function
  Future<void> addFavorite(Book book) async {
    final Database db = await initDB();
    await db.insert(
      'favorites',
      {
        'id': book.id,
        'title': book.title,
        'author': book.author,
        'thumbnailUrl': book.thumbnailUrl,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// Remove Favorite Function.
  Future<void> removeFavorite(int id) async {
    final Database db = await initDB();
    await db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Get Favorites Function.
  Future<List<Book>> getFavorites() async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return List.generate(maps.length, (index) {
      return Book(
        id: maps[index]['id'],
        title: maps[index]['title'],
        author: maps[index]['author'],
        thumbnailUrl: maps[index]['thumbnailUrl'],
      );
    });
  }

}

