import 'dart:ffi';

import 'package:goingto_app/models/geographic/locatable_type.dart';

class Locatable {
  int id;
  String address;
  String description;
  double? latitude;
  double? longitude;
  LocatableType? locatableType;

  Locatable(
      {required this.id,
      required this.address,
      required this.description,
      this.latitude,
      this.longitude,
      this.locatableType});

  factory Locatable.fromJson(Map<String, dynamic> data) {
    return Locatable(
      id: data['id'],
      address: data['address'],
      description: data['description'],
      //latitude: data['latitude'],
      //longitude: data['longitud'],
      //locatableType: LocatableType.fromJson(data['locatableType']),
    );
  }
}
