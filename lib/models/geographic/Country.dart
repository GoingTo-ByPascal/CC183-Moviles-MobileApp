import 'package:goingto_app/models/geographic/Locatable.dart';

class Country {
  int id;
  String shortName;
  String fullName;
  String image;
  Locatable locatable;

  Country(
      {required this.id,
      required this.shortName,
      required this.fullName,
      required this.image,
      required this.locatable});

  factory Country.fromJson(Map<String, dynamic> data) {
    return Country(
      id: data["id"],
      shortName: data['shortName'],
      fullName: data['fullName'],
      image: data['image'],
      locatable: Locatable.fromJson(data['locatable']),
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "shortName": shortName,
        "fullName": fullName,
        "image": image,
        "locatable": locatable.toJson(),
      };
}
