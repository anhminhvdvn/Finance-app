import 'package:baitaplon_mobile/pages/item_page/Item_controller.dart';
import 'package:baitaplon_mobile/pages/item_page/component/bottom_calculator.dart';
import 'package:baitaplon_mobile/pages/item_page/component/item_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/category.dart';
import '../../shared_widget/background_widget.dart';
import 'component/add_item_button.dart';

class ItemPage extends GetView<ItemController> {
  final Category category;
  const ItemPage({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF031A6E), title: Text(category.title)),
      floatingActionButton: addItemButton(
        categoryId: category.id,
      ),
      body: BackGroundWidget(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ItemList(category: category),
            BottomCalculator(
              categoryId: category.id,
              category: category,
            ),
          ],
        ),
      ),
    );
  }
}
