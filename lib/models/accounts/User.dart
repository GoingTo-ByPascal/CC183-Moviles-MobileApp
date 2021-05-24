import 'package:goingto_app/models/accounts/wallet.dart';

class User {
  Wallet wallet;
  String email;
  String password;

  User(this.wallet, this.email, this.password);
}
