import 'package:flutter/material.dart';
import 'package:todo_list_project/core/firebase/auth_check.dart';
import 'package:todo_list_project/core/services/tasks_service.dart';
import 'package:todo_list_project/core/services/user_service.dart';
import 'package:todo_list_project/core/stores/tasks_store.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_list_project/core/stores/auth_store.dart';
import 'firebase_options.dart';
import 'package:todo_list_project/shared/themes/index.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
    providers: [
      Provider(create: (context) => TaskService(),),
      Provider(create: (context) => TaskStore(Provider.of<TaskService>(context, listen: false))),
      Provider(create: (context) => AuthStore()),
    ],
    child: const MyApp(),
  ));
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
      home: const AuthCheck(),
    );
  }
}
