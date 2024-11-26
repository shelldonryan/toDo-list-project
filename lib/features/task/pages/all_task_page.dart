import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/core/controller/calendar_controller.dart';
import 'package:todo_list_project/features/task/models/task.dart';
import 'package:todo_list_project/shared/themes/my_colors.dart';
import '../../../core/stores/tasks_store.dart';
import '../../../core/utils/task_filter.dart';
import '../../auth/models/user.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllTaskPage extends StatefulWidget {
  const AllTaskPage({
    super.key,
    required this.user,
    required this.calendarController,
  });

  final Users user;
  final CalendarController calendarController;

  @override
  State<AllTaskPage> createState() => _AllTaskPageState();
}

class _AllTaskPageState extends State<AllTaskPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final TaskFilterController _filterController;
  late final TaskStore taskStore;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _filterController = TaskFilterController();
  }

  @override
  void didChangeDependencies() {
    taskStore = Provider.of<TaskStore>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  showListTasks(List<Task> tasks) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Card(
              child: ListTile(
                title: Text(task.taskName),
                subtitle: task.description.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Text(task.description))
                    : null,
                horizontalTitleGap: 0,
                contentPadding: const EdgeInsets.all(10),
                leading: task.isDone
                    ? const Icon(
                        Icons.check_box,
                        color: MyColors.greenForest,
                      )
                    : const Icon(Icons.check_box_outline_blank),
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    taskStore.loadSomeTasks(widget.user.id);

    return Observer(
      builder: (_) {
        final tasks = _filterController.filterTasks(
            taskStore.tasksSomeUser.toList(), "custom",
            startRangeDate:
                widget.calendarController.rangeStartDate ?? DateTime.now(),
            endRangeDate:
                widget.calendarController.rangeEndDate ?? DateTime.now());

        return Scaffold(
          appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.userTaskLabel + widget.user.name.toString()),
            backgroundColor: MyColors.greenForest,
            foregroundColor: Colors.white,
            bottom: TabBar(controller: _tabController, indicatorColor: MyColors.greenForest, labelColor: Colors.white, tabs: <Widget>[
              Tab(
                text: AppLocalizations.of(context)!.pendingTaskLabel,

              ),
              Tab(
                text: AppLocalizations.of(context)!.finishedTaskLabel,
              ),
            ]),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              showListTasks(
                  tasks.where((task) => task.isDone == false).toList()),
              showListTasks(
                  tasks.where((task) => task.isDone == true).toList()),
            ],
          ),
        );
      },
    );
  }
}
