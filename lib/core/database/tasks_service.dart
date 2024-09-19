import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_list_project/features/task/models/index.dart';

class DatabaseService {
  final String _tasksTableName = "tasks";

  // Builder with private access
  DatabaseService._constructor();

  // Create a db instance
  static final DatabaseService instance = DatabaseService._constructor();

  //SQLite instance
  static Database? _db;


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
        id TEXT PRIMARY KEY,
        taskName TEXT NOT NULL,
        description TEXT NOT NULL,
        isDone INTEGER NOT NULL
      )
    ''');
  }

  Future<List<Task>> getTasks() async {
    final db = await database;

    final data = await db.query(_tasksTableName);

    List<Task> tasks = data
        .map((taskObj) => Task(
            id: taskObj["id"] as String,
            taskName: taskObj["taskName"] as String,
            description: taskObj["description"] as String,
            isDone: taskObj["isDone"] == 1 ? true : false))
        .toList();

    return tasks;
  }

  Future<bool> addTask(String id, String taskName, String description) async {
    final db = await database;

    await db.insert(_tasksTableName, {
      "id": id,
      "taskName": taskName,
      "description": description,
      "isDone": 0,
    });
    
    return true;
  }

  Future<bool> updateTaskStatus(String id, bool isDone) async {
    final db = await database;

    await db.update(
      _tasksTableName,
      {
        "isDone": isDone == true ? 1 : 0,
      },
      where: "id = ?",
      whereArgs: [
        id,
      ],
    );

    return true;
  }

  Future<bool> updateTask(String id, String taskName, String description) async {
    final db = await database;

    await db.update(
        _tasksTableName,
        {
          "taskName": taskName,
          "description": description,
        },
        where: "id = ?",
        whereArgs: [
          id,
        ]);

    return true;
  }

  Future<void> deleteTask(String id) async {
    final db = await database;
    await db.delete(_tasksTableName, where: "id = ?", whereArgs: [id]);
  }
}
