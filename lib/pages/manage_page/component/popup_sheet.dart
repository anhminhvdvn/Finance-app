import 'package:baitaplon_mobile/pages/manage_page/manage_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PopupSheet extends StatelessWidget {
  const PopupSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ManageController());
    return Container(
      padding: EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Add Task",
                  style: TextStyle(
                    color: Colors.greenAccent.shade400,
                  ),
                ),
                const SizedBox(
                  width: 60,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.cancel),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Thêm nội dung:",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  )),
              child: TextField(
                controller: controller.titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Nội dung",
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Thêm tiêu số tiền:",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  )),
              child: TextField(
                controller: controller.amountController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: ".000 VNĐ",
                ),
                keyboardType: TextInputType.number, // Chỉ cho phép nhập số
                inputFormatters: [
                  FilteringTextInputFormatter
                      .digitsOnly, // Chỉ cho phép nhập các ký tự số
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GestureDetector(
                  onTap: () {
                    controller.addToList();
                  },
                  child: const Center(
                    child: Text(
                      "Thêm",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
