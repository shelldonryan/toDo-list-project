import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {  
final String _tasksTableName = "tasks";
final String _usersTableName = "users";

  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();

  static Database? _db;
  
  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databasePath = join(await getDatabasesPath(), "todo_list.db");

    return await openDatabase(databasePath, version: 1, onCreate: _onCreate);
  }

  _onCreate(db, version) async {
    await db.execute('''
      CREATE TABLE $_usersTableName (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT,
        password TEXT NOT NULL,
        token TEXT,
        type TEXT NOT NULL DEFAULT 'support'
      )
    ''');
    await db.execute('''
      CREATE TABLE $_tasksTableName (
        id TEXT PRIMARY KEY,
        taskName TEXT NOT NULL,
        description TEXT NOT NULL,
        isDone INTEGER NOT NULL,
        userId TEXT NOT NULL,
        FOREIGN KEY(userId) REFERENCES users(id)
      )
    ''');
    await db.insert('''
      INSERT INTO $_usersTableName (id, name, password, type) VALUES ('shelduuidespecial', 'shelldonryan', 'shelldon1234', 'developer')
    ''');
  }
}