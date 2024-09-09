import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_list_project/models/task.dart';

class DatabaseService {
  // Builder with private access
  DatabaseService._constructor();

  // Create a db instance
  static final DatabaseService instance = DatabaseService._constructor();

  //SQLite instance
  static Database? _db;

  final String _tasksTableName = "tasks";

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "todo_list.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _onCreate,
    );
    return database;
  }

  _onCreate(db, version) async {
    await db.execute('''
      CREATE TABLE $_tasksTableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        taskName TEXT NOT NULL,
        description TEXT NOT NULL,
        isDone INTEGER NOT NULL
      )
    ''');
  }

  Future<bool> addTask(String taskName) async {
    final db = await database;

    await db.insert(_tasksTableName, {
      "taskName": taskName,
      "isDone": 0,
    });

    return true;
  }

  Future<List<Task>> getTasks() async {
    final db = await database;

    final data = await db.query(_tasksTableName);

    List<Task> tasks = data
        .map((taskObj) => Task(
            id: taskObj["id"] as int,
            taskName: taskObj["taskName"] as String,
            description: taskObj["description"] as String,
            isDone: taskObj["isDone"] as int))
        .toList();

    return tasks;
  }

  Future<bool> updateTaskStatus(int id, int isDone) async {
    final db = await database;

    await db.update(
      _tasksTableName,
      {
        "isDone": isDone == 0 ? 1 : 0,
      },
      where: "id = ?",
      whereArgs: [
        id,
      ],
    );

    return true;
  }

  void deleteTask(int id) async {
    final db = await database;
    await db.delete(_tasksTableName, where: "id = ?", whereArgs: [id]);
  }

}
