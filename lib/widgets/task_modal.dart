import 'package:flutter/material.dart';
import '../models/index.dart';

class TaskOptionsModal extends StatelessWidget {
  final Task task;
  final Future<void> Function() onDelete;
  final ValueChanged<Task> onUpdate;

  const TaskOptionsModal({
    super.key,
    required this.task,
    required this.onDelete,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onDoubleTap: () {
              
            },
            child: Text(
              task.taskName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(task.description),
          Visibility(
            visible: task.description.isNotEmpty,
            child: const SizedBox(
              height: 40,
            ),
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
