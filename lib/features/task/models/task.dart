import 'dart:convert';

class Task {
  String taskName;
  String description;
  int id, isDone;

  Task({required this.id, required this.taskName, required this.isDone, required this.description});

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int,
      taskName: map['tasName'] ?? '',
      description: map['description'] ?? '',
      isDone: map['isDone'] as int,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'taskName': taskName,
    'description': description,
    'isDone': isDone,
  };

  factory Task.fromJson(String jsonString) => Task.fromMap(json.decode(jsonString));

  String toJson() => json.encode(toMap());
}