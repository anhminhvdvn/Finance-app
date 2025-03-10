import 'package:baitaplon_mobile/pages/home_page/component/head_info.dart';
import 'package:baitaplon_mobile/pages/home_page/component/history_box.dart';
import 'package:baitaplon_mobile/pages/home_page/component/large_container_info.dart';
import 'package:baitaplon_mobile/pages/home_page/home_controller.dart';
import 'package:baitaplon_mobile/shared_widget/background_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGroundWidget(
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              HeadInfo(),
              SizedBox(height: 20),
              LargeContainerInfo(),
              SizedBox(height: 20),
              Text(
                "Lịch sử",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30),
              ),
              HistoryBox(),
            ],
          ),
        ),
      ),
    );
  }
}
