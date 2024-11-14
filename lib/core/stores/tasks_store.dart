import 'package:mobx/mobx.dart';
import 'package:todo_list_project/core/services/tasks_service.dart';
import 'package:uuid/uuid.dart';
import '../../features/task/models/task.dart';
import '../utils/task_filter.dart';

part 'tasks_store.g.dart';

class TaskStore = TaskStoreBase with _$TaskStore;

abstract class TaskStoreBase with Store {
  final TaskService _taskService;
  final TaskFilterController _filterController;
  final Uuid uuid = const Uuid();

  TaskStoreBase(this._taskService) : _filterController = TaskFilterController();

  @observable
  bool isLoading = false;
  @observable
  String currentFilter = "today";
  @observable
  bool taskMode = true;
  @observable
  bool isNextDay = false;
  @observable
  DateTime? startRangeDate;
  @observable
  DateTime? endRangeDate;

  @observable
  ObservableList<Task> tasks = ObservableList<Task>();

  @computed
  List<Task> get filteredTasks => ObservableList<Task>.of(
      _filterController.filterTasks(tasks.toList(), currentFilter,
          startRangeDate: startRangeDate, endRangeDate: endRangeDate));

  @action
  Future<void> loadTasks(String uid) async {
    isLoading = true;

    final allTasks = await _taskService.getTasks();
    tasks.clear();

    if (allTasks.isNotEmpty) {
      final tasksUser = allTasks.where((task) => task.userId == uid);

      tasks.addAll(tasksUser);
    }

    isLoading = false;
  }

  @action
  Future<void> addTask(String taskName, String description, String userId,
      bool isNextDay, DateTime scheduleDay) async {
    String id = uuid.v4();
    DateTime time = scheduleDay;

    if (isNextDay) {
      time = time.add(const Duration(days: 1));
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
  Future<void> updateIsNextDayStatus(bool? value) async {
    isNextDay = value!;
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
