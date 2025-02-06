import 'package:baitaplon_mobile/pages/home_page/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final baseProvider = Get.find<BaseProvider>();
    return Scaffold(
      body: Obx(
        () => Container(
          padding: const EdgeInsets.only(top: 20),
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
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Wellcome Back,",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                        ),
                        Text(
                          controller.userName.value,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 26),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            12), // Áp dụng borderRadius cho hình ảnh
                        child: Image.asset(
                          "assets/images/avar7.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 300,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xFF031A6E)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              "SỐ DƯ : ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${controller.managecontroller.balance.toStringAsFixed(3)} VNĐ",
                              style: TextStyle(
                                color: controller.managecontroller.balance < 0
                                    ? Colors.red // Màu đỏ khi balance < 0
                                    // ignore: unrelated_type_equality_checks
                                    : controller.managecontroller.balance == 0
                                        ? Colors
                                            .white // Màu trắng khi balance == 0
                                        : Colors
                                            .green, // Màu xanh lá khi balance > 0
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Số chi tiêu hiện tại: ",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "${controller.managecontroller.totalSpend.toStringAsFixed(3)} VNĐ ",
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Số thu nhập hiện tại: ",
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              "${controller.managecontroller.totalIncome.toStringAsFixed(3)} VNĐ ",
                              style: const TextStyle(color: Colors.green),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
