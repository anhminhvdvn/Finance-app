import 'package:baitaplon_mobile/firebase_options.dart';
import 'package:baitaplon_mobile/pages/dashboard/navigate_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/dashboard/dashboard_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      // initialBinding: BindingsBuilder(() {
      //   Get.put<BaseProvider>(BaseProvider()); // Khởi tạo BaseProvider
      // }),
      getPages: [
        GetPage(
          name: "/",
          page: () => NavigateBar(),
          binding: NavigateBarBinding(),
        ),
      ],
    ),
  );
}

// void main() async {

//   Get.put(DashboardController());
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: Colors.deepPurple,
//         ),
//         useMaterial3: true,
//       ),
//       home: NavigateBar(),
//     );
//   }
// }
