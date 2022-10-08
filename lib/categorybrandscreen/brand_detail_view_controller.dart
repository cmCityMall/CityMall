import 'package:citymall/controller/db_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrandDetailViewController extends GetxController {
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
          final lastD = dataController
              .brandProducts[dataController.selectedBrand.value!.id]!.last;
          dataController.getMoreBrandProducts(
            dataController.selectedBrand.value!.id,
            [lastD.toJson()["dateTime"]],
          ).then((value) => isLoading.value = false);
        }
      }
    });
    super.onInit();
  }
}
