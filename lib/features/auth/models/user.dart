import 'dart:convert';

class Users {
  final String id;
  final String name;
  final String email;
  final String password;
  final String type;
  final String token;

  Users({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.type,
    required this.token,
  });

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'] as String,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
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
    };
  }

  factory Users.fromJson(String jsonString) => Users.fromMap(json.decode(jsonString));

  String toJson() => json.encode(toMap());
}
