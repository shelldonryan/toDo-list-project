import 'package:mobx/mobx.dart';
import '../database/tasks_service.dart';
import '../../features/task/models/index.dart';

part 'tasks_store.g.dart';

class TaskStore = _TaskStoreBase with _$TaskStore;

abstract class _TaskStoreBase with Store {
  final DatabaseService _db;

  _TaskStoreBase(this._db);

  @observable
  bool isGetOneTime = false;

  @observable
  List<Task> tasks = [];

  @action
  Future<void> loadTasks() async {
    isGetOneTime = true;
    final allTasks = await _db.getTasks();
    tasks.clear();
    tasks.addAll(allTasks);
  }

  @action
  Future<void> addTask(String taskName, String description) async {
    await _db.addTask(taskName, description);

    tasks.add(Task(id: tasks.length + 1, taskName: taskName, isDone: 0, description: description));
  }

  @action
  Future<void> deleteTask(int id) async{
    await _db.deleteTask(id);

    tasks.remove(tasks.firstWhere((task) => task.id == id));
  }

  @action
  Future<void> updateTaskStatus(int id, int isDone) async{
    await _db.updateTaskStatus(id, isDone);

    int indexTaskUpdate = tasks.indexWhere((task) => task.id == id);
    tasks[indexTaskUpdate].isDone = isDone == 0 ? 1 : 0;
  }

  @action
  Future<void> updateTask(int id, String taskName, String taskDescription) async {
    await _db.updateTask(id, taskName, taskDescription);

    int indexTaskUpdate = tasks.indexWhere((task) => task.id == id);

    tasks[indexTaskUpdate].taskName = taskName;
    tasks[indexTaskUpdate].description = taskDescription;
  }

}