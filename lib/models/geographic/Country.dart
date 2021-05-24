import 'package:goingto_app/models/geographic/Locatable.dart';

class Country {
  String shortName;
  String fullName;
  String image;
  Locatable locatable;

  Country(this.shortName, this.fullName, this.image, this.locatable);
}
