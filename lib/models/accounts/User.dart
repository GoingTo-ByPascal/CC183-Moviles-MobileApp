import 'dart:convert';

import 'package:goingto_app/models/accounts/wallet.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));
User userAuthFromJson(String str) => User.authFromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String email;
  String password;
  Wallet? wallet;

  User(
      {required this.id,
      this.wallet,
      required this.email,
      required this.password});

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      id: data["id"],
      wallet: Wallet.fromJson(data['wallet']),
      email: data['email'],
      password: data['password'],
    );
  }

  factory User.authFromJson(Map<String, dynamic> data) {
    return User(
      id: data["id"],
      email: data['email'],
      password: data['token'],
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
