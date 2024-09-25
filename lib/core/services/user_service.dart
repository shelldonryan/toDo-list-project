import 'package:sqflite/sqflite.dart';
import 'package:todo_list_project/features/auth/models/user.dart';
import '../database/db.dart';

class UserService {
  final String _usersTableName = "users";
  final DatabaseService dbService = DatabaseService.instance;

  Future<Database> get database async {
    return await dbService.database;
  }

  Future<List<Users>> getUsers() async {
    final db = await database;

    final data = await db.query(_usersTableName);

    List<Users> users = data
        .map((user) => Users(
            id: user["id"] as String,
            name: user["name"] as String,
            email: user["email"] as String,
            password: user["password"] as String,
            type: user["type"] as String,
            token: user["token"] as String))
        .toList();

    return users;
  }

  Future<bool> addUser(Users user) async{
    final db = await database;

    await db.insert(_usersTableName, {
      "id": user.id,
      "name": user.name,
      "email": user.email,
      "type": user.type,
      "password": user.password,
      "token": user.token,
    });

    return true;
  }
}
