import 'package:flutter/material.dart';
import 'package:todo_list_project/shared/themes/my_colors.dart';

class AllTaskPage extends StatefulWidget {
  const AllTaskPage({super.key});

  @override
  State<AllTaskPage> createState() => _AllTaskPageState();
}

class _AllTaskPageState extends State<AllTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Tasks"),
        centerTitle: true,
        backgroundColor: MyColors.greenForest,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: const Center(
          child: Text(
        "Cuida",
        style: TextStyle(color: Colors.black87, fontSize: 30),
        textAlign: TextAlign.center,
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
