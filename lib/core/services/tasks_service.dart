import 'package:sqflite/sqflite.dart';
import 'package:todo_list_project/core/database/db.dart';
import 'package:todo_list_project/features/task/models/index.dart';

class TaskService {
  final String _tasksTableName = "tasks";
  final DatabaseService dbService = DatabaseService.instance;

  Future<Database> get database async {
    return await dbService.database;
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
