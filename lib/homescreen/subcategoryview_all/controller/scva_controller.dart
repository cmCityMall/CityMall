import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/db_data_controller.dart';
import '../../../server/database.dart';

class SCVAController extends GetxController {
  final DBDataController dataController = Get.find();
  final Database _database = Database();
  //**For Pagination */
  final ScrollController scrollController =
      ScrollController(initialScrollOffset: 0);
  var isLoading = false.obs;
  var isFetchMoreLoading = false.obs;
  var discountPrice = 0.obs;

  @override
  void onInit() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!(isLoading.value)) {
          isLoading.value = true;
          dataController
              .getMoreSubCategories(
                dataController.mainId,
                10,
              )
              .then((value) => isLoading.value = false);
        }
      }
    });
    super.onInit();
  }
}
