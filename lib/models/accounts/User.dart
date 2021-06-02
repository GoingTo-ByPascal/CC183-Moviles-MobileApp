import 'dart:convert';

import 'package:goingto_app/models/accounts/wallet.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String email;
  String password;
  Wallet? wallet;

  User({this.wallet, required this.email, required this.password});

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      email: data['email'],
      password: data['password'],
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
