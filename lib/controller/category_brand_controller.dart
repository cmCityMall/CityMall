import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'db_data_controller.dart';

class CategoryBrandController extends GetxController {
  final DBDataController dataController = Get.find();
  //**For Pagination */
  final ScrollController scrollController =
      ScrollController(initialScrollOffset: 0);
  var isLoading = false.obs;
  //**End */

  @override
  void onInit() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!(isLoading.value)) {
          isLoading.value = true;
          final lastD = dataController.brandRxList.last;
          dataController
              .getMoreBrands(
                lastD.toJson()["dateTime"],
              )
              .then((value) => isLoading.value = false);
        }
      }
    });
    super.onInit();
  }
}
