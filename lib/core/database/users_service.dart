import 'package:sqflite/sqflite.dart';

import 'tasks_service.dart';

class UsersService {
  final DatabaseService dbService = DatabaseService.instance;
  
  Future<Database> get database async {
    return await dbService.database;
  }

  
}