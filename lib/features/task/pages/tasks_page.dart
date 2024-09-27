import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/core/stores/auth_store.dart';
import 'package:todo_list_project/core/stores/tasks_store.dart';
import 'package:todo_list_project/features/task/models/task.dart';
import 'package:todo_list_project/shared/widgets/show_snack_bar.dart';
import '../../../shared/themes/index.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late final TaskStore taskStore;
  late final AuthStore authStore;

  _showEditTaskAlert(BuildContext context, Task task, TaskStore store) {
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
                      store.updateTask(task.id, titleController.text,
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

  _showTaskAlert(BuildContext context, TaskStore taskStore, String uid) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add new task'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                        labelText: "what's the task name?"),
                  ),
                  TextField(
                    controller: descriptionController,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                        labelText: "what's the description?"),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (titleController.text.isNotEmpty) {
                        taskStore.addTask(titleController.text,
                            descriptionController.text, uid);
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
  }

  _showTaskModal(BuildContext context, Task task, TaskStore store) {
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
                    visible: task.description.isEmpty,
                    child: const SizedBox(
                      height: 40,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          store.deleteTask(task.id);
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

  showListViewStatus(List<Task> tasks, String label, TaskStore store) {
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
                            store.updateTaskStatus(task.id, isDone!)),
                    onLongPress: () {
                      _showEditTaskAlert(context, task, store);
                    },
                    onTap: () {
                      _showTaskModal(context, task, store);
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
  Widget build(BuildContext context) {
    taskStore = Provider.of<TaskStore>(context);
    authStore = Provider.of<AuthStore>(context);

    taskStore.loadTasks();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.greenSofTec,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("Task List"),
        elevation: 10,
        actions: [
          IconButton(
              onPressed: () {
                authStore.logout().then(
                  (String? erro) {
                    if (erro != null) {
                      showErrorSnackBar(context: context, error: erro);
                    }
                  },
                );
              },
              icon: const Icon(Icons.logout))
        ],
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
              showListViewStatus(pendingTasks, 'Pending', taskStore),
              const SizedBox(
                height: 8,
              ),
              showListViewStatus(doneTasks, 'Finished', taskStore),
            ],
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showTaskAlert(context, taskStore, authStore.user!.uid);
        },
        backgroundColor: MyColors.greenSofTec,
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
