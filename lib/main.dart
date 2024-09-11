import 'package:flutter/material.dart';
import 'package:todo_list_project/features/task/pages/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF50CF01),),
        useMaterial3: false,
      ),
      home: const TaskPage(),
    );
  }
}



