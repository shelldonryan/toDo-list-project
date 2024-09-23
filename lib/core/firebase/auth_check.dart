import 'package:flutter/material.dart';
import 'package:todo_list_project/features/auth/pages/auth_page.dart';
import 'package:todo_list_project/features/task/pages/index.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  final bool isAuth = false;

  @override
  Widget build(BuildContext context) {
    return isAuth ? const TaskPage() : const AuthPage();
  }
}