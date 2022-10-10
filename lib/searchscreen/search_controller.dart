import 'dart:developer';

import 'package:citymall/constant/collection_path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constant/constant.dart';
import '../model/product.dart';

class SearchController extends GetxController {
  RxMap<String, List<Product>> searchResultMap = <String, List<Product>>{}.obs;
  FocusNode focusNode = FocusNode();
  var searchBox = Hive.box<String>(searchHistoryBox);
  var isFocus = false.obs;
  var isSearching = false.obs;
  var searchValue = "".obs;

  Future<void> search(String value) async {
    searchValue.value = value;
    searchBox.put(value, value);
    if (searchResultMap.containsKey(value) &&
        searchResultMap[value]!.isNotEmpty) {
      //If already search not need to search again temporarily
      return;
    }
    //Else Start Search
    isSearching.value = true;
    try {
      final result = await FirebaseFirestore.instance
          .collection(productCollection)
          .where("name", arrayContainsAny: [value]).get();

      searchResultMap.putIfAbsent(value,
          () => result.docs.map((e) => Product.fromJson(e.data())).toList());
    } catch (e) {
      log("*******Error: $e");
    }
    isSearching.value = false;
  }

  void removeFromHistoryBox(String key) => searchBox.delete(key);

  @override
  void onInit() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        isFocus.value = true;
      } else {
        isFocus.value = false;
      }
    });
    super.onInit();
  }
}
