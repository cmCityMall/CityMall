import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/collection_path.dart';
import '../model/product.dart';
import '../model/week_promotion.dart';
import '../server/database.dart';

class WeekPromotionControllerUser extends GetxController {
  final Database _database = Database();
  RxList<dynamic> selectedPromotionCondition = [].obs;
  Rxn<WeekPromotion> selectedWeekPromotion = Rxn<WeekPromotion>();
  RxMap<String, List<Product>> products = <String, List<Product>>{}.obs;
  RxMap<String, bool> productsLoading = <String, bool>{}.obs;

  //**For Pagination */
  final ScrollController scrollController =
      ScrollController(initialScrollOffset: 0);
  var isLoading = false.obs;
  //**End */

  void setSelectedWeekPromotion(WeekPromotion pro) =>
      selectedWeekPromotion.value = pro;
  Future<void> getInitialProducts(String weekProId, [int limit = 10]) async {
    if (!(products[weekProId] == null) ||
        products[weekProId]?.isNotEmpty == true) {
      return;
    }
    productsLoading.putIfAbsent(weekProId, () => true);
    try {
      final result = await _database.getInitialWhere(
          productCollection, "promotionId", weekProId);
      products.putIfAbsent(weekProId,
          () => result.docs.map((e) => Product.fromJson(e.data())).toList());
    } catch (e) {
      debugPrint("Something went wrong with $e");
    }
    productsLoading[weekProId] = false;
  }

  Future<void> getMoreProducts(String weekProId, List<String> startAfterId,
      [int limit = 10]) async {
    try {
      final result = await _database.fetchMoreWhere(
          productCollection, startAfterId, "promotionId", weekProId);
      final previousList = products[weekProId];
      for (var element in result.docs) {
        previousList?.add(Product.fromJson(element.data()));
      }
      products[weekProId] = previousList ?? [];
    } catch (e) {
      debugPrint("Something went wrong with $e");
    }
  }

  @override
  void onInit() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!(isLoading.value)) {
          isLoading.value = true;
          final lastD = products[selectedWeekPromotion.value!.id]?.last;
          debugPrint("******${lastD?.name}");
          getMoreProducts(selectedWeekPromotion.value!.id, [
            lastD?.toJson()["dateTime"]
          ]).then((value) => isLoading.value = false);
        }
      }
    });
    super.onInit();
  }
}
