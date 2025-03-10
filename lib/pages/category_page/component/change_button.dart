import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/category.dart';
import '../category_controller.dart';

class ChangeButton extends StatelessWidget {
  final Category category;
  const ChangeButton({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryController>();
    // ignore: no_leading_underscores_for_local_identifiers
    void _showIconPicker(BuildContext context) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(16),
            height: 300,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 cột trong lưới
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: controller.iconList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.selectedIcon.value = controller.iconList[index];
                    Get.back(); // Đóng modal
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: controller.selectedIcon.value ==
                                controller.iconList[index]
                            ? Colors.blue
                            : Colors.grey,
                        width: 2,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      controller.iconList[index],
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
    }

    return GestureDetector(
      onTap: () => showDialog(
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
                        "Sửa mục này",
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
                        hintText: 'Tên mục',
                      ),
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => _showIconPicker(context),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Chọn Icon:",
                              style: TextStyle(fontSize: 16)),
                          Obx(() => Text(controller.selectedIcon.value,
                              style: const TextStyle(fontSize: 30))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () => controller.updateCategory(category),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Lưu",
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
      ),
      child: const Icon(Icons.border_color),
    );
  }
}
