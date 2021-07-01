import 'dart:convert';

import 'package:goingto_app/models/geographic/Country.dart';

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());

class UserProfile {
  UserProfile({
    required this.id,
    required this.userId,
    required this.name,
    required this.surname,
    required this.birthDate,
    required this.gender,
    required this.createdAt,
    this.profilePhoto,
    required this.country,
  });
  int id;
  int userId;
  String name;
  String surname;
  String birthDate;
  String gender;
  String createdAt;
  String? profilePhoto;
  Country? country;

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        id: json["id"],
        userId: json["userId"],
        name: json["name"],
        surname: json["surname"],
        birthDate: json["birthDate"],
        gender: json["gender"],
        createdAt: json["createdAt"],
        profilePhoto: json["profilePhoto"],
        country: Country.fromJson(json["country"]),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "surname": surname,
        //"birthDate": birthDate,
        //"gender": gender,
        "createdAt": createdAt,
        //"profilePhoto": profilePhoto,
        //"country": country!.toJson(),
      };
}
