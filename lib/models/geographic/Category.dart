class Category {
  String name;

  Category({required this.name});

  factory Category.fromJson(Map<String, dynamic> data) {
    return Category(
      name: data['name'],
    );
  }
}
