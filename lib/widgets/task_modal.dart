import 'package:flutter/material.dart';
import 'package:todo_list_project/widgets/edit_task_modal.dart';
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
              showDialog(
                  context: context,
                  builder: (context) {
                    return EditTaskModal(
                      task: task,
                      onUpdate: onUpdate,
                      typeEdition: 'title',
                    );
                  });
            },
            child: Text(
              task.taskName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
              onDoubleTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return EditTaskModal(
                        task: task,
                        onUpdate: onUpdate,
                        typeEdition: 'description',
                      );
                    });
              },
              child: Text(task.description)),
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
