import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard_controller.dart';

class NavigateBar extends GetView<DashboardController> {
  NavigateBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.widgetOptions[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          elevation: 0,
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: Colors.red,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => controller.changePage(index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chart_bar_alt_fill),
              label: 'Quản lí',
            ),
          ],
        ),
      ),
    );
  }
}
