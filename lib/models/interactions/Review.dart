import 'package:goingto_app/models/accounts/UserProfile.dart';
import 'package:goingto_app/models/geographic/locatable.dart';

class Review {
  UserProfile userProfile;
  Locatable locatable;
  String comment;
  int stars;
  DateTime reviewedAt;

  Review(this.userProfile, this.locatable, this.comment, this.stars,
      this.reviewedAt);
}
