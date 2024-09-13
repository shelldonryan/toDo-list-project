import 'dart:convert';
import 'package:todo_list_project/features/task/models/index.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String password;
  final String type;
  final String token;
  final List<Task> tasks;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.type,
    required this.token,
    required this.tasks,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      tasks: List<Task>.from(
          (map['tasks'] as List<dynamic>).map((task) => Task.fromMap(task))
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'type': type,
      'token': token,
      'tasks': tasks.map((task) => task.toMap()).toList(),
    };
  }

  factory User.fromJson(String jsonString) => User.fromMap(json.decode(jsonString));

  String toJson() => json.encode(toMap());
}
