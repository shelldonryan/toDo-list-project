import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/features/task/models/task.dart';
import 'package:todo_list_project/shared/themes/my_colors.dart';
import '../../../core/stores/tasks_store.dart';
import '../../auth/models/user.dart';

class AllTaskPage extends StatefulWidget {
  const AllTaskPage({
    super.key,
    required this.user,
  });

  final Users user;

  @override
  State<AllTaskPage> createState() => _AllTaskPageState();
}

class _AllTaskPageState extends State<AllTaskPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late final TaskStore taskStore;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
    final tasks = taskStore.tasks;
    return Observer(
      builder:(_) => Scaffold(
        appBar: AppBar(
          title: Text("Tasks User ${widget.user.name}"),
          backgroundColor: MyColors.greenForest,
          foregroundColor: Theme.of(context).colorScheme.onPrimary,
          bottom: TabBar(controller: _tabController, tabs: const <Widget>[
            Tab(
              text: "Pending",
            ),
            Tab(
              text: "Finished",
            ),
          ]),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            showListTasks(tasks.where((task) => task.isDone == false).toList()),
            showListTasks(tasks.where((task) => task.isDone == true).toList()),
          ],
        ),
      ),
    );
  }
}
