import 'package:mobx/mobx.dart';
import 'package:todo_list_project/core/services/tasks_service.dart';
import 'package:uuid/uuid.dart';
import '../../features/task/models/task.dart';

part 'tasks_store.g.dart';

class TaskStore = TaskStoreBase with _$TaskStore;

abstract class TaskStoreBase with Store {
  final TaskService _taskService;
  final Uuid uuid = const Uuid();

  TaskStoreBase(this._taskService);

  @observable
  bool isLoading = false;

  @observable
  ObservableList<Task> tasks = ObservableList<Task>();

  @action
  Future<void> loadTasks() async {
    isLoading = true;

    final allTasks = await _taskService.getTasks();
    tasks.clear();

    if (allTasks.isNotEmpty) {
      tasks.addAll(allTasks);
    }

    isLoading = false;
  }

  @action
  Future<void> addTask(
      String taskName, String description, String userId) async {
    String id = uuid.v4();
    await _taskService.addTask(id, taskName, description, userId);

    tasks.add(Task(
        id: id,
        taskName: taskName,
        isDone: false,
        description: description,
        userId: userId));
  }

  @action
  Future<void> deleteTask(String id) async {
    await _taskService.deleteTask(id);

    tasks.remove(tasks.firstWhere((task) => task.id == id));
  }

  @action
  Future<void> updateTaskStatus(String id, bool isDone) async {
    await _taskService.updateTaskStatus(id, isDone);

    isLoading = true;

    int taskIndex = tasks.indexWhere((task) => task.id == id);

    Task taskToUpdate = tasks.firstWhere((task) => task.id == id);
    taskToUpdate.isDone = isDone;

    tasks[taskIndex] = taskToUpdate;

    isLoading = false;
  }

  @action
  Future<void> updateTask(
      String id, String taskName, String taskDescription) async {
    await _taskService.updateTask(id, taskName, taskDescription);

    isLoading = true;

    Task taskUpdate = tasks.firstWhere((task) => task.id == id);

    taskUpdate.taskName = taskName;
    taskUpdate.description = taskDescription;

    isLoading = false;
  }
}
