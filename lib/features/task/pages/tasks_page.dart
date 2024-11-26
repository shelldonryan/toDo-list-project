import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/core/stores/auth_store.dart';
import 'package:todo_list_project/core/stores/tasks_store.dart';
import 'package:todo_list_project/features/task/models/task.dart';
import 'package:todo_list_project/features/task/pages/schedule_page.dart';
import 'package:todo_list_project/shared/utils/calendar_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_list_project/shared/utils/format_string.dart';
import '../../../core/controller/calendar_controller.dart';
import '../../../shared/themes/my_colors.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final CalendarController calendarController;
  late final TaskStore taskStore;
  late final AuthStore authStore;

  _showEditTaskAlert(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        titleController.text = task.taskName;
        descriptionController.text = task.description;

        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.editTaskAlertTitle),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.taskNameTextField,
                  ),
                  onSubmitted: (value) {
                    titleController.text = value;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: descriptionController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.taskDescriptionTextField,
                  ),
                  onSubmitted: (value) {
                    descriptionController.text = value;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                    onPressed: () {
                      taskStore.updateTask(task.id, titleController.text,
                          descriptionController.text);
                      titleController.clear();
                      descriptionController.clear();
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.check))
              ],
            ),
          ),
        );
      },
    );
  }

  _showTaskAlert(BuildContext context, String uid) {
    showDialog(
        context: context,
        builder: (context) {
          titleController.clear();
          descriptionController.clear();

          return Observer(builder: (_) {
            return AlertDialog(
              title: Text(AppLocalizations.of(context)!.addTaskAlertTitle),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.taskNameTextField,
                        labelStyle: const TextStyle(color: Colors.black54),
                      ),
                    ),
                    TextField(
                      controller: descriptionController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.taskDescriptionTextField,
                        labelStyle: const TextStyle(color: Colors.black54),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.scheduleTomorrowLabel,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              color: !taskStore.isNextDay
                                  ? Colors.black54
                                  : MyColors.greenForest),
                        ),
                        Switch(
                          value: taskStore.isNextDay,
                          onChanged: (bool? value) =>
                              taskStore.isNextDay = !taskStore.isNextDay,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (titleController.text.isNotEmpty) {
                          taskStore.addTask(
                              titleController.text,
                              descriptionController.text,
                              uid,
                              taskStore.isNextDay,
                              DateTime.now());
                          titleController.clear();
                          descriptionController.clear();
                          Navigator.pop(context);
                        }
                      },
                      child: const Icon(Icons.check),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  _showTaskModal(BuildContext context, Task task) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.taskName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(task.description),
                  Visibility(
                    visible: task.description.isNotEmpty,
                    child: const SizedBox(
                      height: 30,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          taskStore.deleteTask(task.id);
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                ],
              ),
            ));
  }

  showListViewStatus(List<Task> tasks, String label) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.outline),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                label,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.outline),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text(
                      task.taskName,
                      style: TextStyle(
                          decoration: task.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: !task.isDone ? Colors.black : Colors.grey),
                    ),
                    leading: Checkbox(
                        value: task.isDone,
                        onChanged: (bool? isDone) =>
                            taskStore.updateTaskStatus(task.id, isDone!)),
                    onLongPress: () {
                      _showEditTaskAlert(context, task);
                    },
                    onTap: () {
                      _showTaskModal(context, task);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleClick(int item) {
    switch (item) {
      case 0:
        taskStore.taskMode = !taskStore.taskMode;
        break;
    }
  }

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
        backgroundColor: MyColors.greenForest,
        foregroundColor: Colors.white,
        title: Text(AppLocalizations.of(context)!.appBarTitleTasks),
        actions: [
          PopupMenuButton<int>(
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                    PopupMenuItem<int>(
                        value: 0, child: Text(AppLocalizations.of(context)!.actionTaskModeLabel)),
                  ])
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.only(),
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(color: MyColors.greenForest),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppLocalizations.of(context)!.drawerTitle,
                      style: const TextStyle(color: Colors.white, fontSize: 24)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.today),
              title: Text(AppLocalizations.of(context)!.todayFilter.capitalize()),
              onTap: () {
                taskStore.currentFilter = "today";
                taskStore.loadTasks(authStore.userId!);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(AppLocalizations.of(context)!.tomorrowFilter.capitalize()),
              onTap: () {
                taskStore.currentFilter = "tomorrow";
                taskStore.loadTasks(authStore.userId!);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_view_week),
              title: Text(AppLocalizations.of(context)!.weekFilter.capitalize()),
              onTap: () {
                taskStore.currentFilter = "week";
                taskStore.loadTasks(authStore.userId!);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: Text(AppLocalizations.of(context)!.monthFilter.capitalize()),
              onTap: () {
                taskStore.currentFilter = "month";
                taskStore.loadTasks(authStore.userId!);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: Text(AppLocalizations.of(context)!.allFilter.capitalize()),
              onTap: () {
                taskStore.currentFilter = "all";
                taskStore.loadTasks(authStore.userId!);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.filter_alt),
              title: Text(AppLocalizations.of(context)!.customFilter.capitalize()),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (context) {
                      return Observer(
                        builder: (_) => AlertDialog(
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.maxFinite,
                                  height: 395,
                                  child: calendarWidget(
                                      isRange: true,
                                      controller: calendarController),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      taskStore.currentFilter = "custom";
                                      taskStore.startRangeDate =
                                          calendarController.rangeStartDate;
                                      taskStore.endRangeDate =
                                          calendarController.rangeEndDate;
                                      taskStore.loadTasks(authStore.userId!);
                                      Navigator.pop(context);
                                    },
                                    child: const Icon(Icons.search))
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              },
            ),
          ],
        ),
      ),
      body: Observer(builder: (_) {
        String? uid = authStore.user!.uid;

        if (taskStore.isLoading && uid.isEmpty) {
          return const Center(child: LinearProgressIndicator());
        }

        taskStore.loadTasks(uid);

        List<Task> pendingTasks =
            taskStore.filteredTasks.where((task) => !task.isDone).toList();
        List<Task> doneTasks =
            taskStore.filteredTasks.where((task) => task.isDone).toList();

        return Container(
          padding:
              const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 80),
          child: Column(
            children: [
              showListViewStatus(pendingTasks, AppLocalizations.of(context)!.pendingTaskLabel.capitalize()),
              const SizedBox(
                height: 8,
              ),
              showListViewStatus(doneTasks, AppLocalizations.of(context)!.finishedTaskLabel.capitalize()),
            ],
          ),
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Observer(
        builder: (_) => FloatingActionButton.extended(
          heroTag: "schedule_button_page_tasks",
          onPressed: () {
            taskStore.taskMode
                ? _showTaskAlert(context, authStore.user!.uid)
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScheduleTaskPage()));
          },
          backgroundColor: MyColors.greenForest,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.task_alt),
          label: Text(
            taskStore.taskMode ? AppLocalizations.of(context)!.addTaskBtn : AppLocalizations.of(context)!.scheduleTaskBtn,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
