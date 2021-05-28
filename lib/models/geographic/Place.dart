import 'package:goingto_app/models/geographic/city.dart';
import 'package:goingto_app/models/geographic/locatable.dart';

class Place {
  String name;
  String image;
  int stars;
  City? city;
  Locatable? locatable;

  Place(
      {required this.name,
      required this.image,
      this.city,
      this.locatable,
      required this.stars});

  factory Place.fromJson(Map<String, dynamic> data) {
    return Place(
      name: data['name'],
      image: data['image'],
      stars: data['stars'],
      city: City.fromJson(data['city']),
      locatable: Locatable.fromJson(data['locatable']),
    );
  }
}
