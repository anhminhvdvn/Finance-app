import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../manage_controller.dart';

class BottomCalculator extends StatelessWidget {
  const BottomCalculator({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ManageController());
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
                    "Số tiền thu nhập tháng này:",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                  Obx(
                    () => Text(
                      "${controller.totalIncome.value.toStringAsFixed(0)}.000 VNĐ", // Cập nhật giá trị totalIncome
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Số tiền chi tiêu tháng này:",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                    ),
                  ),
                  Obx(
                    () => Text(
                      "${controller.totalSpend.value.toStringAsFixed(3)} VNĐ", // Cập nhật giá trị totalSpend
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
