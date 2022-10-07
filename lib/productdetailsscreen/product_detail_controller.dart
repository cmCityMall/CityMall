import 'dart:developer';

import 'package:citymall/constant/collection_path.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/model/review.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../server/database.dart';

class ProductDetailController extends GetxController {
  final DBDataController dataController = Get.find();
  final Database _database = Database();
  RxList<Review> reviewList = <Review>[].obs;
  //**For Pagination */
  final ScrollController scrollController =
      ScrollController(initialScrollOffset: 0);
  var isLoading = false.obs;
  var isFetchMoreLoading = false.obs;
  var selectedColor = "".obs;
  var selectedSize = "".obs;
  var selectedPrice = 0.obs;
  var selectedImage = "".obs;
  set setSelectedImage(String v) => selectedImage.value = v;
  set setSelectedColor(String v) => selectedColor.value = v;
  set setSelectedSize(String v) => selectedSize.value = v;
  set setSelectedPrice(int v) => selectedPrice.value = v;

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
