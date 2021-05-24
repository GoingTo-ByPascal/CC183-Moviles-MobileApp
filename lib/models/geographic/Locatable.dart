import 'dart:ffi';
import 'package:goingto_app/models/geographic/LocatableType.dart';

class Locatable {
  String address;
  String description;
  Float latitude;
  Float longitude;
  LocatableType locatableType;

  Locatable(this.address, this.description, this.latitude, this.longitude,
      this.locatableType);
}
