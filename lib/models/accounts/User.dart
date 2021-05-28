import 'package:goingto_app/models/accounts/wallet.dart';

class User {
  String email;
  String password;
  Wallet? wallet;

  User({this.wallet, required this.email, required this.password});

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      wallet: Wallet.fromJson(data['wallet']),
      email: data['email'],
      password: data['password'],
    );
  }
}
