import 'package:baitaplon_mobile/pages/category_page/category_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home_page/home_page.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;

  final List<Widget> widgetOptions = [
    HomePage(),
    CategoryPage(),
  ];

  void changePage(int value) {
    selectedIndex.value = value;
  }
}
