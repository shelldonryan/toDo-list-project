import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/core/stores/auth_store.dart';
import 'package:todo_list_project/core/stores/user_store.dart';
import '../../../shared/themes/my_colors.dart';
import '../../../shared/widgets/show_snack_bar.dart';
import '../repositories/profile_repository.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final AuthStore authStore;
  late final UserStore userStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    userStore = Provider.of<UserStore>(context);
    authStore = Provider.of<AuthStore>(context);
  }

  @override
  void dispose() {
    super.dispose();
    userStore.cleanData();
  }

  @override
  Widget build(BuildContext context) {
    userStore.getUser(authStore.userId!);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.greenSofTec,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("Profile"),
      ),
      body: Observer(
        builder:(_) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1727638786395-6df4fc4a2048?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHw4fHx8ZW58MHx8fHx8"),
                  ),
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
                  Text(userStore.userType,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w200,
                        fontSize: 14,
                      )),
                ],
              ),
            const SizedBox(
              height: 50,
            ),
            ...List.generate(customListTiles.length, (index) {
              final tile = customListTiles[index];
              return Container(
                padding: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                alignment: Alignment.bottomCenter,
                child: ListTile(
                  leading: Icon(tile.icon),
                  title: Text(
                    tile.title,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  trailing: Text(
                    tile.quantity.toString(),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            }),
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
                      child: const Column(
                        children: [
                          Card(
                            elevation: 4,
                            shadowColor: Colors.black12,
                            child: ListTile(
                              textColor: Colors.black54,
                              leading: Icon(Icons.transform),
                              title: Text("Make user Developer"),
                              trailing: Icon(Icons.chevron_right),
                            ),
                          ),
                        ],
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
