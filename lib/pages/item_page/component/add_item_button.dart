import 'package:baitaplon_mobile/pages/item_page/Item_controller.dart';
import 'package:baitaplon_mobile/shared_widget/custom_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// ignore: camel_case_types
class addItemButton extends StatelessWidget {
  final String categoryId;
  const addItemButton({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ItemController>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3), // Độ mờ
        borderRadius: BorderRadius.circular(12),
      ),
      child: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => WillPopScope(
              onWillPop: () async {
                controller.clearForm();
                return true;
              },
              child: AlertDialog(
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Thêm mục mới",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.clearForm();
                              Get.back();
                            },
                            child: const Icon(Icons.cancel),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Nội dung:",
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        child: TextField(
                          controller: controller.titleController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Nội dung",
                          ),
                          keyboardType: TextInputType.text,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Số tiền:",
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                        child: TextField(
                          controller: controller.amountController,
                          keyboardType:
                              TextInputType.number, // Chỉ hiển thị bàn phím số
                          inputFormatters: [
                            FilteringTextInputFormatter
                                .digitsOnly, // Chỉ cho phép nhập số
                            NumberInputFormatter(), // Định dạng số với dấu phẩy
                          ],
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Số tiền',
                            hintText: 'Nhập số tiền...',
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Ngày:",
                        style: TextStyle(color: Colors.black),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.calendar,
                            size: 50,
                          ),
                          const SizedBox(width: 10),
                          Obx(() => GestureDetector(
                                onTap: () => controller.selectDate(context),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                    vertical: 15.0,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Text(
                                    controller.selectedDate.value == null
                                        ? "Chọn ngày"
                                        : DateFormat('dd/MM/yyyy').format(
                                            controller.selectedDate.value!),
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: GestureDetector(
                          onTap: () => controller.addItem(categoryId),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                "Thêm",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
  }
}
