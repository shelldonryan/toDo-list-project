
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  final String _userTableName = "users";
  final String _taskTableName = "tasks";

  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async{
    var databasePath = await getDatabasesPath();
    final dbPath = join(databasePath, 'todo_list.db');
    return await openDatabase(dbPath, version: 3, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future <void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_userTableName (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT,
        password TEXT NOT NULL,
        token TEXT,
        type TEXT NOT NULL DEFAULT 'support'
      )
    ''');
    await db.execute('''
      CREATE TABLE $_taskTableName (
        id TEXT PRIMARY KEY,
        taskName TEXT NOT NULL,
        createdAt INTEGER NOT NULL,
        description TEXT NOT NULL,
        isDone INTEGER NOT NULL,
        userId TEXT NOT NULL,
        FOREIGN KEY(userId) REFERENCES users(id)
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if ( oldVersion < 2) {
      await db.rawUpdate('''
        UPDATE $_userTableName
        SET type = 'developer'
        WHERE name = 'joao2222' AND type = 'support'
      ''');
    }

    if ( oldVersion < 3) {
      await db.rawDelete('''
        DELETE FROM $_userTableName
        WHERE name = 'shelldonryan'
      ''');
    }
  }
}