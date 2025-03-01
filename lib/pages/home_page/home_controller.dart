import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../manage_page/manage_controller.dart';

class HomeController extends GetxController {
  final managecontroller = Get.find<ManageController>();

  RxString userName = "Phạm Ngọc Minh".obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    getMonthlyBalance();
    super.onReady();
  }

  Future<List<Map<String, dynamic>>> getMonthlyBalance() async {
    final firestore = FirebaseFirestore.instance;

    // Lấy dữ liệu từ Firestore
    final incomeSnapshot = await firestore.collection('Income').get();
    final spendSnapshot = await firestore.collection('Spend').get();

    // Chuyển dữ liệu thành Map dựa trên tháng
    Map<String, int> incomeByMonth = {};
    Map<String, int> spendByMonth = {};

    for (var doc in incomeSnapshot.docs) {
      final date = doc['date'] as String;
      final amount = doc['amount'] as int;
      final month = date.substring(3); // Lấy "MM/YYYY" từ ngày
      incomeByMonth[month] = (incomeByMonth[month] ?? 0) + amount;
    }

    for (var doc in spendSnapshot.docs) {
      final date = doc['date'] as String;
      final amount = doc['amount'] as int;
      final month = date.substring(3); // Lấy "MM/YYYY" từ ngày
      spendByMonth[month] = (spendByMonth[month] ?? 0) + amount;
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
