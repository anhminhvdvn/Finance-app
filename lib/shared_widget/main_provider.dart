// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// class BaseProvider extends GetxController {
//   // Dữ liệu dùng chung
//   RxString userName = "Phạm Ngọc Minh".obs;
//   RxDouble totalIncome = 0.0.obs;
//   RxDouble totalSpend = 0.0.obs;
//   RxDouble balance = 0.0.obs;

//   Rx<Stream?> taskStream = Rx<Stream?>(null);
//   @override
//   void onInit() {
//     ever(totalIncome, (_) => calculateBalance());
//     ever(totalSpend, (_) => calculateBalance());
//     super.onInit();
//   }

//   @override
//   void onReady() {
//     getOnTheLoad();
//     super.onReady();
//   }

//   Future<void> getOnTheLoad() async {
//     await calculateTotalIncome();
//     await calculateTotalSpend();
//     calculateBalance();
//     update();
//   }

// ///////////////////////////////CACULATOR////////////////////////////////////////
//   Future<void> calculateTotalIncome() async {
//     int total = 0;
//     QuerySnapshot snapshot =
//         await FirebaseFirestore.instance.collection('Income').get();
//     for (var doc in snapshot.docs) {
//       int amount = int.tryParse(doc['amount'] ?? '0') ?? 0;
//       total += amount;
//     }
//     totalIncome.value = total.toDouble(); // Cập nhật giá trị của totalIncome
//   }

//   Future<void> calculateTotalSpend() async {
//     int total = 0;
//     QuerySnapshot snapshot =
//         await FirebaseFirestore.instance.collection('Spend').get();
//     for (var doc in snapshot.docs) {
//       int amount = int.tryParse(doc['amount'] ?? '0') ?? 0;
//       total += amount;
//     }
//     totalSpend.value = total.toDouble(); // Cập nhật giá trị của totalSpend
//   }

//   void calculateBalance() {
//     balance.value = totalIncome.value - totalSpend.value;
//   }
// ////////////////////////////////////////////////////////////////////////////////
// }
