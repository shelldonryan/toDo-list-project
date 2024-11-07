import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/core/stores/auth_store.dart';
import 'package:todo_list_project/core/stores/user_store.dart';
import 'package:todo_list_project/features/auth/pages/auth_page.dart';
import 'package:todo_list_project/shared/pages/home_page.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);
    final userStore = Provider.of<UserStore>(context);
    return Observer(builder:(_) {
      if (authStore.userIsAuth) {
        bool isDeveloper = userStore.userType == "developer" ? true : false;
        return HomePage(isDeveloper: isDeveloper);
      }
      return const AuthPage();
    });
  }
}