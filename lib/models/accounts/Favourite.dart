import 'package:goingto_app/models/accounts/user.dart';
import 'package:goingto_app/models/geographic/locatable.dart';

class Favourite {
  User? user;
  String description;
  Locatable? locatable;

  Favourite({this.user, this.locatable, required this.description});

  factory Favourite.fromJson(Map<String, dynamic> data) {
    return Favourite(
      user: User.fromJson(data['user']),
      description: data['description'],
      locatable: Locatable.fromJson(data['locatable']),
    );
  }
}
