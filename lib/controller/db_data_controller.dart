import 'package:citymall/constant/collection_path.dart';
import 'package:citymall/model/advertisement.dart';
import 'package:citymall/model/auth_user.dart';
import 'package:citymall/model/brand.dart';
import 'package:citymall/model/main_category.dart';
import 'package:citymall/model/time_sale.dart';
import 'package:citymall/model/week_promotion.dart';
import 'package:citymall/server/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/product.dart';
import '../model/shop.dart';
import '../model/sub_category.dart';

class DBDataController extends GetxController {
  final _database = Database();

  RxMap<String, List<SubCategory>> subCategories =
      <String, List<SubCategory>>{}.obs;
  RxMap<String, bool> subCategoriesLoading = <String, bool>{}.obs;
  List<Brand> brands = [];
  List<Shop> shops = [];

  /// For Real Data */
  RxList<MainCategory> menuMainCategories = <MainCategory>[].obs;
  RxList<MainCategory> mainCategories = <MainCategory>[].obs;
  Rxn<TimeSale?> timeSale = Rxn<TimeSale?>();
  RxList<WeekPromotion> weekPromotions = <WeekPromotion>[].obs;
  RxList<Advertisement> advertisements = <Advertisement>[].obs;
  RxMap<String, List<Product>> products = <String, List<Product>>{}.obs;
  RxMap<String, List<Product>> discountProducts = <String, List<Product>>{}.obs;
  RxMap<String, List<Product>> popularProducts = <String, List<Product>>{}.obs;
  RxMap<String, List<Product>> newProducts = <String, List<Product>>{}.obs;
  RxMap<String, List<Product>> sliderProducts = <String, List<Product>>{}.obs;

  /// For Loading */
  RxMap<String, bool> productsLoading = <String, bool>{}.obs;
  RxMap<String, bool> discountProductsLoading = <String, bool>{}.obs;
  RxMap<String, bool> popularProductsLoading = <String, bool>{}.obs;
  RxMap<String, bool> newProductsLoading = <String, bool>{}.obs;
  RxMap<String, bool> sliderProductsLoading = <String, bool>{}.obs;
  var advertisementLoading = true.obs;
  var promotionsLoading = true.obs;
  var timeSaleLoading = true.obs;
  var mainCategoryLoading = false.obs;
  var menuMainCategoryLoading = true.obs;

  ///For temporary Data */
  List<AuthUser> authUsers = [];
  String mainId = "";
  String subId = "";
  String mainName = "";
  String subName = "";
  Product? editProduct;

  ///For temporary Function */
  void setEditProduct(Product? value) => editProduct = value;
  void setSelectedMain(String id, String name) {
    mainId = id;
    mainName = name;
  }

  void setSelectedSub(String id, String name) {
    subId = id;
    subName = name;
  }

  /// Main Category Fetch */
  Future<void> getInitialMainCategories() async {
    mainCategoryLoading.value = true;
    try {
      final result = await _database.getInitialWhere(
          mainCategoryCollection, "isMenu", false, 20);
      mainCategories.value =
          result.docs.map((e) => MainCategory.fromJson(e.data())).toList();
    } catch (e) {
      debugPrint("******Something was wrong with $e");
    }
    mainCategoryLoading.value = false;
  }

  Future<void> getMoreMenuMainCategories() async {
    try {
      final result = await _database.fetchMoreWhere(
          mainCategoryCollection, [mainCategories.last.id], "isMenu", true);
      List<MainCategory> list =
          result.docs.map((e) => MainCategory.fromJson(e.data())).toList();
      for (var element in list) {
        menuMainCategories.add(element);
      }
    } catch (e) {
      debugPrint("******Something was wrong with $e");
    }
  }

  Future<void> getInitialMenuMainCategories() async {
    try {
      final result = await _database.getInitialWhere(
          mainCategoryCollection, "isMenu", true, 20);
      menuMainCategories.value =
          result.docs.map((e) => MainCategory.fromJson(e.data())).toList();
    } catch (e) {
      debugPrint("******Something was wrong with $e");
    }
    menuMainCategoryLoading.value = false;
  }

  /// Sub Category Fetch */
  Future<void> getInitialSubCategories(String parentId) async {
    if (subCategories[parentId]?.isNotEmpty == true) {
      return;
    }
    subCategoriesLoading.putIfAbsent(parentId, () => true);
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
    subCategoriesLoading[parentId] = false;
  }

  /// Product Fetch */
  Future<void> getInitialDiscountProducts(String mainId,
      [int limit = 10]) async {
    if (!(discountProducts[mainId] == null) ||
        discountProducts[mainId]?.isNotEmpty == true) {
      return;
    }
    discountProductsLoading.putIfAbsent(mainId, () => true);
    try {
      final result = await _database.getInitialWhereTwo(productCollection,
          "mainCategoryId", mainId, "promotion", 0, "promotion");
      discountProducts.putIfAbsent(mainId,
          () => result.docs.map((e) => Product.fromJson(e.data())).toList());
    } catch (e) {
      debugPrint("Something went wrong with $e");
    }
    discountProductsLoading[mainId] = false;
  }

  Future<void> getInitialPopularProducts(String mainId,
      [int limit = 10]) async {
    if (!(popularProducts[mainId] == null) ||
        popularProducts[mainId]?.isNotEmpty == true) {
      return;
    }
    popularProductsLoading.putIfAbsent(mainId, () => true);
    try {
      final result = await _database.getInitialWhereTwo(productCollection,
          "mainCategoryId", mainId, "reviewCount", 4.0, "reviewCount");
      popularProducts.putIfAbsent(mainId,
          () => result.docs.map((e) => Product.fromJson(e.data())).toList());
    } catch (e) {
      debugPrint("Something went wrong with $e");
    }
    popularProductsLoading[mainId] = false;
  }

