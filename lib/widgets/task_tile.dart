import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final ValueChanged<bool> onCheckBoxChanged;

  TaskTile({required this.task, required this.onCheckBoxChanged});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.taskName),
      leading: Checkbox(
          value: task.isDone == 1,
          onChanged: (bool? value) {
            onCheckBoxChanged(value == true);
          }),
    );
  }
}