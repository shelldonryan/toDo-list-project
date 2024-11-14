import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/core/controller/calendar_controller.dart';
import 'package:todo_list_project/core/stores/user_store.dart';
import 'package:todo_list_project/features/task/pages/all_task_page.dart';
import 'package:todo_list_project/shared/utils/calendar_widget.dart';

import '../../../shared/themes/my_colors.dart';
import '../../auth/models/user.dart';

class FilterAllTaskPage extends StatefulWidget {
  const FilterAllTaskPage({super.key});

  @override
  State<FilterAllTaskPage> createState() => _FilterAllTaskPageState();
}

class _FilterAllTaskPageState extends State<FilterAllTaskPage> {
  late final UserStore userStore;
  late final CalendarController calendarController;

  @override
  void initState() {
    super.initState();
    userStore = Provider.of<UserStore>(context, listen: false);
    calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    List<Users> systemUsers = userStore.userList;

    if (systemUsers.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Nenhum Usuário'),
        ),
        body: const Center(
          child: Text('Não há usuários disponíveis'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Tasks"),
        centerTitle: true,
        backgroundColor: MyColors.greenForest,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Observer(
          builder: (_) => ListView.builder(
              itemCount: systemUsers.length,
              itemBuilder: (context, index) {
                final user = systemUsers[index];
                return Hero(
                  tag: 'list_tile_user_${user.id}',
                  child: ListTile(
                    title: Text(user.name),
                    leading: const Icon(Icons.person),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllTaskPage(user: user, calendarController: calendarController,)));
                    },
                  ),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "filter_button_page_all_tasks",
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Observer(
                builder: (_) => SingleChildScrollView(
                  child: SizedBox(
                    height: 395,
                    width: double.maxFinite,
                    child: calendarWidget(
                        isRange: true, controller: calendarController),
                  ),
                ),
              ),
            ),
          );
        },
        backgroundColor: MyColors.greenForest,
        child: const Icon(Icons.filter_alt),
      ),
    );
  }
}
