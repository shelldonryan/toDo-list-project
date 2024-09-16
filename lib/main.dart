import 'package:flutter/material.dart';
import 'package:todo_list_project/features/auth/pages/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_list_project/shared/themes/index.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: MyColors.greenSofTec),
        useMaterial3: false,
      ),
      home: const AuthPage(),
    );
  }
}



