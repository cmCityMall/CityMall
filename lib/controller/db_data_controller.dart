import 'package:citymall/constant/collection_path.dart';
import 'package:citymall/constant/mock.dart';
import 'package:citymall/model/auth_user.dart';
import 'package:citymall/model/brand.dart';
import 'package:citymall/model/main_category.dart';
import 'package:citymall/model/week_promotion.dart';
import 'package:citymall/server/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../model/product.dart';
import '../model/shop.dart';
import '../model/sub_category.dart';

class DBDataController extends GetxController {
  final _database = Database();
  RxList<MainCategory> mainCategories = <MainCategory>[].obs;
  RxMap<String, List<SubCategory>> subCategories =
      <String, List<SubCategory>>{}.obs;
  List<Brand> brands = [];
  List<Shop> shops = [];
  List<WeekPromotion> weekPromotions = [];
  RxMap<String, List<Product>> products = <String, List<Product>>{}.obs;
  List<AuthUser> authUsers = [];
  String mainId = "";
  String subId = "";

  /**Function */
  void setSelectedMain(String id) => mainId = id;

  void setSelectedSub(String id) => subId = id;

  /**Main Category Fetch */
  Future<void> getInitialMainCategories() async {
    try {
      final result = await _database.getInitial(mainCategoryCollection);
      mainCategories.value =
          result.docs.map((e) => MainCategory.fromJson(e.data())).toList();
    } catch (e) {
      debugPrint("******Something was wrong with $e");
    }
  }

  /**Sub Category Fetch */
  Future<void> getSubCategories(String parentId) async {
    try {
      final result = await _database.getInitialWhere(
          subCategoryCollection, "parentId", parentId, 6);
      subCategories.putIfAbsent(
          parentId,
          () =>
              result.docs.map((e) => SubCategory.fromJson(e.data())).toList());
      debugPrint("****List: ${result.docs.length}");
      debugPrint("****ListInsideMap: ${subCategories[parentId]?.length}");
    } catch (e) {
      debugPrint("****Something is wrong with $e");
    }
  }

/**Product Fetch */
  Future<void> getInitialProducts(String subCategoryId,
      [int limit = 10]) async {
    try {
      final result = await _database.getInitialWhere(
          productCollection, "subCategoryId", subCategoryId);
      products.putIfAbsent(subCategoryId,
          () => result.docs.map((e) => Product.fromJson(e.data())).toList());
    } catch (e) {
      debugPrint("Something went wrong with $e");
    }
  }

  Future<void> getMoreProducts(String subCategoryId, List<String> startAfterId,
      [int limit = 10]) async {
    debugPrint("***StartAfterId: $startAfterId");
    debugPrint("***SubCategoryId: $subCategoryId");
    try {
      final result = await _database.fetchMoreWhere(
          productCollection, startAfterId, "subCategoryId", subCategoryId);
      final previousList = products[subCategoryId];
      debugPrint(
          "********ResultFirstProduct: ${Product.fromJson(result.docs.first.data()).name}");
      debugPrint(
          "********ResultLastProductID: ${Product.fromJson(result.docs.last.data()).id}");
      for (var element in result.docs) {
        previousList?.add(Product.fromJson(element.data()));
      }
      products[subCategoryId] = previousList ?? [];
    } catch (e) {
      debugPrint("Something went wrong with $e");
    }
  }

  @override
  void onInit() {
    getInitialMainCategories();
    super.onInit();
  }
}
