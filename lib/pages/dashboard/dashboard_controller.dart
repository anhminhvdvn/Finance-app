import 'package:baitaplon_mobile/pages/history_page/history_page.dart';
import 'package:baitaplon_mobile/pages/manage_page/manage_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home_page/home_page.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;

  List<Widget> widgetOptions = [
    const HomePage(),
    const ManagePage(),
    const HistoryPage(),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void changePage(int value) {
    selectedIndex.value = value;
  }
}
