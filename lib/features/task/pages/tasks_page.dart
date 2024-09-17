import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/core/stores/tasks_store.dart';
import 'package:todo_list_project/features/task/models/index.dart';
import 'package:todo_list_project/features/task/widgets/index.dart';
import '../../../shared/themes/index.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  late bool isGetOneTime = false;

  _showTaskAlert(BuildContext context) {
    String taskName = '';
    String description = '';

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
                    decoration: const InputDecoration(
                        labelText: "what's the task name?"),
                    onChanged: (value) {
                      taskName = value;
                    },
                  ),
                  TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                        labelText: "what's the description?"),
                    onChanged: (value) {
                      description = value;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (taskName.isNotEmpty) {
                        setState(() {
                          // _addTask(taskName, description);
                        });
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

  _showTaskModal(BuildContext context, Task task) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return TaskOptionsModal(
            task: task,
            onUpdate: (Task value) {
              setState(() {
                // _updateTask(value);
              });
              Navigator.pop(context);
            },
            onDelete: () async {
              setState(() {
                // _deleteTask(task.id);
              });
              Navigator.pop(context);
            },
          );
        });
  }

  _showListViewStatus(List<Task> tasks, String label) {
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
                return TaskTile(
                  task: task,
                  onCheckBoxChanged: (isChecked) {
                    setState(() {
                      // _updateTaskStatus(task.id, task.isDone);
                    });
                  },
                  onLongPress: (Task value) {
                    _showTaskModal(context, value);
                  },
                );
              },
            ),
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final taskStore = Provider.of<TaskStore>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.greenSofTec,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("Task List"),
        elevation: 10,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 80),
        child: FutureBuilder(
            future: taskStore.loadTasks(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting && isGetOneTime == false) {
                isGetOneTime = true;
                return const Center(child: CircularProgressIndicator());
              }

              final tasks = taskStore.tasks;

              final pendingTasks =
                  tasks.where((task) => task.isDone == 0).toList();
              final doneTasks =
                  tasks.where((task) => task.isDone == 1).toList();

              return Column(
                children: [
                  _showListViewStatus(pendingTasks, 'Pending'),
                  const SizedBox(
                    height: 8,
                  ),
                  _showListViewStatus(doneTasks, 'Finished'),
                ],
              );
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showTaskAlert(context);
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
