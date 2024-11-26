import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/core/repository/role_repository.dart';
import 'package:todo_list_project/core/stores/auth_store.dart';
import 'package:todo_list_project/core/stores/tasks_store.dart';
import 'package:todo_list_project/core/stores/user_store.dart';
import 'package:todo_list_project/features/auth/widgets/user_list.dart';
import 'package:todo_list_project/shared/utils/format_string.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
        foregroundColor: Colors.white,
        title: Text(AppLocalizations.of(context)!.profilePageAppBarTitle),
      ),
      body: Observer(
        builder: (_) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text(
                    userStore.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    userStore.userType == "developer"
                        ? AppLocalizations.of(context)!.developerRole
                        : AppLocalizations.of(context)!.supportRole,
                    style: const TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              "${taskStore.currentFilter.toString().capitalize()} Tasks",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.pending_outlined),
              title: Text(
                AppLocalizations.of(context)!.pendingTaskTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              trailing: Text(
                taskStore.filteredTasks
                    .where((task) => !task.isDone)
                    .length
                    .toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.task_alt),
              title: Text(
                AppLocalizations.of(context)!.finishedTaskTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              trailing: Text(
                taskStore.filteredTasks
                    .where((task) => task.isDone)
                    .length
                    .toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.all_inbox_sharp),
              title: Text(
                AppLocalizations.of(context)!.totalTaskTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              trailing: Text(
                taskStore.filteredTasks.length.toString(),
                style: const TextStyle(
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
                          leading: const Icon(Icons.transform),
                          title: Text(AppLocalizations.of(context)!.makeDevBtn),
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
                          leading: const Icon(Icons.transform),
                          title: Text(AppLocalizations.of(context)!.makeSupBtn),
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
                      title: Text(AppLocalizations.of(context)!.logoutBtn),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.red,
                      ),
                      onTap: () {
                        authStore.logout().then(
                          (String? errorMessage) {
                            if (errorMessage != null) {
                              showErrorSnackBar(
                                  context: context, error: errorMessage);
                            }
                          },
                        );
                      },
                    ),
                  ),
                  Card(
                    elevation: 4,
                    shadowColor: Colors.black12,
                    child: ListTile(
                      textColor: Colors.red,
                      leading: const Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                      title: Text(AppLocalizations.of(context)!.deleteAccountBtn),
                      trailing: const Icon(
                        Icons.chevron_right,
                        color: Colors.red,
                      ),
                      onTap: () {
                        final uid = authStore.userId;
                        authStore.deleteAccount().then(
                          (String? errorMessage) async {
                            await RoleRepository().delete(uid!);
                            userStore.deleteUser();
                            if (errorMessage != null) {
                              showErrorSnackBar(
                                  context: context, error: errorMessage);
                            }
                          },
                        );
                        authStore.logout().then(
                          (String? errorMessage) {
                            if (errorMessage != null) {
                              showErrorSnackBar(
                                  context: context, error: errorMessage);
                            }
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
