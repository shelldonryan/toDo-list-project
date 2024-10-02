import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/core/stores/auth_store.dart';
import 'package:todo_list_project/core/stores/user_store.dart';
import 'package:todo_list_project/features/auth/models/user.dart';

import '../../../shared/themes/my_colors.dart';

class ProfilePage extends StatefulWidget {

  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final String uidCurrentUser;
  late UserStore userStore;

  @override
  void initState() {
    super.initState();
    uidCurrentUser = Provider.of<AuthStore>(context, listen: false).user!.uid;
    userStore = Provider.of<UserStore>(context);
    userStore.getUser(uidCurrentUser);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.greenSofTec,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("Profile"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage("https://images.unsplash.com/photo-1727638786395-6df4fc4a2048?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHw4fHx8ZW58MHx8fHx8"),
              ),
              Text(userStore.user.name)
            ],
          ),
        ],
      ),
    );
  }
}
