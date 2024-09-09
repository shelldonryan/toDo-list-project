import 'package:flutter/material.dart';
import 'package:todo_list_project/models/index.dart';

class EditTaskModal extends StatefulWidget {
  final Task task;
  const EditTaskModal({super.key, required this.task});

  @override
  State<StatefulWidget> createState() => _StateEditTaskModal();
}

class _StateEditTaskModal extends State<EditTaskModal>{
  late TextEditingController _taskNameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _taskNameController = TextEditingController(text: widget.task.taskName);
    _descriptionController = TextEditingController(text: widget.task.description);
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

}