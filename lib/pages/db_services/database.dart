import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/transaction_model.dart';

// class DatabaseService {
//   Future addInComeTask(Map<String, dynamic> userPersonalMap, String id) async {
//     return await FirebaseFirestore.instance
//         .collection("Income")
//         .doc(id)
//         .set(userPersonalMap);
//   }

//   Future addSpendTask(Map<String, dynamic> userPersonalMap, String id) async {
//     return await FirebaseFirestore.instance
//         .collection("Spend")
//         .doc(id)
//         .set(userPersonalMap);
//   }
// }

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Thêm giao dịch (Income hoặc Spend)
  Future<void> addTransaction(
      String collection, TransactionModel transaction) async {
    await _firestore
        .collection(collection)
        .doc(transaction.id)
        .set(transaction.toMap());
  }

  // Lấy danh sách giao dịch (Income hoặc Spend)
  Future<Stream<QuerySnapshot>> getTransactions(String collection) async {
    return _firestore
        .collection(collection)
        .orderBy('amount', descending: true)
        .snapshots();
  }

  // Xóa giao dịch
  Future<void> removeTransaction(String collection, String id) async {
    await _firestore.collection(collection).doc(id).delete();
  }

  // Cập nhật trạng thái xác nhận
  Future<void> updateTransaction(
      String collection, String id, bool status) async {
    await _firestore.collection(collection).doc(id).update({'Yes': status});
  }
}
