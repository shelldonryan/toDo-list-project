import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: false,
      ),
      home: const HomePageToDo(title: 'To-do List Page'),
    );
  }
}

class HomePageToDo extends StatefulWidget {
  final String title;

  const HomePageToDo({super.key, required this.title});

  @override
  State<HomePageToDo> createState() => _HomePageToDo();
}

class _HomePageToDo extends State<HomePageToDo> {
  var listTasks = <Task>[];
  final TextEditingController textController = TextEditingController();

  Future<void> _todoTask() async {
    if (textController.text.isNotEmpty) {
      setState(() {
        listTasks.add(Task(taskName: textController.text, isDone: false));
        textController.clear();
      });
    }
  }

  _taskDone(int index) {
    setState(() {
      listTasks[index].isDone = !listTasks[index].isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
              child: ListView.builder(
                itemCount: listTasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: listTasks[index].isDone,
                      onChanged: (bool? value) {
                        _taskDone(index);
                      },
                    ),
                    title: Text(
                      listTasks[index].taskName,
                      style: TextStyle(
                        decoration: listTasks[index].isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  );
                },
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

class Task {
  String taskName;
  bool isDone;

  Task({required this.taskName, required this.isDone});
}