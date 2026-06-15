import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/movie.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('movies.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE movies (
        id        INTEGER PRIMARY KEY AUTOINCREMENT,
        title     TEXT NOT NULL,
        imagePath TEXT NOT NULL,
        synopsis  TEXT NOT NULL,
        cast      TEXT NOT NULL,
        duration  TEXT NOT NULL,
        rating    TEXT NOT NULL,
        updatedAt INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
        'ALTER TABLE movies ADD COLUMN updatedAt INTEGER NOT NULL DEFAULT 0',
      );
    }
  }

  // ── CREATE ──
  Future<int> insertMovie(Movie movie) async {
    final db = await database;
    final map = movie.toMap();
    map['updatedAt'] = DateTime.now().millisecondsSinceEpoch;
    return await db.insert(
      'movies',
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ── READ ALL ──
  Future<List<Movie>> getAllMovies() async {
    final db = await database;
    final result = await db.query('movies', orderBy: 'updatedAt DESC');
    return result.map((map) => Movie.fromMap(map)).toList();
  }

  // ── READ ONE ──
  Future<Movie?> getMovie(int id) async {
    final db = await database;
    final maps = await db.query('movies', where: 'id = ?', whereArgs: [id]);
    if (maps.isEmpty) return null;
    return Movie.fromMap(maps.first);
  }

  // ── UPDATE ──
  Future<int> updateMovie(Movie movie) async {
    final db = await database;
    final map = movie.toMap();
    map['updatedAt'] = DateTime.now().millisecondsSinceEpoch;
    return await db.update(
      'movies',
      map,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  // ── DELETE ──
  Future<int> deleteMovie(int id) async {
    final db = await database;
    return await db.delete('movies', where: 'id = ?', whereArgs: [id]);
  }

  // ── SEED DATA ──
  Future<void> seedMoviesIfEmpty() async {
    final db = await database;
    final existing = await db.query('movies');
    if (existing.isNotEmpty) return; // already seeded

    final hardcodedMovies = [
      Movie(
          title: 'Gatotkaca',
          imagePath: 'assets/film/Gatotkaca.jpg',
          synopsis: 'Baru beberapa hari tinggal di apartemen...',
          cast: 'Rizky Nazar, Yuki Kato',
          duration: '119 minutes',
          rating: '13+'),
      Movie(
          title: 'Priest',
          imagePath: 'assets/film/priest.png',
          synopsis:
              'A priest lives in a dystopian world ruled by the church...',
          cast: 'Paul Bettany, Karl Urban',
          duration: '87 minutes',
          rating: '13+'),
      Movie(
          title: 'Peaky Blinders',
          imagePath: 'assets/film/peakblinders.png',
          synopsis: 'A gangster family epic set in 1900s England...',
          cast: 'Cillian Murphy, Tom Hardy',
          duration: '60 minutes',
          rating: '17+'),
      Movie(
          title: 'Gowok',
          imagePath: 'assets/film/Gowok.jpg',
          synopsis: 'Sinopsis Gowok...',
          cast: 'Pemeran Gowok',
          duration: '90 minutes',
          rating: '17+'),
      Movie(
          title: 'Bangkitnya Mayit',
          imagePath: 'assets/film/Bangkitnya mayit.jpg',
          synopsis: 'Film horor yang menegangkan...',
          cast: 'Pemeran film',
          duration: '100 minutes',
          rating: '17+'),
      Movie(
          title: 'Pangku',
          imagePath: 'assets/film/Pangku.jpg',
          synopsis: 'Sinopsis Pangku...',
          cast: 'Pemeran Pangku',
          duration: '90 minutes',
          rating: '17+'),
      Movie(
          title: 'Sosok Ketiga',
          imagePath: 'assets/film/Sosok ketiga.jpg',
          synopsis: 'Sinopsis Sosok Ketiga...',
          cast: 'Pemeran Sosok Ketiga',
          duration: '95 minutes',
          rating: '13+'),
      Movie(
          title: 'Syirik',
          imagePath: 'assets/film/Syirik.jpg',
          synopsis: 'Sinopsis Syirik...',
          cast: 'Pemeran Syirik',
          duration: '88 minutes',
          rating: '13+'),
      Movie(
          title: 'The Nun',
          imagePath: 'assets/film/The nun.jpg',
          synopsis:
              'A priest investigates the haunting of a Romanian monastery...',
          cast: 'Taissa Farmiga, Demián Bichir',
          duration: '96 minutes',
          rating: '17+'),
      Movie(
          title: 'The Conjuring',
          imagePath: 'assets/film/The conjuring.jpg',
          synopsis:
              'Paranormal investigators Ed and Lorraine Warren...',
          cast: 'Vera Farmiga, Patrick Wilson',
          duration: '112 minutes',
          rating: '17+'),
    ];

    for (final movie in hardcodedMovies) {
      final map = movie.toMap();
      map['updatedAt'] = DateTime.now().millisecondsSinceEpoch;
      await db.insert('movies', map);
    }
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}