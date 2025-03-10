import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../model/category.dart';
import '../Item_controller.dart';

class BottomCalculator extends StatelessWidget {
  final String categoryId;
  final Category category;

  const BottomCalculator(
      {super.key, required this.categoryId, required this.category});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ItemController>();
    final formatter = NumberFormat('#,###');

    // Đảm bảo tổng tiền của category này được tính khi widget được tạo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.calculateTotal(categoryId, controller.total);
    });

    return Obx(
      () => Container(
        padding: const EdgeInsets.all(15),
        height: 90,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Color(0xFF031A6E)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tổng số tiền:",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
            Text(
              "${formatter.format(controller.total.value)} VNĐ",
              style: TextStyle(
                color:
                    category.type == "Income" ? Colors.green : Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
