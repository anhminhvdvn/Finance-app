import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future addInComeTask(Map<String, dynamic> userPersonalMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Income")
        .doc(id)
        .set(userPersonalMap);
  }

  Future addSpendTask(Map<String, dynamic> userPersonalMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Spend")
        .doc(id)
        .set(userPersonalMap);
  }
}
