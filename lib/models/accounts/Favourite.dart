import 'package:goingto_app/models/accounts/user.dart';
import 'package:goingto_app/models/geographic/locatable.dart';

class Favourite {
  User user;
  Locatable locatable;
  String description;

  Favourite(this.user, this.locatable, this.description);
}
