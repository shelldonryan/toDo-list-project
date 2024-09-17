import 'package:mobx/mobx.dart';
import '../database/tasks_service.dart';
import '../../features/task/models/index.dart';

part 'tasks_store.g.dart';

class TaskStore = _TaskStoreBase with _$TaskStore;

abstract class _TaskStoreBase with Store {
  final DatabaseService _db;

  _TaskStoreBase(this._db);

  @observable
  bool isLoading = false;

  ObservableList<Task> tasks = ObservableList<Task>();

  @action
  Future<void> loadTasks() async {
    isLoading = true;
    final allTasks = await _db.getTasks();
    tasks.clear();
    tasks.addAll(allTasks);
    isLoading = false;
  }

}