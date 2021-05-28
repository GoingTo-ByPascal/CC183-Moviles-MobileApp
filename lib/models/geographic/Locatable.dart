import 'package:goingto_app/models/geographic/locatable_type.dart';

class Locatable {
  String address;
  String description;
  double latitude;
  double longitude;
  LocatableType? locatableType;

  Locatable(
      {required this.address,
      required this.description,
      required this.latitude,
      required this.longitude,
      this.locatableType});

  factory Locatable.fromJson(Map<String, dynamic> data) {
    return Locatable(
      address: data['address'],
      description: data['description'],
      latitude: data['latitude'],
      longitude: data['longitud'],
      locatableType: LocatableType.fromJson(data['locatableType']),
    );
  }
}
