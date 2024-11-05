// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TaskStore on TaskStoreBase, Store {
  Computed<List<Task>>? _$filteredTasksComputed;

  @override
  List<Task> get filteredTasks => (_$filteredTasksComputed ??=
          Computed<List<Task>>(() => super.filteredTasks,
              name: 'TaskStoreBase.filteredTasks'))
      .value;

  late final _$isLoadingAtom =
      Atom(name: 'TaskStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$currentFilterAtom =
      Atom(name: 'TaskStoreBase.currentFilter', context: context);

  @override
  String get currentFilter {
    _$currentFilterAtom.reportRead();
    return super.currentFilter;
  }

  @override
  set currentFilter(String value) {
    _$currentFilterAtom.reportWrite(value, super.currentFilter, () {
      super.currentFilter = value;
    });
  }

  late final _$taskModeAtom =
      Atom(name: 'TaskStoreBase.taskMode', context: context);

  @override
  bool get taskMode {
    _$taskModeAtom.reportRead();
    return super.taskMode;
  }

  @override
  set taskMode(bool value) {
    _$taskModeAtom.reportWrite(value, super.taskMode, () {
      super.taskMode = value;
    });
  }

  late final _$isNextDayAtom =
      Atom(name: 'TaskStoreBase.isNextDay', context: context);

  @override
  bool get isNextDay {
    _$isNextDayAtom.reportRead();
    return super.isNextDay;
  }

  @override
  set isNextDay(bool value) {
    _$isNextDayAtom.reportWrite(value, super.isNextDay, () {
      super.isNextDay = value;
    });
  }

  late final _$startRangeDateAtom =
      Atom(name: 'TaskStoreBase.startRangeDate', context: context);

  @override
  DateTime? get startRangeDate {
    _$startRangeDateAtom.reportRead();
    return super.startRangeDate;
  }

  @override
  set startRangeDate(DateTime? value) {
    _$startRangeDateAtom.reportWrite(value, super.startRangeDate, () {
      super.startRangeDate = value;
    });
  }

  late final _$endRangeDateAtom =
      Atom(name: 'TaskStoreBase.endRangeDate', context: context);

  @override
  DateTime? get endRangeDate {
    _$endRangeDateAtom.reportRead();
    return super.endRangeDate;
  }

  @override
  set endRangeDate(DateTime? value) {
    _$endRangeDateAtom.reportWrite(value, super.endRangeDate, () {
      super.endRangeDate = value;
    });
  }

  late final _$tasksAtom = Atom(name: 'TaskStoreBase.tasks', context: context);

  @override
  ObservableList<Task> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(ObservableList<Task> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  late final _$loadTasksAsyncAction =
      AsyncAction('TaskStoreBase.loadTasks', context: context);

  @override
  Future<void> loadTasks(String uid) {
    return _$loadTasksAsyncAction.run(() => super.loadTasks(uid));
  }

  late final _$addTaskAsyncAction =
      AsyncAction('TaskStoreBase.addTask', context: context);

  @override
  Future<void> addTask(String taskName, String description, String userId,
      bool isNextDay, DateTime scheduleDay) {
    return _$addTaskAsyncAction.run(() =>
        super.addTask(taskName, description, userId, isNextDay, scheduleDay));
  }

  late final _$deleteTaskAsyncAction =
      AsyncAction('TaskStoreBase.deleteTask', context: context);

  @override
  Future<void> deleteTask(String id) {
    return _$deleteTaskAsyncAction.run(() => super.deleteTask(id));
  }

  late final _$updateTaskStatusAsyncAction =
      AsyncAction('TaskStoreBase.updateTaskStatus', context: context);

  @override
  Future<void> updateTaskStatus(String id, bool isDone) {
    return _$updateTaskStatusAsyncAction
        .run(() => super.updateTaskStatus(id, isDone));
  }

  late final _$updateIsNextDayStatusAsyncAction =
      AsyncAction('TaskStoreBase.updateIsNextDayStatus', context: context);

  @override
  Future<void> updateIsNextDayStatus(bool? value) {
    return _$updateIsNextDayStatusAsyncAction
        .run(() => super.updateIsNextDayStatus(value));
  }

  late final _$updateTaskAsyncAction =
      AsyncAction('TaskStoreBase.updateTask', context: context);

  @override
  Future<void> updateTask(String id, String taskName, String taskDescription) {
    return _$updateTaskAsyncAction
        .run(() => super.updateTask(id, taskName, taskDescription));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
currentFilter: ${currentFilter},
taskMode: ${taskMode},
isNextDay: ${isNextDay},
startRangeDate: ${startRangeDate},
endRangeDate: ${endRangeDate},
tasks: ${tasks},
filteredTasks: ${filteredTasks}
    ''';
  }
}
