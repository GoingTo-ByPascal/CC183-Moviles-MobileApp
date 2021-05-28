import 'package:goingto_app/models/geographic/city.dart';
import 'package:goingto_app/models/geographic/Locatable.dart';

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

  factory Place.fromJson(Map<String, dynamic> data) {
    return Place(
      name: data['name'],
      image: data['image'],
      stars: data['stars'],
      locatable: Locatable.fromJson(data['locatable']),
      //city: map['city'],
    );
  }
}
