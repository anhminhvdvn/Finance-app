import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../model/item.dart';
import '../db_services/firestore_service.dart';
import '../home_page/home_controller.dart';

class ItemController extends GetxController {
  RxBool income = true.obs;
  RxBool spend = false.obs;

  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  Rx<Stream?> taskStream = Rx<Stream?>(null);

  // RxDouble totalIncome = 0.0.obs;
  // RxDouble totalSpend = 0.0.obs;
  RxDouble total = 0.0.obs;

  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  final formatter = NumberFormat('#,###');

  final FirestoreService _firestoreService = FirestoreService();
  var items = <Item>[].obs;
  final _homeController = Get.find<HomeController>();

////////////////////////////////////////////////////////////////////////////////

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getOnTheLoad();
    super.onReady();
  }

////////////////////////////////////////////////////////////////////////////////

  Future<void> getOnTheLoad() async {
    taskStream.value = await _firestoreService.getCategories(
      income.value ? "Income" : "Spend",
    );
    _homeController.calculateBalance();
    await _homeController.calculateTotalMoney();
    update();
  }

  void selectCategory(String category) {
    income.value = category == "Income";
    spend.value = !income.value;
    getOnTheLoad();
  }

  Future<void> calculateTotal(String categoryId, RxDouble total) async {
    double sum = 0;

    QuerySnapshot itemSnapshot = await FirebaseFirestore.instance
        .collection('items')
        .where('categoryId', isEqualTo: categoryId)
        .get();

    for (var doc in itemSnapshot.docs) {
      double amount = (doc['amount'] ?? 0.0).toDouble();
      sum += amount;
    }

    total.value = sum;
  }

  void fetchItems(String categoryId) {
    _firestoreService.getItems(categoryId).listen((data) {
      items.value = data;
      calculateTotal(
          categoryId, total); // Cập nhật tổng số tiền cho Category này
    });
  }

  void addItem(String categoryId) {
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

    int parsedAmount = int.parse(amountController.text.replaceAll(',', ''));
    Item item = Item(
      id: '',
      categoryId: categoryId,
      title: titleController.text,
      amount: parsedAmount, // Lưu giá trị không có dấu phẩy
      date: DateFormat('dd/MM/yyyy').format(selectedDate.value!),
    );
    _firestoreService.addItem(item);

    clearForm();
    Get.back();
    getOnTheLoad();
  }

  Future<void> deleteItem(String id) async {
    await _firestoreService.deleteItem(
      id,
    );
    Get.back();
    getOnTheLoad();
    update();
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

  void clearForm() {
    titleController.clear();
    amountController.clear();
    selectedDate.value = null;
  }
  //////////////////////////////////////////////////////////////////////
  //   final firestore = FirebaseFirestore.instance;
  //     RxDouble totalIncome = 0.0.obs;
  // RxDouble totalExpend = 0.0.obs;
  // RxDouble balance = 0.0.obs;
  // /// 🔹 **Tính tổng toàn bộ số tiền của tất cả Categories**
  // Future<void> calculateTotalMoney() async {
  //   double incomeSum = 0.0;
  //   double expendSum = 0.0;

  //   // Lấy danh sách tất cả các categories
  //   QuerySnapshot categorySnapshot =
  //       await firestore.collection('categories').get();

  //   for (var category in categorySnapshot.docs) {
  //     String categoryId = category.id;
  //     String type = category['type']; // "Income" hoặc "Expend"

  //     // Lấy tất cả các items thuộc category này
  //     QuerySnapshot itemSnapshot = await firestore
  //         .collection('items')
  //         .where('categoryId', isEqualTo: categoryId)
  //         .get();

  //     for (var item in itemSnapshot.docs) {
  //       double amount = (item['amount'] ?? 0.0).toDouble();

  //       if (type == "Income") {
  //         incomeSum += amount;
  //       } else if (type == "Expend") {
  //         expendSum += amount;
  //       }
  //     }
  //   }

  //   totalIncome.value = incomeSum;
  //   totalExpend.value = expendSum;
  //   calculateBalance(); // Cập nhật balance sau khi tính tổng
  // }

  // /// 🔹 **Tính số dư (Balance)**
  // void calculateBalance() {
  //   balance.value = totalIncome.value - totalExpend.value;
  // }

  // /// 🔹 **Tính tổng thu nhập và chi tiêu theo tháng**
  // Future<List<Map<String, dynamic>>> getMonthlyBalance() async {
  //   // Lấy dữ liệu từ Firestore
  //   final itemSnapshot = await firestore.collection('items').get();

  //   // Chuyển dữ liệu thành Map dựa trên tháng
  //   Map<String, double> incomeByMonth = {};
  //   Map<String, double> spendByMonth = {};

  //   for (var doc in itemSnapshot.docs) {
  //     final date = doc['date'] as String;
  //     final amount = (doc['amount'] ?? 0.0).toDouble();
  //     final categoryId = doc['categoryId'];

  //     // Lấy loại category (Income hoặc Expend)
  //     final categoryDoc =
  //         await firestore.collection('categories').doc(categoryId).get();
  //     if (!categoryDoc.exists) continue;
  //     final categoryType = categoryDoc['type']; // "Income" hoặc "Expend"

  //     final month = date.substring(3); // Lấy "MM/YYYY" từ ngày

  //     if (categoryType == "Income") {
  //       incomeByMonth[month] = (incomeByMonth[month] ?? 0) + amount;
  //     } else {
  //       spendByMonth[month] = (spendByMonth[month] ?? 0) + amount;
  //     }
  //   }

  //   // Tổng hợp dữ liệu từ cả income và spend
  //   final allMonths = {...incomeByMonth.keys, ...spendByMonth.keys}.toList();
  //   allMonths.sort((a, b) {
  //     // Sắp xếp tháng theo thứ tự thời gian (mới nhất trước)
  //     final partsA = a.split('/'); // [MM, YYYY]
  //     final partsB = b.split('/');
  //     final dateA = DateTime(int.parse(partsA[1]), int.parse(partsA[0]));
  //     final dateB = DateTime(int.parse(partsB[1]), int.parse(partsB[0]));
  //     return dateB.compareTo(dateA); // Đảo ngược thứ tự
  //   });

  //   // Tạo danh sách kết quả
  //   List<Map<String, dynamic>> monthlyBalance = [];

  //   for (var month in allMonths) {
  //     final income = incomeByMonth[month] ?? 0;
  //     final spend = spendByMonth[month] ?? 0;

  //     monthlyBalance.add({
  //       "month": month,
  //       "income": income,
  //       "spend": spend,
  //       "balance": income - spend,
  //     });
  //   }

  //   return monthlyBalance;
  // }
}
