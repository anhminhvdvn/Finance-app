import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/category.dart';
import '../db_services/firestore_service.dart';

class CategoryController extends GetxController {
  RxBool income = true.obs;
  RxBool spend = false.obs;
  final FirestoreService _firestoreService = FirestoreService();
  var categories = <Category>[].obs;

  final TextEditingController titleController = TextEditingController();
  final RxString selectedIcon = "📒".obs;
  final List<String> iconList = [
    "🍗",
    "🎥",
    "🎂",
    "🎁",
    "🍰",
    "🐶",
    "📒",
    "🏋",
    "👕",
    "🌭",
    "💲",
    "🎮"
  ];

  @override
  void onInit() {
    // ever(totalIncome, (_) => calculateBalance());
    // ever(totalSpend, (_) => calculateBalance());
    super.onInit();
  }

  @override
  void onReady() {
    // getOnTheLoad();
    fetchCategories("Income");
    super.onReady();
  }

  void selectCategory(String category) {
    income.value = category == "Income";
    spend.value = !income.value;
    fetchCategories(
      income.value ? "Income" : "Expend",
    );
    update();
  }

  void fetchCategories(String type) {
    _firestoreService.getCategories(type).listen((data) {
      categories.value = data;
    });
  }

  void addCategory() {
    if (titleController.text.isEmpty) {
      Get.snackbar("Lỗi", "Vui lòng nhập tên Category!");
      return;
    }
    Category category = Category(
      id: '',
      title: titleController.text,
      icon: selectedIcon.value,
      type: income.value ? "Income" : "Expend",
    );
    _firestoreService.addCategory(category);
    clearForm();
    Get.back();
  }

  void updateCategory(Category category) {
    if (titleController.text.isEmpty) {
      Get.snackbar("Lỗi", "Vui lòng nhập tên Category!");
      return;
    }

    Category updatedCategory = Category(
      id: category.id, // Giữ nguyên ID cũ
      title: titleController.text,
      icon: selectedIcon.value,
      type: category.type, // Không thay đổi loại
    );

    _firestoreService.updateCategory(updatedCategory);
    clearForm();
    Get.back();
  }

  // Xóa Category
  Future<void> deleteCategory(String id) async {
    // await _firestoreService.collection('categories').doc(categoryId).delete();
    await _firestoreService.deleteCategory(
      id,
    );
    Get.back();
    update();
  }

  void clearForm() {
    titleController.clear();
    selectedIcon.value = "📒";
  }
}
