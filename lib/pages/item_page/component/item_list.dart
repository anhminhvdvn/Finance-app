import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../model/category.dart';
import '../Item_controller.dart';

class ItemList extends StatelessWidget {
  final Category category;
  ItemList({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ItemController>();
    // Gọi fetchItems() một lần khi widget được tạo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchItems(category.id);
    });
    return Obx(
      () {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  thickness: 1, // Độ dày của Divider
                  color: Colors.grey.shade300, // Màu sắc của Divider
                  indent: 20, // Khoảng cách thụt vào từ bên trái
                  endIndent: 20, // Khoảng cách thụt vào từ bên phải
                ),
                shrinkWrap: true,
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  final item = controller.items[index];
                  // DocumentSnapshot docSnap = snapshot.data.docs[index];
                  final formatter = NumberFormat('#,###');
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: Image.asset(
                                    "assets/images/2.0x/ic_recharge_active.png"),
                              ),
                              const SizedBox(width: 20.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Số Tiền: ",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      Text(
                                        '${formatter.format(item.amount)} vnđ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: category.type == "Income"
                                                ? Colors.green
                                                : Colors.redAccent),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
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
                                              padding:
                                                  EdgeInsets.only(bottom: 15.0),
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
                                                        .deleteItem(item.id);
                                                    Get.back();
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 40.0,
                                                      vertical: 8.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color:
                                                            Colors.blueAccent),
                                                    child: const Text(
                                                      "Xóa",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 40.0,
                                                      vertical: 8.0,
                                                    ),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        color: Colors
                                                            .grey.shade200),
                                                    child: const Text(
                                                      'Hủy',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                child: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.redAccent,
                                ),
                              ),
                              Text(
                                item.date,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black),
                              )
                            ],
                          )
                        ]),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
