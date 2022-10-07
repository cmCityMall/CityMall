import 'dart:developer';

import 'package:citymall/constant/collection_path.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/model/review.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../server/database.dart';

class FSPDController extends GetxController {
  final DBDataController dataController = Get.find();
  final Database _database = Database();
  RxList<Review> reviewList = <Review>[].obs;
  //**For Pagination */
  final ScrollController scrollController =
      ScrollController(initialScrollOffset: 0);
  var isLoading = false.obs;
  var isFetchMoreLoading = false.obs;
  var discountPrice = 0.obs;

  Future<void> getInitialWhere() async {
    isLoading.value = true;
    try {
      await _database.getInitialWhere(
        reviewCollection,
        "productId",
        dataController.selectedProduct.value!.id,
      );
    } catch (e) {
      log("****Error: $e");
    }
    isLoading.value = false;
  }

  Future<void> fetchWhere(List<String> startAfterId) async {
    try {
      await _database.fetchMoreWhere(
        reviewCollection,
        startAfterId,
        "productId",
        dataController.selectedProduct.value!.id,
      );
    } catch (e) {
      log("****Error: $e");
    }
  }

  @override
  void onInit() {
    discountPrice.value = ((dataController.selectedProduct.value!.price / 100) *
            dataController.selectedTimeSale.value!.percentage!)
        .round();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!(isLoading.value)) {
          isLoading.value = true;
          final lastD = reviewList.last;
          fetchWhere([lastD.toJson()["dateTime"]])
              .then((value) => isLoading.value = false);
        }
      }
    });
    super.onInit();
  }
}
