import 'package:baitaplon_mobile/pages/category_page/component/change_button.dart';
import 'package:baitaplon_mobile/pages/item_page/item_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../item_page/Item_controller.dart';
import '../category_controller.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryController>();
    return Obx(() {
      return ListView.builder(
        itemCount: controller.categories.length,
        itemBuilder: (context, index) {
          final category = controller.categories[index];
          return GestureDetector(
            onTap: () {
              Get.to(() => ItemPage(category: category));
              Get.lazyPut<ItemController>(() => ItemController());
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(category.icon,
                            style: const TextStyle(fontSize: 40)),
                        const SizedBox(width: 20.0),
                        Text(
                          category.title.length > 14
                              ? "${category.title.substring(0, 14)}..."
                              : category.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ChangeButton(category: category),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 15.0),
                                        child: Center(
                                            child: Text(
                                          "Xóa mục này ?",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        )),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              controller
                                                  .deleteCategory(category.id);
                                              Get.back();
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 40.0,
                                                vertical: 8.0,
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: Colors.blueAccent),
                                              child: const Text(
                                                "Xóa",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 40.0,
                                                vertical: 8.0,
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: Colors.grey.shade200),
                                              child: const Text(
                                                'Hủy',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.redAccent,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
