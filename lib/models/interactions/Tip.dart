import 'package:goingto_app/models/accounts/user_profile.dart';
import 'dart:convert';

Tip tipFromJson(String str) => Tip.fromJson(json.decode(str));
String tipToJson(Tip data) => json.encode(data.toJson());

class Tip {
  String text;
  int? locatable;
  UserProfile? userProfile;

  Tip({this.userProfile, this.locatable, required this.text});

  factory Tip.fromJson(Map<String, dynamic> json) {
    return Tip(
      text: json['text'],
      //userProfile: UserProfile.fromJson(data['userProfile']),
      //locatable: data['locatable'],
    );
  }

  Map<String, dynamic> toJson() => {"text": text};
}
