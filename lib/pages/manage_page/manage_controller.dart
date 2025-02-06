import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';

import '../db_services/database.dart';
import 'component/float_button.dart';

class ManageController extends GetxController {
  RxBool income = true.obs;
  RxBool spend = false.obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  Rx<Stream?> taskStream = Rx<Stream?>(null);

  RxDouble totalIncome = 0.0.obs;
  RxDouble totalSpend = 0.0.obs;
  RxDouble balance = 0.0.obs;

////////////////////////////////////////////////////////////////////////////////
  @override
  void onInit() {
    ever(totalIncome, (_) => calculateBalance());
    ever(totalSpend, (_) => calculateBalance());
    // ever(productPrice, (_) => calculateTotalSpent());
    // ever(quantity, (_) => calculateTotalSpent());
    super.onInit();
  }

  @override
  void onReady() {
    getOnTheLoad();
    // fetchProducts();
    super.onReady();
  }

////////////////////////////////////////////////////////////////////////////////
  Future<Stream<QuerySnapshot>> getTask(String task) async {
    return await FirebaseFirestore.instance
        .collection(task)
        .orderBy('amount', descending: true)
        .snapshots();
  }

  void selectCategory(String category) {
    if (category == "Income") {
      income.value = true;
      spend.value = false;
    } else {
      income.value = false;
      spend.value = true;
    }
    getOnTheLoad();
  }

  Future<void> getOnTheLoad() async {
    // taskStream.value = await DatabaseService().getTask(
    taskStream.value = await getTask(
      income.value ? "Income" : "Spend",
    );
    await calculateTotalIncome();
    await calculateTotalSpend();
    update();
  }

  tickMethod(String id, String task) async {
    return await FirebaseFirestore.instance
        .collection(task)
        .doc(id)
        .update({"Yes": true});
  }

  removeMethod(String id, String task) async {
    await FirebaseFirestore.instance.collection(task).doc(id).delete();
    getOnTheLoad();
  }

///////////////////////////////CACULATOR////////////////////////////////////////
  Future<void> calculateTotalIncome() async {
    double total = 0; // Sử dụng kiểu double nếu số có thể có phần thập phân
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Income').get();
    for (var doc in snapshot.docs) {
      double amount =
          (doc['amount'] ?? 0.0).toDouble(); // Truyền thẳng giá trị là số
      total += amount;
    }
    totalIncome.value = total; // Cập nhật giá trị của totalIncome
  }

  Future<void> calculateTotalSpend() async {
    double total = 0;
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Spend').get();
    for (var doc in snapshot.docs) {
      double amount =
          (doc['amount'] ?? 0.0).toDouble(); // Truyền thẳng giá trị là số
      total += amount;
    }
    totalSpend.value = total; // Cập nhật giá trị của totalSpend
  }

  void calculateBalance() {
    balance.value = totalIncome.value - totalSpend.value;
  }
////////////////////////////////////////////////////////////////////////////////

  void onTapPopup() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: Get.context!,
        builder: (context) {
          return FloatButton();
        });
    update();
  }

  void addToList() {
    String id = randomAlphaNumeric(10);
    Map<String, dynamic> userTask = {
      "work": titleController.text,
      "amount": int.tryParse(amountController.text) ?? 0.0,
      "Id": id,
      "Yes": false,
    };

    income.value
        ? DatabaseService().addInComeTask(userTask, id)
        : DatabaseService().addSpendTask(userTask, id);
    titleController.clear();
    amountController.clear();
    Get.back();
    getOnTheLoad();
  }
}
