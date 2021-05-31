class Locatable {
  int id;
  String name;
  String address;
  String description;
  String bannerImage;
  double latitude;
  double longitude;
  int locatableTypeId;
  List<dynamic> locatableImages;

  Locatable({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.bannerImage,
    required this.latitude,
    required this.longitude,
    required this.locatableTypeId,
    required this.locatableImages,
  });
  factory Locatable.fromJson(Map<String, dynamic> json) => Locatable(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        description: json["description"],
        bannerImage: json["bannerImage"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        locatableTypeId: json["locatableTypeId"],
        locatableImages:
            List<dynamic>.from(json["locatableImages"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "description": description,
        "bannerImage": bannerImage,
        "latitude": latitude,
        "longitude": longitude,
        "locatableTypeId": locatableTypeId,
        "locatableImages": List<dynamic>.from(locatableImages.map((x) => x)),
      };
}