  Future<void> getInitialNewProducts(String mainId, [int limit = 10]) async {
    if (!(newProducts[mainId] == null) ||
        newProducts[mainId]?.isNotEmpty == true) {
      return;
    }
    newProductsLoading.putIfAbsent(mainId, () => true);
    try {
      final result = await _database.getInitialWhereTwo(
        productCollection,
        "mainCategoryId",
        mainId,
        "dateTime",
        DateTime.now().subtract(const Duration(days: 10)).toString(),
        "dateTime",
      );
      newProducts.putIfAbsent(mainId,
          () => result.docs.map((e) => Product.fromJson(e.data())).toList());
    } catch (e) {
      debugPrint("Something went wrong with $e");
    }
    newProductsLoading[mainId] = false;
  }

  Future<void> getSliderProducts(String mainCategoryId,
      [int limit = 10]) async {
    if (!(sliderProducts[mainCategoryId] == null) ||
        sliderProducts[mainCategoryId]?.isNotEmpty == true) {
      return;
    }
    sliderProductsLoading.putIfAbsent(mainCategoryId, () => true);
    try {
      final result = await _database.getInitialWhere(
          productCollection, "mainCategoryId", mainCategoryId);
      sliderProducts.putIfAbsent(mainCategoryId,
          () => result.docs.map((e) => Product.fromJson(e.data())).toList());
    } catch (e) {
      debugPrint("Something went wrong with $e");
    }
    sliderProductsLoading[mainCategoryId] = false;
  }

  Future<void> getInitialProducts(String subCategoryId,
      [int limit = 10]) async {
    if (!(products[subCategoryId] == null) ||
        products[subCategoryId]?.isNotEmpty == true) {
      return;
    }
    productsLoading.putIfAbsent(subCategoryId, () => true);
    try {
      final result = await _database.getInitialWhere(
          productCollection, "subCategoryId", subCategoryId);
      products.putIfAbsent(subCategoryId,
          () => result.docs.map((e) => Product.fromJson(e.data())).toList());
    } catch (e) {
      debugPrint("Something went wrong with $e");
    }
    productsLoading[subCategoryId] = false;
  }

  Future<void> getMoreProducts(String subCategoryId, List<String> startAfterId,
      [int limit = 10]) async {
    try {
      final result = await _database.fetchMoreWhere(
          productCollection, startAfterId, "subCategoryId", subCategoryId);
      final previousList = products[subCategoryId];
      for (var element in result.docs) {
        previousList?.add(Product.fromJson(element.data()));
      }
      products[subCategoryId] = previousList ?? [];
    } catch (e) {
      debugPrint("Something went wrong with $e");
    }
  }

  Future<void> getMoreDiscountProducts(
      String mainCategoryId, List<String> startAfterId,
      [int limit = 10]) async {
    try {
      final result = await _database.fetchMoreWhereTwo(productCollection,
          startAfterId, "mainCategoryId", mainCategoryId, "promotion", 0);
      final previousList = discountProducts[mainCategoryId];
      for (var element in result.docs) {
        previousList?.add(Product.fromJson(element.data()));
      }
      discountProducts[mainCategoryId] = previousList ?? [];
    } catch (e) {
      debugPrint("Something went wrong with $e");
    }
  }

  Future<void> getMorePopularProducts(
      String mainCategoryId, List<String> startAfterId,
      [int limit = 10]) async {
    try {
      final result = await _database.fetchMoreWhereTwo(productCollection,
          startAfterId, "mainCategoryId", mainCategoryId, "reviewCount", 4.0);
      final previousList = popularProducts[mainCategoryId];
      for (var element in result.docs) {
        previousList?.add(Product.fromJson(element.data()));
      }
      popularProducts[mainCategoryId] = previousList ?? [];
    } catch (e) {
      debugPrint("Something went wrong with $e");
    }
  }

  Future<void> getMoreNewProducts(
      String mainCategoryId, List<String> startAfterId,
      [int limit = 10]) async {
    try {
      final result = await _database.fetchMoreWhereTwo(
        productCollection,
        startAfterId,
        "mainCategoryId",
        mainCategoryId,
        "dateTime",
        DateTime.now().subtract(const Duration(days: 10)).toString(),
      );
      final previousList = newProducts[mainCategoryId];
      for (var element in result.docs) {
        previousList?.add(Product.fromJson(element.data()));
      }
      newProducts[mainCategoryId] = previousList ?? [];
    } catch (e) {
      debugPrint("Something went wrong with $e");
    }
  }

  @override
  void onInit() {
    getInitialMenuMainCategories();
    getInitialMainCategories();
    watchStream();
    super.onInit();
  }

  //Watch Stream */
  void watchStream() {
    _database.watchCollection(advertisementCollection).listen((event) {
      advertisements.value =
          event.docs.map((e) => Advertisement.fromJson(e.data())).toList();
      if (advertisementLoading.value) {
        advertisementLoading.value = false;
      }
    });
    _database.watchCollection(promotionCollection).listen((event) {
      weekPromotions.value =
          event.docs.map((e) => WeekPromotion.fromJson(e.data())).toList();
      if (promotionsLoading.value) {
        promotionsLoading.value = false;
      }
    });
    _database.watchCollectionWithoutOrder(timeSaleCollection).listen((event) {
      if (event.docs.isNotEmpty) {
        timeSale.value = TimeSale.fromJson(event.docs.first.data());
      }
      if (timeSaleLoading.value) {
        timeSaleLoading.value = false;
      }
    });
  }

  ///
}
