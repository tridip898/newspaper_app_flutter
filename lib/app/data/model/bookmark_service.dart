import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../pojo/news_api_response_model.dart';

class BookmarkDatabase {
  static final BookmarkDatabase instance = BookmarkDatabase._init();
  static Database? _database;

  BookmarkDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bookmarks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bookmarks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        author TEXT,
        title TEXT,
        description TEXT,
        url TEXT,
        urlToImage TEXT,
        publishedAt TEXT,
        content TEXT,
        sourceId TEXT,
        sourceName TEXT
      )
    ''');
  }

  Future<void> insertBookmark(Articles article) async {
    final db = await instance.database;

    await db.insert(
      'bookmarks',
      {
        'author': article.author,
        'title': article.title,
        'description': article.description,
        'url': article.url,
        'urlToImage': article.urlToImage,
        'publishedAt': article.publishedAt,
        'content': article.content,
        'sourceId': article.source?.id,
        'sourceName': article.source?.name,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Articles>> getBookmarks() async {
    final db = await instance.database;

    final result = await db.query('bookmarks');

    return result
        .map((json) => Articles(
              author: json['author'] as String?,
              title: json['title'] as String?,
              description: json['description'] as String?,
              url: json['url'] as String?,
              urlToImage: json['urlToImage'] as String?,
              publishedAt: json['publishedAt'] as String?,
              content: json['content'] as String?,
              source: Source(
                id: json['sourceId'] as String?,
                name: json['sourceName'] as String?,
              ),
            ))
        .toList();
  }

  Future<void> deleteBookmark(String url) async {
    final db = await instance.database;

    await db.delete(
      'bookmarks',
      where: 'url = ?',
      whereArgs: [url],
    );
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
