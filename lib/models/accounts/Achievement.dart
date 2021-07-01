class Achievement {
  String name;
  String text;
  int points;
  String badge;
  Achievement(
      {required this.name,
      required this.text,
      required this.points,
      required this.badge});

  factory Achievement.fromJson(Map<String, dynamic> data) {
    return Achievement(
        name: data['name'],
        text: data['text'],
        points: data['points'],
        badge: data['badge']);
  }
}
