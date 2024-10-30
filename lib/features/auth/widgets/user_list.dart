import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/core/stores/user_store.dart';

import '../../../shared/utils/show_snack_bar.dart';
import '../models/user.dart';

userList({required BuildContext context, required List<Users> users, required String futureType}) {
  showDialog(context: context, builder: (context) {
    return AlertDialog(
      title: const Text("Choose a user"),
      content: SizedBox(
        height: (50.0 * users.length),
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              title: Text(user.name),
              onTap: () {
                Provider.of<UserStore>(context, listen: false).updateType(user.id, futureType);
                Navigator.pop(context);
                showSnackBar(context: context, message: "User updated to ${user.type}");
              },
            );
          },
        ),
      ),
    );
  });
}