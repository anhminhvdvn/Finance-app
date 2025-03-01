import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../manage_controller.dart';

class BottomCalculator extends StatelessWidget {
  const BottomCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ManageController>();
    final formatter = NumberFormat('#,###');
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(15),
        height: 90,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: Color(0xFF031A6E)),
        child: controller.income.value
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tổng thu nhập:",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                  Obx(
                    () => Text(
                      "${formatter.format(controller.totalIncome.value)} VNĐ", // Cập nhật giá trị totalIncome
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tổng chi tiêu:",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                  Obx(
                    () => Text(
                      "${formatter.format(controller.totalSpend.value)} VNĐ", // Cập nhật giá trị totalSpend
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
