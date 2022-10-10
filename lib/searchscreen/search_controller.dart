import 'dart:developer';

import 'package:citymall/constant/collection_path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
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

  Future<void> scanBarCode() async {
    FlutterBarcodeScanner.scanBarcode(
            "#ff6666", "Cancel", false, ScanMode.DEFAULT)
        .then((value) async {
      if (value != "-1") {
        await searchWithBarCode(value);
      }
      log("********Barcode Scan Value: $value");
    }).catchError((e) {
      log("*****Error scan bar code");
    });
  }

  Future<void> searchWithBarCode(String value) async {
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
      log("********Fetching......***");
      final result = await FirebaseFirestore.instance
          .collection(productCollection)
          .where("barCode", isEqualTo: value)
          .get();
      log("********Result: ${result.docs.length}\n SearchValue: $value****");
      searchResultMap[value] =
          result.docs.map((e) => Product.fromJson(e.data())).toList();
      isSearching.value = false;
    } catch (e) {
      log("*******Error: $e");
      isSearching.value = false;
    }
  }

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
      log("********Fetching......***");
      final result = await FirebaseFirestore.instance
          .collection(productCollection)
          .where("nameArray", arrayContainsAny: [value.toLowerCase()]).get();
      log("********Result: ${result.docs.length}\n SearchValue: $value****");
      searchResultMap[value] =
          result.docs.map((e) => Product.fromJson(e.data())).toList();
      isSearching.value = false;
    } catch (e) {
      log("*******Error: $e");
      isSearching.value = false;
    }
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
