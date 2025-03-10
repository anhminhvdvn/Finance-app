class Category {
  String id;
  String title;
  String icon;
  // String color;
  String type; // "Income" hoặc "Expend"

  Category({
    required this.id,
    required this.title,
    required this.icon,
    // required this.color,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'icon': icon,
      // 'color': color,
      'type': type,
    };
  }

  factory Category.fromMap(String id, Map<String, dynamic> map) {
    return Category(
      id: id,
      title: map['title'],
      icon: map['icon'],
      // color: map['color'],
      type: map['type'],
    );
  }
}
