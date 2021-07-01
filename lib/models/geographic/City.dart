import 'package:goingto_app/models/geographic/country.dart';
import 'package:goingto_app/models/geographic/locatable.dart';

class City {
  int id;
  String name;
  String image;
  Country? country;
  Locatable? locatable;

  City(
      {required this.id,
      required this.name,
      required this.image,
      this.country,
      this.locatable});

  factory City.fromJson(Map<String, dynamic> data) {
    return City(
      id: data['id'],
      name: data['name'],
      image: data['image'],
      country: Country.fromJson(data['country']),
      locatable: Locatable.fromJson(data['locatable']),
    );
  }
}
