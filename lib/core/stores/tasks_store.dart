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

  ObservableList<Task> tasks = ObservableList<Task>();

  @action
  Future<void> loadTasks() async {
    isGetOneTime = true;
    final allTasks = await _db.getTasks();
    tasks.clear();
    tasks.addAll(allTasks);
  }

  @action
  Future<void> addTask(String taskName, String description) async {
    _db.addTask(taskName, description);

    tasks.add(Task(id: tasks.length + 1, taskName: taskName, isDone: 0, description: description));
  }

  @action
  Future<void> deleteTask(int id) async{
    _db.deleteTask(id);

    tasks.remove(tasks.firstWhere((task) => task.id == id));
  }

  @action
  Future<void> updateTaskStatus(Task task) async{
    _db.updateTaskStatus(task.id, task.isDone);

    int indexTaskSearch = tasks.indexOf(task);

    tasks[indexTaskSearch].isDone == 0 ? tasks[indexTaskSearch].isDone = 1: tasks[indexTaskSearch].isDone = 0;
  }

  @action
  Future<void> updateTask(Task task) async {
    _db.updateTask(task);

    Task taskToUpdate = tasks[tasks.indexOf(task)];

    if (taskToUpdate.taskName != task.taskName) {
      taskToUpdate.taskName = task.taskName;
    } else if (taskToUpdate.description != task.description) {
      taskToUpdate.description = task.description;
    }
  }

}