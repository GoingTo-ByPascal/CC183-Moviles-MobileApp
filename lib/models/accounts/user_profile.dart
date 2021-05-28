import 'package:goingto_app/models/accounts/user.dart';
import 'package:goingto_app/models/geographic/country.dart';

class UserProfile {
  String name;
  String surname;
  DateTime birthDate;
  String gender;
  DateTime createdAt;
  User? user;
  Country? country;

  UserProfile(
      {required this.name,
      required this.surname,
      required this.birthDate,
      required this.gender,
      required this.createdAt,
      this.user,
      this.country});

  factory UserProfile.fromJson(Map<String, dynamic> data) {
    return UserProfile(
      name: data['name'],
      surname: data['surname'],
      birthDate: data['birthDate'],
      gender: data['gender'],
      createdAt: data['createdAt'],
      user: User.fromJson(data['user']),
      country: Country.fromJson(data['country']),
    );
  }
}
