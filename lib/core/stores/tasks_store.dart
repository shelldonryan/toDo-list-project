import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';
import '../database/tasks_service.dart';
import '../../features/task/models/index.dart';

part 'tasks_store.g.dart';

class TaskStore = _TaskStoreBase with _$TaskStore;

abstract class _TaskStoreBase with Store {
  final DatabaseService _db;
  final Uuid uuid = const Uuid();

  _TaskStoreBase(this._db);

  @observable
  bool isGetOneTime = false;

  @observable
  ObservableList<Task> tasks = ObservableList<Task>();

  @action
  Future<void> loadTasks() async {
    isGetOneTime = true;
    final allTasks = await _db.getTasks();
    tasks.clear();

    if (allTasks.isNotEmpty) {
      tasks.addAll(allTasks);
    }
  }

  @action
  Future<void> addTask(String taskName, String description) async {
    String id = uuid.v4();
    await _db.addTask(id, taskName, description);

    tasks.add(Task(
        id: id,
        taskName: taskName,
        isDone: false,
        description: description));
  }

  @action
  Future<void> deleteTask(String id) async {
    await _db.deleteTask(id);

    tasks.remove(tasks.firstWhere((task) => task.id == id));
  }

  @action
  Future<void> updateTaskStatus(String id, bool isDone) async {
    await _db.updateTaskStatus(id, isDone);

    

    Task taskToUpdate = tasks.firstWhere((task) => task.id == id);
    taskToUpdate.isDone = isDone;
  }

  @action
  Future<void> updateTask(
      String id, String taskName, String taskDescription) async {
    await _db.updateTask(id, taskName, taskDescription);

    int indexTaskUpdate = tasks.indexWhere((task) => task.id == id);

    tasks[indexTaskUpdate].taskName = taskName;
    tasks[indexTaskUpdate].description = taskDescription;
  }
}
