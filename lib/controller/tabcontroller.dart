import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabviewController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void onInit() {
    tabController = TabController(vsync: this, length: 3, initialIndex: 0);
    super.onInit();
  }
}
