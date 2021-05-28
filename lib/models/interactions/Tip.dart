import 'package:goingto_app/models/accounts/user_profile.dart';
import 'package:goingto_app/models/geographic/locatable.dart';

class Tip {
  String text;
  Locatable locatable;
  UserProfile userProfile;

  Tip({required this.userProfile, required this.locatable, required this.text});

  factory Tip.fromJson(Map<String, dynamic> data) {
    return Tip(
      text: data['text'],
      userProfile: UserProfile.fromJson(data['userProfile']),
      locatable: Locatable.fromJson(data['locatable']),
    );
  }
}
