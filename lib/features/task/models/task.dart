import 'dart:convert';

class Task {
  final String id;
  final DateTime createdAt;
  String taskName;
  String description;
  final String userId;
  bool isDone;

  Task(
      {required this.id,
      required this.createdAt,
      required this.taskName,
      required this.isDone,
      required this.description,
      required this.userId});

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id']!,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      taskName: map['tasName'] ?? '',
      isDone: map['isDone'] as bool,
      description: map['description'] ?? '',
      userId: map['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        "createdAt": createdAt.millisecondsSinceEpoch,
        'taskName': taskName,
        'isDone': isDone,
        'description': description,
        'userId': userId,
      };

  factory Task.fromJson(String jsonString) =>
      Task.fromMap(json.decode(jsonString));

  String toJson() => json.encode(toMap());
}
