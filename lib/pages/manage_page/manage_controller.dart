import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:intl/intl.dart';
import '../../model/transaction_model.dart';
import '../db_services/database.dart';

class ManageController extends GetxController {
  RxBool income = true.obs;
  RxBool spend = false.obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  Rx<Stream?> taskStream = Rx<Stream?>(null);

  RxDouble totalIncome = 0.0.obs;
  RxDouble totalSpend = 0.0.obs;
  RxDouble balance = 0.0.obs;

  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final formatter = NumberFormat('#,###');

  final DatabaseService _dbService = DatabaseService();

////////////////////////////////////////////////////////////////////////////////

  @override
  void onInit() {
    ever(totalIncome, (_) => calculateBalance());
    ever(totalSpend, (_) => calculateBalance());
    super.onInit();
  }

  @override
  void onReady() {
    getOnTheLoad();
    super.onReady();
  }

////////////////////////////////////////////////////////////////////////////////

  Future<void> getOnTheLoad() async {
    taskStream.value = await _dbService.getTransactions(
      income.value ? "Income" : "Spend",
    );
    await calculateTotal("Income", totalIncome);
    await calculateTotal("Spend", totalSpend);
    update();
  }

  void selectCategory(String category) {
    income.value = category == "Income";
    spend.value = !income.value;
    getOnTheLoad();
  }

  Future<void> calculateTotal(String collection, RxDouble total) async {
    double sum = 0;
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection(collection).get();
    for (var doc in snapshot.docs) {
      double amount = (doc['amount'] ?? 0.0).toDouble();
      sum += amount;
    }
    total.value = sum;
  }

  void calculateBalance() {
    balance.value = totalIncome.value - totalSpend.value;
  }

  void addTransaction() {
    if (titleController.text.isEmpty || amountController.text.isEmpty) {
      Get.snackbar(
        "Lỗi",
        "Vui lòng điền đầy đủ thông tin!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (selectedDate.value == null) {
      Get.snackbar(
        "Lỗi",
        "Vui lòng chọn ngày!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    String id = randomAlphaNumeric(10);
    int parsedAmount = int.parse(amountController.text.replaceAll(',', ''));
    TransactionModel transaction = TransactionModel(
      id: id,
      work: titleController.text,
      amount: parsedAmount, // Lưu giá trị không có dấu phẩy
      date: DateFormat('dd/MM/yyyy').format(selectedDate.value!),
      isConfirmed: false,
    );

    _dbService.addTransaction(
      income.value ? "Income" : "Spend",
      transaction,
    );

    clearForm();
    Get.back();
    getOnTheLoad();
  }

  void clearForm() {
    titleController.clear();
    amountController.clear();
    selectedDate.value = null;
  }

  Future<void> removeTransaction(String id) async {
    await _dbService.removeTransaction(
      income.value ? "Income" : "Spend",
      id,
    );
    getOnTheLoad();
  }

  Future<void> updateTransaction(String id, bool status) async {
    await _dbService.updateTransaction(
      income.value ? "Income" : "Spend",
      id,
      status,
    );
    getOnTheLoad();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      selectedDate.value = picked;
    }
  }
}
