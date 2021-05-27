import 'package:goingto_app/models/geographic/city.dart';
import 'package:goingto_app/models/geographic/locatable.dart';

class Place {
  String name;
  String image;
  City? city;
  Locatable? locatable;
  int stars;

  Place(
      {required this.name,
      required this.image,
      this.city,
      this.locatable,
      required this.stars});

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      name: map['name'],
      image: map['image'],
      stars: map['stars'],
    );
  }
}
