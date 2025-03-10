import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared_widget/background_widget.dart';
import 'category_controller.dart';
import 'component/category_list.dart';
import 'component/category_selected.dart';
import 'component/category_unselected.dart';
import 'component/add_button.dart';

class CategoryPage extends GetView<CategoryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: addCategoryButton(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Get.to(() => AddCategoryScreen(
      //         categoryType: controller.income.value ? "Income" : "Expend",
      //       )),
      //   child: Icon(Icons.add),
      // ),
      body: BackGroundWidget(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 7,
              decoration: BoxDecoration(color: Color(0xFF031A6E)),
              padding: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Obx(() => controller.income.value
                      ? SelectedCategory(title: "Thu nhập")
                      : UnselectedCategory(
                          title: "Thu nhập", category: "Income")),
                  Obx(() => controller.spend.value
                      ? SelectedCategory(title: "Chi tiêu")
                      : UnselectedCategory(
                          title: "Chi tiêu", category: "Expend")),
                ],
              ),
            ),
            Expanded(child: CategoryList()),
          ],
        ),
      ),
    );
  }
}
