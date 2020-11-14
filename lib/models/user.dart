// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String email;
  String password;
  String id;
  String token;
  DateTime createdAt;

  User({
    this.email,
    this.password,
    this.id,
    this.token,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        password: json["password"],
        id: json["id"],
        token: json["token"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "token": token,
        "id": id,
        "createdAt": createdAt.toIso8601String(),
      };
}

User loginUser(String jsonData, email, password) {
  final data = json.decode(jsonData)['data']['meta'];
   return User(
      email: email,
      password: password,
      id: "",
      token: data['token'],
      createdAt: null,
    );

}
