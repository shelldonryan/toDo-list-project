// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TaskStore on _TaskStoreBase, Store {
  late final _$isGetOneTimeAtom =
      Atom(name: '_TaskStoreBase.isGetOneTime', context: context);

  @override
  bool get isGetOneTime {
    _$isGetOneTimeAtom.reportRead();
    return super.isGetOneTime;
  }

  @override
  set isGetOneTime(bool value) {
    _$isGetOneTimeAtom.reportWrite(value, super.isGetOneTime, () {
      super.isGetOneTime = value;
    });
  }

  late final _$tasksAtom = Atom(name: '_TaskStoreBase.tasks', context: context);

  @override
  List<Task> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(List<Task> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  late final _$loadTasksAsyncAction =
      AsyncAction('_TaskStoreBase.loadTasks', context: context);

  @override
  Future<void> loadTasks() {
    return _$loadTasksAsyncAction.run(() => super.loadTasks());
  }

  late final _$addTaskAsyncAction =
      AsyncAction('_TaskStoreBase.addTask', context: context);

  @override
  Future<void> addTask(String taskName, String description) {
    return _$addTaskAsyncAction.run(() => super.addTask(taskName, description));
  }

  late final _$deleteTaskAsyncAction =
      AsyncAction('_TaskStoreBase.deleteTask', context: context);

  @override
  Future<void> deleteTask(int id) {
    return _$deleteTaskAsyncAction.run(() => super.deleteTask(id));
  }

  late final _$updateTaskStatusAsyncAction =
      AsyncAction('_TaskStoreBase.updateTaskStatus', context: context);

  @override
  Future<void> updateTaskStatus(int id, int isDone) {
    return _$updateTaskStatusAsyncAction
        .run(() => super.updateTaskStatus(id, isDone));
  }

  late final _$updateTaskAsyncAction =
      AsyncAction('_TaskStoreBase.updateTask', context: context);

  @override
  Future<void> updateTask(int id, String taskName, String taskDescription) {
    return _$updateTaskAsyncAction
        .run(() => super.updateTask(id, taskName, taskDescription));
  }

  @override
  String toString() {
    return '''
isGetOneTime: ${isGetOneTime},
tasks: ${tasks}
    ''';
  }
}
