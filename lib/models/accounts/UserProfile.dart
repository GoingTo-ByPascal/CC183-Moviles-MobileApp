import 'package:goingto_app/models/geographic/country.dart';

class UserProfile {
  Country country;
  String name;
  String surname;
  DateTime birthDate;
  User user;
  String gender;
  DateTime createdAt;

  UserProfile(this.country, this.name, this.surname, this.birthDate, this.user,
      this.gender, this.createdAt);
}
