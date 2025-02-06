import 'package:baitaplon_mobile/pages/manage_page/component/bottom_calculator.dart';
import 'package:baitaplon_mobile/pages/manage_page/component/category_unselected.dart';
import 'package:baitaplon_mobile/pages/manage_page/component/category_selected.dart';
import 'package:baitaplon_mobile/pages/manage_page/component/float_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'component/list_object.dart';
import 'manage_controller.dart';

class ManagePage extends GetView<ManageController> {
  const ManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatButton(),
      // floatingActionButton: Container(
      //   decoration: BoxDecoration(
      //       color: Colors.grey.withOpacity(0.3),
      //       borderRadius: BorderRadius.circular(12)),
      //   child: FloatingActionButton(
      //     backgroundColor: Colors.transparent,
      //     elevation: 0.0,
      //     onPressed: () {
      //       controller.onTapPopup();
      //     },
      //     child: const Icon(
      //       Icons.add,
      //       color: Colors.white,
      //       size: 35,
      //     ),
      //   ),
      // ),
      body: Container(
        padding: const EdgeInsets.only(top: 70),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.blueAccent, Colors.pinkAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(() => controller.income.value
                    ? SelectedCategory(title: "Thu nhập")
                    : CategoryButton(title: "Thu nhập", category: "Income")),
                Obx(() => controller.spend.value
                    ? SelectedCategory(title: "Chi tiêu")
                    : CategoryButton(title: "Chi tiêu", category: "Spend")),
              ],
            ),
            const ListObject(),
            const BottomCalculator(),
          ],
        ),
      ),
    );
  }
}
