// import 'package:cloud_firestore/cloud_firestore.dart';

// class DataProcessor {
//   final List<QueryDocumentSnapshot> transactions;

//   DataProcessor(this.transactions);

//   // Lấy dữ liệu thu nhập/chi tiêu hàng tháng
//   Map<String, Map<String, double>> getMonthlyData() {
//     Map<String, Map<String, double>> monthlyData = {};

//     for (var transaction in transactions) {
//       var date = (transaction['date'] as Timestamp).toDate();
//       String monthYear = "${date.month}-${date.year}";
//       String type = transaction['type'];
//       double amount = transaction['amount'].toDouble();

//       // Đảm bảo không bị null
//       monthlyData[monthYear] ??= {'income': 0, 'expense': 0};
//       monthlyData[monthYear]![type] =
//           (monthlyData[monthYear]![type] ?? 0) + amount;
//     }

//     return monthlyData;
//   }

//   // Lấy dữ liệu thống kê theo danh mục
//   Map<String, double> getCategoryData(String monthYear) {
//     Map<String, double> categoryData = {};

//     for (var transaction in transactions) {
//       var date = (transaction['date'] as Timestamp).toDate();
//       String currentMonthYear = "${date.month}-${date.year}";
//       if (currentMonthYear == monthYear) {
//         String category = transaction['category'];
//         double amount = transaction['amount'].toDouble();

//         // Đảm bảo không bị null
//         categoryData[category] = (categoryData[category] ?? 0) + amount;
//       }
//     }

//     return categoryData;
//   }
// }
