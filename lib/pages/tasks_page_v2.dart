import 'package:flutter/material.dart';
import 'package:todo_list_project/models/task.dart';
import 'package:todo_list_project/widgets/task_tile.dart';

class TaskPageTwo extends StatefulWidget {
  const TaskPageTwo({super.key});

  @override
  State<TaskPageTwo> createState() => _TaskPageTwoState();
}

class _TaskPageTwoState extends State<TaskPageTwo> {
  List<Task> tasks = [];

  _addTaskToList(String taskName, String description) {
    setState(() {
      tasks.add(Task(
          id: tasks.length + 1,
          taskName: taskName,
          description: description,
          isDone: 0));
    });

    Navigator.pop(context);
  }

  _showTaskAlert(BuildContext context) {
    String taskName = '';
    String description = '';

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add new task'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration:
                      const InputDecoration(labelText: "what's the task name?"),
                  onChanged: (value) {
                    taskName = value;
                  },
                ),
                TextField(
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
                      _addTaskToList(taskName, description);
                    }
                  },
                  child: const Icon(Icons.check),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Task List"),
        elevation: 3,
      ),
      body: ListView.builder(
          itemBuilder: (context, index) {
            final task = tasks[index];
            return TaskTile(task: task, onCheckBoxChanged: (isChecked) {
              setState(() {
                task.isDone = isChecked ? 1 : 0;
              });
            });
          },
          itemCount: tasks.length),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showTaskAlert(context);
        },
        icon: const Icon(Icons.task_alt),
        label: const Text(
          "Add Task",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
