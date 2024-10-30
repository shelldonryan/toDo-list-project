// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TaskStore on TaskStoreBase, Store {
  Computed<ObservableList<Task>>? _$pendingTasksComputed;

  @override
  ObservableList<Task> get pendingTasks => (_$pendingTasksComputed ??=
          Computed<ObservableList<Task>>(() => super.pendingTasks,
              name: 'TaskStoreBase.pendingTasks'))
      .value;
  Computed<ObservableList<Task>>? _$finishedTasksComputed;

  @override
  ObservableList<Task> get finishedTasks => (_$finishedTasksComputed ??=
          Computed<ObservableList<Task>>(() => super.finishedTasks,
              name: 'TaskStoreBase.finishedTasks'))
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

  late final _$isTomorrowAtom =
      Atom(name: 'TaskStoreBase.isTomorrow', context: context);

  @override
  bool get isTomorrow {
    _$isTomorrowAtom.reportRead();
    return super.isTomorrow;
  }

  @override
  set isTomorrow(bool value) {
    _$isTomorrowAtom.reportWrite(value, super.isTomorrow, () {
      super.isTomorrow = value;
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
  Future<void> loadTasks(
      String uid, String filter, DateTime? startRange, DateTime? endRange) {
    return _$loadTasksAsyncAction
        .run(() => super.loadTasks(uid, filter, startRange, endRange));
  }

  late final _$addTaskAsyncAction =
      AsyncAction('TaskStoreBase.addTask', context: context);

  @override
  Future<void> addTask(
      String taskName, String description, String userId, bool isTomorrow) {
    return _$addTaskAsyncAction
        .run(() => super.addTask(taskName, description, userId, isTomorrow));
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

  late final _$updateIsTomorrowStatusAsyncAction =
      AsyncAction('TaskStoreBase.updateIsTomorrowStatus', context: context);

  @override
  Future<void> updateIsTomorrowStatus(bool? value) {
    return _$updateIsTomorrowStatusAsyncAction
        .run(() => super.updateIsTomorrowStatus(value));
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
isTomorrow: ${isTomorrow},
tasks: ${tasks},
pendingTasks: ${pendingTasks},
finishedTasks: ${finishedTasks}
    ''';
  }
}
