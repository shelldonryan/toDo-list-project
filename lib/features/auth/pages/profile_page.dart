import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/core/stores/auth_store.dart';
import 'package:todo_list_project/core/stores/tasks_store.dart';
import 'package:todo_list_project/core/stores/user_store.dart';
import 'package:todo_list_project/features/auth/widgets/user_list.dart';
import '../../../shared/themes/my_colors.dart';
import '../../../shared/utils/show_snack_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late AuthStore authStore;
  late UserStore userStore;
  late TaskStore taskStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userStore = Provider.of<UserStore>(context);
    authStore = Provider.of<AuthStore>(context);
    taskStore = Provider.of<TaskStore>(context);
  }

  @override
  void dispose() {
    super.dispose();
    userStore.cleanData();
  }

  @override
  Widget build(BuildContext context) {
    userStore.getUserAccount(authStore.userId!);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.greenForest,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("Profile"),
      ),
      body: Observer(
        builder: (_) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Column(
              children: [
                // const CircleAvatar(
                //   radius: 50,
                //   backgroundImage: NetworkImage(
                //       "https://images.unsplash.com/photo-1727638786395-6df4fc4a2048?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHw4fHx8ZW58MHx8fHx8"),
                // ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  userStore.username,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Text(
                  userStore.userType,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w200,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              "${taskStore.currentFilter.toString().toUpperCase()} TASKS",
              style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.pending_outlined),
              title: const Text(
                "Pending Tasks",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              trailing: Text(
                taskStore.pendingTasks.length.toString(),
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.task_alt),
              title: const Text(
                "Finished Tasks",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              trailing: Text(
                taskStore.finishedTasks.length.toString(),
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.all_inbox_sharp),
              title: const Text(
                "Total Tasks",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              trailing: Text(
                taskStore.tasks.length.toString(),
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Visibility(
                      visible: userStore.userType == 'developer',
                      child: Card(
                        elevation: 4,
                        shadowColor: Colors.black12,
                        child: ListTile(
                          textColor: Colors.black54,
                          leading: const Icon(Icons.transform),
                          title: const Text("Make user Developer"),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            userList(
                                context: context,
                                users: userStore.supportUsers,
                                futureType: "developer");
                          },
                        ),
                      )),
                  Visibility(
                      visible: userStore.userType == 'developer',
                      child: Card(
                        elevation: 4,
                        shadowColor: Colors.black12,
                        child: ListTile(
                          textColor: Colors.black54,
                          leading: const Icon(Icons.transform),
                          title: const Text("Make user support"),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            userList(
                                context: context,
                                users: userStore.developerUsers,
                                futureType: "support");
                          },
                        ),
                      )),
                  Card(
                    elevation: 4,
                    shadowColor: Colors.black12,
                    child: ListTile(
                      textColor: Colors.red,
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      title: const Text("Logout"),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.red,
                      ),
                      onTap: () {
                        authStore.logout().then(
                          (String? erro) {
                            if (erro != null) {
                              showErrorSnackBar(context: context, error: erro);
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
