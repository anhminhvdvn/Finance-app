// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../Item_page_controller.dart';

// // ignore: must_be_immutable
// class UnselectedCategory extends StatelessWidget {
//   String title;
//   String category;
//   UnselectedCategory({
//     required this.title,
//     required this.category,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<ManageController>();
//     return SizedBox(
//       width: MediaQuery.of(context).size.width / 2,
//       height: 50,
//       child: GestureDetector(
//         onTap: () => controller.selectCategory(category),
//         child: Container(
//             // decoration: BoxDecoration(color: Colors.white),
//             child: Center(
//                 child: Text(title, style: const TextStyle(fontSize: 20)))),
//       ),
//     );
//   }
// }
