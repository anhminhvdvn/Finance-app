import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../home_controller.dart';

class HistoryBox extends StatelessWidget {
  const HistoryBox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final formatter = NumberFormat('#,###');
    return Expanded(
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: controller.getMonthlyBalance(), // Hàm lấy dữ liệu từ Firestore
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Đã xảy ra lỗi: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Không có dữ liệu thống kê."),
            );
          }

          final data = snapshot.data!;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 4.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tháng: ${item['month']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                          "Khoản thu: ${formatter.format(item['income'])} VND"),
                      Text("Khoản chi: ${formatter.format(item['spend'])} VND"),
                      Text("Số dư: ${formatter.format(item['balance'])} VND"),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
