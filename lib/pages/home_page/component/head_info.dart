import 'package:baitaplon_mobile/pages/home_page/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeadInfo extends StatelessWidget {
  const HeadInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      12), // Áp dụng borderRadius cho hình ảnh
                  child: Image.asset(
                    "assets/images/avar7.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Wellcome Back,",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 12),
                  ),
                  Text(
                    controller.userName.value,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Chỉnh sửa tên"),
                content: TextField(
                  controller: controller.nameController,
                  decoration: InputDecoration(labelText: "Nhập tên mới"),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Hủy"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // if (controller.nameController.text.isNotEmpty) {
                      //   controller.addUser();
                      //   Get.back();
                      // }
                    },
                    child: Text("Lưu"),
                  ),
                ],
              ),
            ),
            child: const Icon(
              CupertinoIcons.gear_solid,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
