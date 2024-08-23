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
        colorScheme:ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
    );
  }
}

