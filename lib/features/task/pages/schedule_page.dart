import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/core/controller/calendar_controller.dart';
import 'package:todo_list_project/core/stores/auth_store.dart';
import 'package:todo_list_project/core/stores/tasks_store.dart';
import 'package:todo_list_project/shared/themes/my_colors.dart';
import 'package:todo_list_project/shared/utils/calendar_widget.dart';
import 'package:todo_list_project/shared/utils/show_snack_bar.dart';

class ScheduleTaskPage extends StatefulWidget {
  const ScheduleTaskPage({super.key});

  @override
  State<ScheduleTaskPage> createState() => _ScheduleTaskPageState();
}

class _ScheduleTaskPageState extends State<ScheduleTaskPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final CalendarController calendarController = CalendarController();
  late TaskStore taskStore;
  late AuthStore authStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    taskStore = Provider.of<TaskStore>(context);
    authStore = Provider.of<AuthStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Schedule Task"),
        backgroundColor: MyColors.greenForest,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,

      ),
      body: Observer(
        builder:(_) => SingleChildScrollView(
          child: Column(
            children: [
              CalendarWidget(isRange: false, controller: calendarController),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title Here",
                  labelStyle: TextStyle(color: Colors.black54),
                ),
              ),
              TextField(
                controller: descriptionController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: "Description here",
                  labelStyle: TextStyle(color: Colors.black54),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      taskStore.addTask(
                          titleController.text,
                          descriptionController.text,
                          authStore.userId!, false,
                          calendarController.focusedDate);
                      titleController.clear();
                      descriptionController.clear();
                      Navigator.pop(context);
                    } else {
                      showErrorSnackBar(context: context, error: "Write a title for your task");
                    }
                  },
                  child: const Icon(Icons.check)),
            ],
          ),
        ),
      ),
    );
  }
}
