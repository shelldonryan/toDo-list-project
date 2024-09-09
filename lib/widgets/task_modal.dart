import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskOptionsModal extends StatelessWidget {
  final Task task;
  final Future<void> Function() onDelete;

  TaskOptionsModal({super.key, required this.task, required this.onDelete});

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
          Text(task.description),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await onDelete();
                  },
                  child: const Icon(Icons.delete))
            ],
          )
        ],
      ),
    );
  }
}
