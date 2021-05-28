import 'package:goingto_app/models/geographic/country.dart';
import 'package:goingto_app/models/geographic/locatable.dart';

class City {
  String name;
  String image;
  Country? country;
  Locatable? locatable;

  City({required this.name, required this.image, this.country, this.locatable});

  factory City.fromJson(Map<String, dynamic> data) {
    return City(
      name: data['name'],
      image: data['image'],
      country: Country.fromJson(data['country']),
      locatable: Locatable.fromJson(data['locatable']),
    );
  }
}
