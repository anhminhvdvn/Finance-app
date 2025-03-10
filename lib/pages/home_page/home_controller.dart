import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxString userName = 'Phạm Ngọc Minh'.obs;
  RxDouble totalIncome = 0.0.obs;
  RxDouble totalExpend = 0.0.obs;
  RxDouble balance = 0.0.obs;
  TextEditingController nameController = TextEditingController();
  final firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getMonthlyBalance();
    calculateTotalMoney();
    super.onReady();
  }

  /// 🔹 **Tính tổng toàn bộ số tiền của tất cả Categories**
  Future<void> calculateTotalMoney() async {
    double incomeSum = 0.0;
    double expendSum = 0.0;

    // Lấy danh sách tất cả các categories
    QuerySnapshot categorySnapshot =
        await firestore.collection('categories').get();

    for (var category in categorySnapshot.docs) {
      String categoryId = category.id;
      String type = category['type']; // "Income" hoặc "Expend"

      // Lấy tất cả các items thuộc category này
      QuerySnapshot itemSnapshot = await firestore
          .collection('items')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      for (var item in itemSnapshot.docs) {
        double amount = (item['amount'] ?? 0.0).toDouble();

        if (type == "Income") {
          incomeSum += amount;
        } else if (type == "Expend") {
          expendSum += amount;
        }
      }
    }

    totalIncome.value = incomeSum;
    totalExpend.value = expendSum;
    calculateBalance(); // Cập nhật balance sau khi tính tổng
  }

  /// 🔹 **Tính số dư (Balance)**
  void calculateBalance() {
    balance.value = totalIncome.value - totalExpend.value;
  }

  /// 🔹 **Tính tổng thu nhập và chi tiêu theo tháng**
  Future<List<Map<String, dynamic>>> getMonthlyBalance() async {
    // Lấy dữ liệu từ Firestore
    final itemSnapshot = await firestore.collection('items').get();

    // Chuyển dữ liệu thành Map dựa trên tháng
    Map<String, double> incomeByMonth = {};
    Map<String, double> spendByMonth = {};

    for (var doc in itemSnapshot.docs) {
      final date = doc['date'] as String;
      final amount = (doc['amount'] ?? 0.0).toDouble();
      final categoryId = doc['categoryId'];

      // Lấy loại category (Income hoặc Expend)
      final categoryDoc =
          await firestore.collection('categories').doc(categoryId).get();
      if (!categoryDoc.exists) continue;
      final categoryType = categoryDoc['type']; // "Income" hoặc "Expend"

      final month = date.substring(3); // Lấy "MM/YYYY" từ ngày

      if (categoryType == "Income") {
        incomeByMonth[month] = (incomeByMonth[month] ?? 0) + amount;
      } else {
        spendByMonth[month] = (spendByMonth[month] ?? 0) + amount;
      }
    }

    // Tổng hợp dữ liệu từ cả income và spend
    final allMonths = {...incomeByMonth.keys, ...spendByMonth.keys}.toList();
    allMonths.sort((a, b) {
      // Sắp xếp tháng theo thứ tự thời gian (mới nhất trước)
      final partsA = a.split('/'); // [MM, YYYY]
      final partsB = b.split('/');
      final dateA = DateTime(int.parse(partsA[1]), int.parse(partsA[0]));
      final dateB = DateTime(int.parse(partsB[1]), int.parse(partsB[0]));
      return dateB.compareTo(dateA); // Đảo ngược thứ tự
    });

    // Tạo danh sách kết quả
    List<Map<String, dynamic>> monthlyBalance = [];

    for (var month in allMonths) {
      final income = incomeByMonth[month] ?? 0;
      final spend = spendByMonth[month] ?? 0;

      monthlyBalance.add({
        "month": month,
        "income": income,
        "spend": spend,
        "balance": income - spend,
      });
    }

    return monthlyBalance;
  }
}
