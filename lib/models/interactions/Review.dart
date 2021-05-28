import 'package:goingto_app/models/accounts/user_profile.dart';
import 'package:goingto_app/models/geographic/locatable.dart';

class Review {
  String comment;
  int stars;
  DateTime? reviewedAt;
  UserProfile? userProfile;
  Locatable? locatable;

  Review({
    required this.comment,
    required this.stars,
    this.reviewedAt,
    this.userProfile,
    this.locatable,
  });

  factory Review.fromJson(Map<String, dynamic> data) {
    return Review(
      comment: data['comment'],
      stars: data['stars'],
      //reviewedAt: data['reviewedAt'],
      //userProfile: UserProfile.fromJson(data['userProfile']),
      locatable: Locatable.fromJson(data['locatable']),
    );
  }
}
