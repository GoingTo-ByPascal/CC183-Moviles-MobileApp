import 'package:goingto_app/models/geographic/Locatable.dart';

class Country {
  String shortName;
  String fullName;
  String image;
  Locatable? locatable;

  Country(
      {required this.shortName,
      required this.fullName,
      required this.image,
      this.locatable});

  factory Country.fromJson(Map<String, dynamic> data) {
    return Country(
      shortName: data['shortName'],
      fullName: data['fullName'],
      image: data['image'],
      //locatable: Locatable.fromJson(data['locatable']),
      //city: map['city'],
    );
  }
}
