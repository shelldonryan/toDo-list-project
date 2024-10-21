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

  @computed
  ObservableList<Task> get pendingTasks {
    return ObservableList<Task>.of(tasks.where((task) => task.isDone == false));
  }

  @computed
  ObservableList<Task> get finishedTasks {
    return ObservableList<Task>.of(tasks.where((task) => task.isDone == true));
  }

  @action
  Future<void> loadTasks(String uid, String filter) async {
    isLoading = true;

    final allTasks = await _taskService.getTasks();
    tasks.clear();

    if (allTasks.isNotEmpty) {
      final tasksUser = allTasks.where((task) => task.userId == uid);

      if (filter == "today") {
        final today = DateTime.now();
        final startDate = DateTime(today.year, today.month, today.day, 0, 0, 0);
        final endDate = DateTime(today.year, today.month, today.day, 23, 59, 59);

        final taskToday = tasksUser.where((task) => task.createdAt.isAfter(startDate) && task.createdAt.isBefore(endDate));

        tasks.addAll(taskToday);
      } else if (filter == "week") {

        final today = DateTime.now();
        var startFilter = today.subtract(Duration(days: today.weekday - 1));
        var endFilter = startFilter
            .add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));

        final taskWeek = tasksUser.where((task) =>
            task.createdAt
                .isAfter(startFilter.subtract(const Duration(days: 1))) &&
            task.createdAt.isBefore(endFilter.add(const Duration(seconds: 1))));
        tasks.addAll(taskWeek);
        
      } else if (filter == "month") {
        
        final today = DateTime.now();
        var startFilter = DateTime(today.year, today.month, 1);
        var endFilter = DateTime(today.year, today.month + 1, 1)
            .subtract(const Duration(seconds: 1));

        final taskMonth = tasksUser.where((task) =>
            task.createdAt
                .isAfter(startFilter.subtract(const Duration(seconds: 1))) &&
            task.createdAt.isBefore(endFilter.add(const Duration(seconds: 1))));

        tasks.addAll(taskMonth);
        
      } else if (filter == "all") {
        tasks.addAll(tasksUser);
      }
    }

    isLoading = false;
  }

  @action
  Future<void> addTask(
      String taskName, String description, String userId) async {
    String id = uuid.v4();
    DateTime time = DateTime.now();
    await _taskService.addTask(id, taskName, time, description, userId);

    tasks.add(Task(
        id: id,
        createdAt: time,
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
