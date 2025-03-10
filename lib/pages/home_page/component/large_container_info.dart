import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../home_controller.dart';

class LargeContainerInfo extends StatelessWidget {
  const LargeContainerInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final formatter = NumberFormat('#,###');
    return Obx(
      () => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xFF031A6E)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  const Text(
                    "SỐ DƯ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "${formatter.format(controller.balance.value)} VNĐ",
                    style: TextStyle(
                      color: controller.balance < 0
                          ? Colors.red // Màu đỏ khi balance < 0
                          // ignore: unrelated_type_equality_checks
                          : controller.balance == 0
                              ? Colors.white // Màu trắng khi balance == 0
                              : Colors.green, // Màu xanh lá khi balance > 0
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(
                              color: Colors.white30, shape: BoxShape.circle),
                          child: const Center(
                            child: Icon(
                              CupertinoIcons.arrow_up,
                              size: 12,
                              color: Colors.greenAccent,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Số thu nhập hiện tại: ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "${formatter.format(controller.totalIncome.value)} VNĐ ",
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          decoration: const BoxDecoration(
                              color: Colors.white30, shape: BoxShape.circle),
                          child: const Center(
                            child: Icon(
                              CupertinoIcons.arrow_down,
                              size: 12,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Số chi tiêu hiện tại: ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "${formatter.format(controller.totalExpend.value)} VNĐ ",
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
