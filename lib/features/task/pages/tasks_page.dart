import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/core/stores/auth_store.dart';
import 'package:todo_list_project/core/stores/tasks_store.dart';
import 'package:todo_list_project/features/task/models/task.dart';
import 'package:todo_list_project/shared/utils/calendar_widget.dart';

import '../../../core/controller/calendar_controller.dart';
import '../../../shared/themes/my_colors.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final CalendarController calendarController;
  late final TaskStore taskStore;
  late final AuthStore authStore;

  _showEditTaskAlert(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        titleController.text = task.taskName;
        descriptionController.text = task.description;

        return AlertDialog(
          title: const Text("Editing Task..."),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'New Title',
                  ),
                  onSubmitted: (value) {
                    titleController.text = value;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: descriptionController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'New Description',
                  ),
                  onSubmitted: (value) {
                    descriptionController.text = value;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                    onPressed: () {
                      taskStore.updateTask(task.id, titleController.text,
                          descriptionController.text);
                      titleController.clear();
                      descriptionController.clear();
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.check))
              ],
            ),
          ),
        );
      },
    );
  }

  _showTaskAlert(BuildContext context, String uid) {
    showDialog(
        context: context,
        builder: (context) {
          titleController.clear();
          descriptionController.clear();

          return Observer(builder: (_) {
            return AlertDialog(
              title: const Text('Add new task'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: "what's the task name?",
                        labelStyle: TextStyle(color: Colors.black54),
                      ),
                    ),
                    TextField(
                      controller: descriptionController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        labelText: "what's the description?",
                        labelStyle: TextStyle(color: Colors.black54),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Schedule for tomorrow",
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: !taskStore.isTomorrow
                                  ? Colors.black54
                                  : MyColors.greenForest),
                        ),
                        Switch(
                          value: taskStore.isTomorrow,
                          onChanged: (bool? value) =>
                              taskStore.updateIsTomorrowStatus(value),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (titleController.text.isNotEmpty) {
                          taskStore.addTask(
                              titleController.text,
                              descriptionController.text,
                              uid,
                              taskStore.isTomorrow);
                          titleController.clear();
                          descriptionController.clear();
                          Navigator.pop(context);
                        }
                      },
                      child: const Icon(Icons.check),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  _showTaskModal(BuildContext context, Task task) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.taskName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(task.description),
                  Visibility(
                    visible: task.description.isNotEmpty,
                    child: const SizedBox(
                      height: 30,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          taskStore.deleteTask(task.id);
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }

  showListViewStatus(List<Task> tasks, String label) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outline),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                label,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.outline),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text(
                      task.taskName,
                      style: TextStyle(
                          decoration: task.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: !task.isDone ? Colors.black : Colors.grey),
                    ),
                    leading: Checkbox(
                        value: task.isDone,
                        onChanged: (bool? isDone) =>
                            taskStore.updateTaskStatus(task.id, isDone!)),
                    onLongPress: () {
                      _showEditTaskAlert(context, task);
                    },
                    onTap: () {
                      _showTaskModal(context, task);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    calendarController = CalendarController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    taskStore = Provider.of<TaskStore>(context);
    authStore = Provider.of<AuthStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    taskStore.loadTasks(authStore.userId!, taskStore.currentFilter, null, null);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.greenForest,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("Task List"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.only(),
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: MyColors.greenForest),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Filters',
                      style: TextStyle(color: Colors.white, fontSize: 24)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.today),
              title: const Text('Today'),
              onTap: () {
                taskStore.currentFilter = "today";
                taskStore.loadTasks(authStore.userId!, taskStore.currentFilter, null, null);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text('Tomorrow'),
              onTap: () {
                taskStore.currentFilter = "tomorrow";
                taskStore.loadTasks(authStore.userId!, taskStore.currentFilter, null, null);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_view_week),
              title: const Text('Week'),
              onTap: () {
                taskStore.currentFilter = "week";
                taskStore.loadTasks(authStore.userId!, taskStore.currentFilter, null, null);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Month'),
              onTap: () {
                taskStore.currentFilter = "month";
                taskStore.loadTasks(authStore.userId!, taskStore.currentFilter, null, null);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('All'),
              onTap: () {
                taskStore.currentFilter = "all";
                taskStore.loadTasks(authStore.userId!, taskStore.currentFilter, null, null);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.filter_alt),
              title: const Text('Custom'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (context) {
                      return Observer(
                        builder: (_) => AlertDialog(
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.maxFinite,
                                  height: 395,
                                  child: calendarWidget(
                                      isRange: true,
                                      controller: calendarController),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      taskStore.currentFilter = "custom";
                                      taskStore.loadTasks(
                                          authStore.userId!,
                                          taskStore.currentFilter,
                                          calendarController.rangeStartDate,
                                          calendarController.rangeEndDate);
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(Icons.search))
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ),
      body: Observer(builder: (_) {
        String? uid = authStore.user!.uid;

        if (taskStore.isLoading && uid.isEmpty) {
          return const Center(child: LinearProgressIndicator());
        }

        List<Task> pendingTasks = taskStore.tasks
            .where((task) => !task.isDone && task.userId == uid)
            .toList();
        List<Task> doneTasks = taskStore.tasks
            .where((task) => task.isDone && task.userId == uid)
            .toList();

        return Container(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 80),
          child: Column(
            children: [
              showListViewStatus(pendingTasks, 'Pending'),
              const SizedBox(
                height: 8,
              ),
              showListViewStatus(doneTasks, 'Finished'),
            ],
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showTaskAlert(context, authStore.user!.uid);
        },
        backgroundColor: MyColors.greenForest,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        icon: const Icon(Icons.task_alt),
        label: const Text(
          "Add Task",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
