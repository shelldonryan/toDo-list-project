import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_project/core/repository/tasks_repository.dart';
import 'package:todo_list_project/core/repository/user_repository.dart';
import 'package:todo_list_project/core/stores/tasks_store.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_list_project/core/stores/auth_store.dart';
import 'package:todo_list_project/core/stores/user_store.dart';
import 'app_widget.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    if (kDebugMode) {
      print("Error to initialize: $e");
    }
  }

  runApp(MultiProvider(
    providers: [
      Provider(
        create: (context) => TasksRepository(),
      ),
      Provider(
        create: (context) => UserRepository(),
      ),
      Provider(create: (context) => AuthStore()),
      Provider(
          create: (context) =>
              TaskStore(Provider.of<TasksRepository>(context, listen: false))),
      Provider(
          create: (context) =>
              UserStore(Provider.of<UserRepository>(context, listen: false))),
    ],
    child: const MyApp(),
  ));
}