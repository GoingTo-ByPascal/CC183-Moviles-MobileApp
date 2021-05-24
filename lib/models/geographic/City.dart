import 'package:goingto_app/models/geographic/country.dart';
import 'package:goingto_app/models/geographic/locatable.dart';

class City {
  String name;
  String image;
  Country country;
  Locatable locatable;

  City(this.name, this.image, this.country, this.locatable);
}
