import 'package:goingto_app/models/accounts/UserProfile.dart';
import 'package:goingto_app/models/geographic/locatable.dart';

class Tip {
  UserProfile userProfile;
  Locatable locatable;
  String text;

  Tip(this.userProfile, this.locatable, this.text);
}
