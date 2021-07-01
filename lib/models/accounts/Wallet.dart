class Wallet {
  int points;

  Wallet({required this.points});

  factory Wallet.fromJson(Map<String, dynamic> data) {
    return Wallet(
      points: data['points'],
    );
  }
}
