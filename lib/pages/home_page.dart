import 'package:flutter/material.dart';
import 'package:todo_list_project/pages/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TaskPageTwo(),
                ),
              );
            },
            child: const Text("Go to Tasks")),
      ),
    );
  }
}
