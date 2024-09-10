import 'package:flutter/material.dart';
import '../models/index.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final ValueChanged<bool> onCheckBoxChanged;
  final ValueChanged<Task> onLongPress;

  const TaskTile(
      {super.key, required this.task, required this.onCheckBoxChanged, required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.taskName,
        style: TextStyle(
            decoration: task.isDone == 1
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            color: task.isDone == 0
                ? Colors.black
                : Colors.grey),
      ),
      leading: Checkbox(
          value: task.isDone == 1,
          onChanged: (bool? value) {
            onCheckBoxChanged(value == true);
          }),
      onLongPress: () {
        onLongPress(task);
      },
    );
  }
}
