class TransactionModel {
  final String id;
  final String work;
  final int amount;
  final String date;
  final bool isConfirmed;

  TransactionModel({
    required this.id,
    required this.work,
    required this.amount,
    required this.date,
    required this.isConfirmed,
  });

  // Chuyển từ Map Firebase thành object
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['Id'] ?? '',
      work: map['work'] ?? '',
      amount: (map['amount'] ?? 0).toInt(),
      date: map['date'] ?? '',
      isConfirmed: map['Yes'] ?? false,
    );
  }

  // Chuyển từ object thành Map để lưu Firebase
  Map<String, dynamic> toMap() {
    return {
      'Id': id,
      'work': work,
      'amount': amount,
      'date': date,
      'Yes': isConfirmed,
    };
  }
}
