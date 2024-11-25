import 'package:flutter/material.dart';
import 'package:todo_list_project/shared/themes/my_colors.dart';

import 'features/auth/pages/auth_check.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: MyColors.greenForest,
        brightness: Brightness.light,
      ),
      home: const AuthCheck(),
    );
  }
}
