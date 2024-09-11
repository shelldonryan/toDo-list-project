import 'package:flutter/material.dart';
import 'package:todo_list_project/models/index.dart';

class EditTaskModal extends StatefulWidget {
  final Task task;
  final ValueChanged<Task> onUpdate;
  final String typeEdition;

  const EditTaskModal(
      {super.key,
      required this.task,
      required this.onUpdate,
      required this.typeEdition});

  @override
  State<EditTaskModal> createState() => _StateEditTaskModal();
}

class _StateEditTaskModal extends State<EditTaskModal> {
  late TextEditingController _taskTextController;

  @override
  void initState() {
    super.initState();
    if (widget.typeEdition == 'title') {
      _taskTextController = TextEditingController(text: widget.task.taskName);
    } else {
      _taskTextController = TextEditingController(text: widget.task.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit task..."),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _taskTextController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  labelText: widget.typeEdition == 'title'
                      ? 'New Title'
                      : 'New Description'),
              onSubmitted: (value) {
                _taskTextController.text = value;
              },
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () {
                if (widget.typeEdition == 'title') {
                  widget.task.taskName = _taskTextController.text;
                } else if (widget.typeEdition == 'description') {
                  widget.task.description = _taskTextController.text;
                }
                widget.onUpdate(widget.task);
              },
              child: const Icon(Icons.check),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _taskTextController.dispose();
    super.dispose();
  }
}
