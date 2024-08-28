import 'package:flutter/material.dart';
import 'package:todo_list_project/services/dbService.dart';
import '../models/task.dart';

class TaskPageToDo extends StatefulWidget {
  const TaskPageToDo({super.key});

  @override
  State<TaskPageToDo> createState() => _TaskPageToDo();
}

class _TaskPageToDo extends State<TaskPageToDo> {
  final DatabaseService _databaseService = DatabaseService.instance;

  final TextEditingController textController = TextEditingController();

  Future<void> _todoTask() async {
    if (textController.text.isNotEmpty) {
        await _databaseService.addTask(textController.text);

        setState(() {
          textController.clear();
        });
    }
  }

  Future<void> _taskDone(int id, int isDone) async {
    await _databaseService.updateTaskStatus(id, isDone);
    setState(() {});
  }

  Future<void> _deleteTask(int id) async {
    setState(() {
      _databaseService.deleteTask(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Tasks Page | To-Do List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: 'Write the task here',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder(
                future: _databaseService.getTasks(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      Task task = snapshot.data![index];

                      return ListTile(
                        leading: Checkbox(
                          value: task.isDone == 1,
                          onChanged: (bool? value) {
                            _taskDone(task.id, task.isDone);
                          },
                        ),
                        onLongPress: () {
                          _deleteTask(task.id);
                        },
                        title: Text(
                          task.taskName,
                          style: TextStyle(
                            decoration: task.isDone == 1
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            color: task.isDone == 0
                                ? Colors.black
                                : Colors.amber,
                          ),
                        ),
                      );
                    },
                  );
                }
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _todoTask,
        tooltip: 'Create one more to-do task',
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}