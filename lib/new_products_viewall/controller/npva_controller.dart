import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/db_data_controller.dart';
import '../../../server/database.dart';
import '../../model/product.dart';

enum PriceSortType {
  lowToHigh,
  highToLow,
  none,
}

class NPVAController extends GetxController {
  final DBDataController dataController = Get.find();
  final Database _database = Database();
  //**For Pagination */
  final ScrollController scrollController =
      ScrollController(initialScrollOffset: 0);
  var isLoading = false.obs;
  var discountPrice = 0.obs;

  @override
  void onInit() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!(isLoading.value)) {
          isLoading.value = true;
          dataController
              .getMoreNewProducts(
                dataController.mainId,
                dataController.newProducts[dataController.mainId]!.last
                    .toJson()["dateTime"],
              )
              .then((value) => isLoading.value = false);
        }
      }
    });
    super.onInit();
  }

  //**For Sort And Filtering... */
  final DBDataController dbDataController = Get.find();
  List<Product> dataList = [];
  var reviewIndex = 4.obs;
  var isSort = false.obs;
  var isSortLoading = false.obs;
  Rxn<PriceSortType> priceSortType = Rxn<PriceSortType>(PriceSortType.none);
  void changeReview(int rIndex) {
    reviewIndex.value = rIndex;
    priceSortType.value = PriceSortType.none;
  }

  void changePriceSortType(PriceSortType type) {
    priceSortType.value = type;
    reviewIndex.value = 4;
  }

  void resetSort() {
    isSort.value = false;
    priceSortType.value = PriceSortType.none;
    reviewIndex.value = 4;
  }

  void applySort() {
    dataList = dbDataController.newProducts[dbDataController.mainId]!;

    isSort.value = true;
    isSortLoading.value = true;
    //For Price
    switch (priceSortType.value) {
      case PriceSortType.lowToHigh:
        dataList.sort((a, b) => a.price.compareTo(b.price));
        dataList = dataList;
        break;
      case PriceSortType.highToLow:
        dataList.sort((a, b) => a.price.compareTo(b.price));
        dataList = dataList.reversed.toList();
        break;
      default:
    }
    //For Review Count
    switch (reviewIndex.value) {
      case 0:
        dataList = getSPBRC(4);
        break;
      case 1:
        dataList = getSPBRC(3);
        break;
      case 2:
        dataList = getSPBRC(2);
        break;
      case 3:
        dataList = getSPBRC(1);
        break;
      default:
        break;
    }
    isSortLoading.value = false;
  }

  List<Product> getSPBRC(int count) {
    List<Product> list = [];
    for (var e in dataList) {
      if (e.reviewCount >= count) {
        list.add(e);
      }
    }
    return list;
  }
  //**End */
}
