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
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final CalendarController calendarController;
  late TaskStore taskStore;
  late AuthStore authStore;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    calendarController = CalendarController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    taskStore = Provider.of<TaskStore>(context);
    authStore = Provider.of<AuthStore>(context);
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
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
        builder: (_) => SingleChildScrollView(
          child: Column(
            children: [
              calendarWidget(isRange: false, controller: calendarController),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      autocorrect: true,
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: "Title Here",
                        labelStyle: TextStyle(color: Colors.black54),
                      ),
                    ),
                    TextField(
                      autocorrect: true,
                      controller: descriptionController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        labelText: "Description here",
                        labelStyle: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ],
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
                          authStore.userId!,
                          false,
                          calendarController.focusedDate
                              .add(const Duration(hours: 4)));
                      titleController.clear();
                      descriptionController.clear();
                      Navigator.pop(context);
                    } else {
                      showErrorSnackBar(
                          context: context,
                          error: "Write a title for your task");
                    }
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(MyColors.greenForest)),
                  child: const Icon(Icons.check)),
            ],
          ),
        ),
      ),
    );
  }
}
