import 'package:citymall/controller/db_data_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ActionScreenController extends GetxController {
  final ScrollController scrollController =
      ScrollController(initialScrollOffset: 0);
  final DBDataController dbDataController = Get.find();
  var isLoading = false.obs;

  @override
  void onInit() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!(isLoading.value)) {
          isLoading.value = true;
          final lastD = dbDataController.products[dbDataController.subId]?.last;
          debugPrint("******${lastD?.name}");
          dbDataController.getMoreProducts(dbDataController.subId, [
            lastD?.toJson()["dateTime"]
          ]).then((value) => isLoading.value = false);
        }
      }
    });
    super.onInit();
  }
}
