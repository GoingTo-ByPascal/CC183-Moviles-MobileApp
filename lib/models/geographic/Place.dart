import 'package:goingto_app/models/geographic/city.dart';
import 'package:goingto_app/models/geographic/locatable.dart';

class Place {
  String name;
  String image;
  City city;
  Locatable locatable;
  int stars;

  Place(this.name, this.image, this.city, this.locatable, this.stars);
}
