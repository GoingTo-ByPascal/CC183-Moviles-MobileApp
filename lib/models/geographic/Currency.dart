class Currency {
  String unit;
  String shortName;

  Currency({required this.unit, required this.shortName});

  factory Currency.fromJson(Map<String, dynamic> data) {
    return Currency(
      unit: data['unit'],
      shortName: data['shortName'],
    );
  }
}
