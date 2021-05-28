class LocatableType {
  String name;

  LocatableType({required this.name});

  factory LocatableType.fromJson(Map<String, dynamic> data) {
    return LocatableType(
      name: data['name'],
    );
  }
}
