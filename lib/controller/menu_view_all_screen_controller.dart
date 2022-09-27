import 'package:citymall/controller/db_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuViewAllScreenController extends GetxController {
  final ScrollController scrollController =
      ScrollController(initialScrollOffset: 0);
  final DBDataController dbDataController = Get.find();
  var isLoading = false.obs;

  @override
  void onInit() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        debugPrint("******Start scrolling..");
        if (!(isLoading.value)) {
          isLoading.value = true;
          dbDataController
              .getMoreMenuMainCategories()
              .then((value) => isLoading.value = false);
        }
      }
    });
    super.onInit();
  }
}
