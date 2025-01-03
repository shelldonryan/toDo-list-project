import 'dart:convert';

class Task {
  String id;
  String taskName;
  String description;
  String userId;
  bool isDone;

  Task({required this.id, required this.taskName, required this.isDone, required this.description, required this.userId});

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id']!,
      taskName: map['tasName'] ?? '',
      description: map['description'] ?? '',
      isDone: map['isDone'] as bool,
      userId: map['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'taskName': taskName,
    'description': description,
    'isDone': isDone,
    'userId': userId,
  };

  factory Task.fromJson(String jsonString) => Task.fromMap(json.decode(jsonString));

  String toJson() => json.encode(toMap());
}
