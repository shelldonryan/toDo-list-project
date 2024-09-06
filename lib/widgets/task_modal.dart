import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskOptionsModal extends StatelessWidget {
  final Future<void> Function() onDelete;
  final Task task;

  TaskOptionsModal({super.key, required this.onDelete, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.taskName,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text("task.description"),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: () async {
                await onDelete();
              }, child: const Icon(Icons.delete))
            ],
          )
        ],
      ),
    );
  }
}
