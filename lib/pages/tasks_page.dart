import 'package:flutter/material.dart';
import 'package:todo_list_project/models/index.dart';
import 'package:todo_list_project/services/db_service.dart';
import 'package:todo_list_project/widgets/index.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final DatabaseService _databaseService = DatabaseService.instance;

  Future<void> _addTask(String taskName, String description) async {
      await _databaseService.addTask(taskName, description);
  }

  Future<void> _updateTaskStatus(int id, int isDone) async{
    await _databaseService.updateTaskStatus(id, isDone);
  }

  Future<void> _deleteTask(int id) async {
    _databaseService.deleteTask(id);
  }

  Future<void> _updateTask(Task task) async {
    await _databaseService.updateTask(task);
  }

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
                    decoration:
                        const InputDecoration(labelText: "what's the task name?"),
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
                          _addTask(taskName, description);
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
                _updateTask(value);
              });
              Navigator.pop(context);
            },
            onDelete: () async {
              setState(() {
                _deleteTask(task.id);
              });
              Navigator.pop(context);
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("Task List"),
        elevation: 10,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: FutureBuilder(
          future: _databaseService.getTasks(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final task = snapshot.data![index];
                return TaskTile(
                  task: task,
                  onCheckBoxChanged: (isChecked) {
                    setState(() {
                      _updateTaskStatus(task.id, task.isDone);
                    });
                  },
                  onLongPress: (Task value) {
                    _showTaskModal(context, value);
                  },
                );
              },
            );
          }
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showTaskAlert(context);
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
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
