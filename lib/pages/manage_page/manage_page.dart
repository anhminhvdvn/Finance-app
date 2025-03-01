import 'package:baitaplon_mobile/pages/manage_page/component/bottom_calculator.dart';
import 'package:baitaplon_mobile/pages/manage_page/component/category_unselected.dart';
import 'package:baitaplon_mobile/pages/manage_page/component/category_selected.dart';
import 'package:baitaplon_mobile/pages/manage_page/component/float_button.dart';
import 'package:baitaplon_mobile/shared_widget/background_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'component/list_object.dart';
import 'manage_controller.dart';

class ManagePage extends GetView<ManageController> {
  const ManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const FloatButton(),
      body: BackGroundWiget(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(() => controller.income.value
                      ? SelectedCategory(title: "Thu nhập")
                      : UnselectedCategory(
                          title: "Thu nhập", category: "Income")),
                  Obx(() => controller.spend.value
                      ? SelectedCategory(title: "Chi tiêu")
                      : UnselectedCategory(
                          title: "Chi tiêu", category: "Spend")),
                ],
              ),
              const ListObject(),
              const BottomCalculator(),
            ],
          ),
        ),
      ),
    );
  }
}
