import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
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
      home: HomePageToDo(title: 'To-do List Page'),
    );
  }
}

class HomePageToDo extends StatefulWidget {
  final String title;

  const HomePageToDo({super.key, required this.title});

  @override
  _HomePageToDo createState() => _HomePageToDo();
}

class _HomePageToDo extends State<HomePageToDo> {
  var listTasks = <String>[];
  final TextEditingController textController = TextEditingController();

  Future<void> _todo_task() async {
    if (textController.text.isNotEmpty) {
      setState(() {
        listTasks.add(textController.text);
        textController.clear();
      });
    }
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
                    title: Text(listTasks[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _todo_task,
        tooltip: 'Create one more to-do task',
        child: const Icon(Icons.add_outlined),
      ),
    );
  }
}
