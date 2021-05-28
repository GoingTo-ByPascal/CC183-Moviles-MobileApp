class Achievement {
  String name;
  String text;
  int points;

  Achievement({required this.name, required this.text, required this.points});

  factory Achievement.fromJson(Map<String, dynamic> data) {
    return Achievement(
        name: data['name'], text: data['text'], points: data['points']);
  }
}
