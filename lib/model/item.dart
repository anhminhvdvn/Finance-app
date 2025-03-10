class Item {
  String id;
  String categoryId;
  String title;
  int amount;
  String date;

  Item({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'title': title,
      'amount': amount,
      'date': date,
    };
  }

  factory Item.fromMap(String id, Map<String, dynamic> map) {
    return Item(
      id: id,
      categoryId: map['categoryId'],
      title: map['title'],
      amount: map['amount'],
      date: map['date'] ?? '',
    );
  }
}
