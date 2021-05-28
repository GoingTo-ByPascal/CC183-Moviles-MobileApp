class Language {
  String shortName;
  String fullName;

  Language({required this.shortName, required this.fullName});

  factory Language.fromJson(Map<String, dynamic> data) {
    return Language(
      shortName: data['shortName'],
      fullName: data['fullName'],
    );
  }
}
