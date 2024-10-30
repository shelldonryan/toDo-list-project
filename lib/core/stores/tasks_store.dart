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
  String currentFilter = "today";
  @observable
  bool isTomorrow = false;

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
  Future<void> loadTasks(String uid, String filter, DateTime? startRange, DateTime? endRange) async {
    isLoading = true;

    final allTasks = await _taskService.getTasks();
    tasks.clear();

    if (allTasks.isNotEmpty) {
      final tasksUser = allTasks.where((task) => task.userId == uid);

      if (filter == "today") {
        DateTime today = DateTime.now();
        DateTime startDate = DateTime(today.year, today.month, today.day, 0, 0, 0);
        DateTime endDate =
            DateTime(today.year, today.month, today.day, 23, 59, 59);

        final taskToday = tasksUser.where((task) =>
            task.createdAt.isAfter(startDate) &&
            task.createdAt.isBefore(endDate));

        tasks.addAll(taskToday);
      } else if (filter == "tomorrow") {
        DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
        DateTime startDate =
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 0, 0, 0);
        DateTime endDate =
            DateTime(tomorrow.year, tomorrow.month, tomorrow.day, 23, 59, 59);

        final taskTomorrow = tasksUser.where((task) =>
            task.createdAt.isAfter(startDate) &&
            task.createdAt.isBefore(endDate));

        tasks.addAll(taskTomorrow);
      } else if (filter == "week") {
        DateTime today = DateTime.now();
        DateTime startFilter = DateTime(today.year, today.month, today.day, 0, 0, 0);
        DateTime endFilter = today
            .add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));

        final taskWeek = tasksUser.where((task) =>
            task.createdAt.isAfter(startFilter) &&
            task.createdAt.isBefore(endFilter.add(const Duration(seconds: 1))));
        tasks.addAll(taskWeek);
      } else if (filter == "month") {
        DateTime today = DateTime.now();
        DateTime startFilter = DateTime(today.year, today.month, 1);
        DateTime endFilter = DateTime(today.year, today.month + 1, 1)
            .subtract(const Duration(seconds: 1));

        final taskMonth = tasksUser.where((task) =>
            task.createdAt.isAfter(startFilter) &&
            task.createdAt.isBefore(endFilter.subtract(const Duration(seconds: 1))));

        tasks.addAll(taskMonth);
      } else if (filter == "all") {
        tasks.addAll(tasksUser);
      } else if (filter == "custom") {
        DateTime today = DateTime.now();
        DateTime startFilter = startRange!;
        DateTime endFilter = endRange!;

        final taskCustom = tasksUser.where((task) =>
        task.createdAt.isAfter(startFilter) &&
            task.createdAt.isBefore(endFilter.subtract(const Duration(seconds: 1))));

        tasks.addAll(taskCustom);
      }
    }

    isLoading = false;
  }

  @action
  Future<void> addTask(String taskName, String description, String userId, bool isTomorrow) async {
    String id = uuid.v4();
    DateTime time = DateTime.now();

    if (isTomorrow) {
      time = DateTime.now().add(const Duration(days: 1));
    }

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
  Future<void> updateIsTomorrowStatus(bool? value) async {
    isTomorrow = value!;
  }

  @action
  Future<void> updateTask(String id, String taskName, String taskDescription) async {
    await _taskService.updateTask(id, taskName, taskDescription);

    isLoading = true;

    Task taskUpdate = tasks.firstWhere((task) => task.id == id);

    taskUpdate.taskName = taskName;
    taskUpdate.description = taskDescription;

    isLoading = false;
  }
}
