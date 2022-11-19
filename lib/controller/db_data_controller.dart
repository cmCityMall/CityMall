import 'dart:developer';

import 'package:citymall/constant/collection_path.dart';
import 'package:citymall/model/advertisement.dart';
import 'package:citymall/model/auth_user.dart';
import 'package:citymall/model/brand.dart';
import 'package:citymall/model/favourite_item.dart';
import 'package:citymall/model/main_category.dart';
import 'package:citymall/model/time_sale.dart';
import 'package:citymall/model/week_promotion.dart';
import 'package:citymall/server/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constant/constant.dart';
import '../model/hive_personal_address.dart';
import '../model/product.dart';
import '../model/shop.dart';
import '../model/sub_category.dart';

class DBDataController extends GetxController {
  final _database = Database();
  Rxn<Product> selectedProduct = Rxn<Product>();
  Rxn<TimeSale> selectedTimeSale = Rxn<TimeSale>();
  Rxn<WeekPromotion> selectedWeekPromotion = Rxn<WeekPromotion>();
  RxMap<String, List<SubCategory>> subCategories =
      <String, List<SubCategory>>{}.obs;
  RxMap<String, bool> subCategoriesLoading = <String, bool>{}.obs;
  List<Brand> brands = [];
  List<Shop> shops = [];
  final Box<List<String>> addressKVBox =
      Hive.box<List<String>>(addressKeyValueBox);

  //**For Hive Personal Address */
  var selectedAddressId = "".obs;
  Rxn<HivePersonalAddress?> selectedHivePersonalAddress =
      Rxn<HivePersonalAddress?>(null);
  void setSelectedHivePersonalAddress(HivePersonalAddress? hp) =>
      selectedHivePersonalAddress.value = hp;
  void setSelectedAddressId(String id, String value) {
    selectedAddressId.value = id;
    addressKVBox.put(selectedAddressKey, [id, value]);
  }

  /// For Real Data */
  RxList<Product> homePopularProducts = <Product>[].obs;

  RxList<MainCategory> menuMainCategories = <MainCategory>[].obs;
  RxList<TimeSale> timeSales = <TimeSale>[].obs;
  RxList<WeekPromotion> weekPromotions = <WeekPromotion>[].obs;
  RxList<Advertisement> advertisements = <Advertisement>[].obs;
  RxMap<String, List<Product>> products = <String, List<Product>>{}.obs;
  RxMap<String, List<Product>> discountProducts = <String, List<Product>>{}.obs;
  RxMap<String, List<Product>> popularProducts = <String, List<Product>>{}.obs;
  RxMap<String, List<Product>> newProducts = <String, List<Product>>{}.obs;
  RxMap<String, List<Product>> sliderProducts = <String, List<Product>>{}.obs;
  RxMap<String, List<Product>> brandProducts = <String, List<Product>>{}.obs;
  RxMap<String, List<Product>> shopProducts = <String, List<Product>>{}.obs;

  RxList<Brand> brandRxList = <Brand>[].obs;
  RxList<Shop> shopRxList = <Shop>[].obs;

  /// For Loading */
  RxMap<String, bool> productsLoading = <String, bool>{}.obs;
  RxMap<String, bool> discountProductsLoading = <String, bool>{}.obs;
  RxMap<String, bool> popularProductsLoading = <String, bool>{}.obs;
  RxMap<String, bool> newProductsLoading = <String, bool>{}.obs;
  RxMap<String, bool> sliderProductsLoading = <String, bool>{}.obs;
  RxMap<String, bool> brandProductLoading = <String, bool>{}.obs;
  RxMap<String, bool> shopProductLoading = <String, bool>{}.obs;

  var advertisementLoading = true.obs;
  var promotionsLoading = true.obs;
  var timeSaleLoading = true.obs;
  var mainCategoryLoading = false.obs;
  var menuMainCategoryLoading = true.obs;
  var brandLoading = true.obs;
  var shopLoading = true.obs;

  ///For temporary Data */
  List<AuthUser> authUsers = [];
  Rxn<Brand> selectedBrand = Rxn<Brand>();
  Rxn<Shop> selectedShop = Rxn<Shop>();
  String mainId = "";
  String subId = "";
  String mainName = "";
  String subName = "";
  Product? editProduct;

  ///For temporary Function */
  void setSelectedTimeSale(TimeSale t) => selectedTimeSale.value = t;
  void setSelectedWeekPromotion(WeekPromotion w) =>
      selectedWeekPromotion.value = w;
  void setSelectedProduct(Product p) => selectedProduct.value = p;
  void setSelectedBrand(Brand brand) => selectedBrand.value = brand;
  void setSelectedShop(Shop shop) => selectedShop.value = shop;
  void setEditProduct(Product? value) => editProduct = value;
  void setSelectedMain(String id, String name) {
    mainId = id;
    mainName = name;
  }

  void setSelectedSub(String id, String name) {
    subId = id;
    subName = name;
  }

  Future<void> getMoreMenuMainCategories() async {
    try {
      final result = await _database.fetchMore(
          mainCategoryCollection, menuMainCategories.last.toJson()["dateTime"]);
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
      final result = await _database.getInitial(mainCategoryCollection, 20);
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
    if (!(discountProducts[mainId] == null) &&
        discountProducts[mainId]?.isNotEmpty == true) {
      return;
    }
    discountProductsLoading.putIfAbsent(mainId, () => true);
    try {
      log("*****Getting initial dicount product...***");
      final result = await _database.getInitialWhereTwo(productCollection,
          "mainCategoryId", mainId, "promotion", 0, "promotion");
      discountProducts.putIfAbsent(mainId,
          () => result.docs.map((e) => Product.fromJson(e.data())).toList());
      log("****Discount Product: ${discountProducts[mainId]?.length}");
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

  Future<void> getMoreSubCategories(String parentId, int limit) async {
    try {
      final result = await _database.fetchMoreWhere(
          subCategoryCollection,
          [subCategories[parentId]!.last.toJson()["dateTime"]],
          "parentId",
          parentId,
          limit);
      if (result.docs.isNotEmpty) {
        for (var e in result.docs) {
          subCategories[parentId]!.add(
            SubCategory.fromJson(e.data()),
          );
        }
      }
    } catch (e) {
      debugPrint("****Something is wrong with $e");
    }
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

  var homePopularProductsLoading = false.obs;
  //**For Popular Products Home Screen */
  Future<void> getInitialHomeProducts([int limit = 10]) async {
    homePopularProductsLoading.value = true;
    try {
      final result = await FirebaseFirestore.instance
          .collection(productCollection)
          .orderBy("reviewCount")
          .orderBy("name")
          .orderBy("dateTime")
          .where("reviewCount", isGreaterThanOrEqualTo: 3)
          .limit(limit)
          .get();
      homePopularProducts.value =
          result.docs.map((e) => Product.fromJson(e.data())).toList();
      debugPrint("******HomePopularProducts: ${homePopularProducts.length}");
    } catch (e) {
      debugPrint(
          "Something went wrong with in Get Initial Home Popular products $e");
    }
    homePopularProductsLoading.value = false;
  }

  Future<void> getMoreHomePopularProducts(List<Object> startAfterId,
      [int limit = 10]) async {
    try {
      debugPrint("**********LastHomeProductId: $startAfterId");
      final result = await FirebaseFirestore.instance
          .collection(productCollection)
          .orderBy("reviewCount")
          .orderBy("name")
          .orderBy("dateTime")
          .where("reviewCount", isGreaterThanOrEqualTo: 3)
          .startAfter(startAfterId)
          .limit(limit)
          .get();
      debugPrint("**********MoreHomePopularProducts: ${result.docs.length}");
      for (var element in result.docs) {
        homePopularProducts.add(Product.fromJson(element.data()));
      }
    } catch (e) {
      debugPrint("Something went wrong with $e");
    }
  }

  //**End */
  //**Get and Get More For Brands */
  Future<void> getInitialBrands() async {
    brandLoading.value = true;
    try {
      final result = await _database.getInitial(brandCollection, 15);
      brandRxList.value =
          result.docs.map((e) => Brand.fromJson(e.data())).toList();
    } catch (e) {
      debugPrint("*****Get Initial Brand Error: $e");
    }
    brandLoading.value = false;
  }

  Future<void> getMoreBrands(String dateTimeJson) async {
    try {
      final result = await _database.fetchMore(brandCollection, dateTimeJson);
      if (result.docs.isNotEmpty) {
        for (var element in result.docs) {
          brandRxList.add(Brand.fromJson(element.data()));
        }
      }
    } catch (e) {
      debugPrint("*****Get Initial Brand Error: $e");
    }
  }

  //**End */
  //**Get and Get More For Shops */
  Future<void> getInitialShops() async {
    shopLoading.value = true;
    try {
      final result = await _database.getInitial(shopCollection, 15);
      shopRxList.value =
          result.docs.map((e) => Shop.fromJson(e.data())).toList();
    } catch (e) {
      debugPrint("*****Get Initial Shop Error: $e");
    }
    shopLoading.value = false;
  }

  Future<void> getMoreShops(String dateTimeJson) async {
    try {
      final result = await _database.fetchMore(shopCollection, dateTimeJson);
      if (result.docs.isNotEmpty) {
        for (var element in result.docs) {
          shopRxList.add(Shop.fromJson(element.data()));
        }
      }
    } catch (e) {
      debugPrint("*****Get Initial Shop Error: $e");
    }
  }

  //**End */
  //**Get and Get More For BrandDetail and ShopDetail */
  Future<void> getInitialBrandProducts(String brandId, [int limit = 10]) async {
    if (!(brandProducts[brandId] == null) ||
        brandProducts[brandId]?.isNotEmpty == true) {
      return;
    }
    brandProductLoading.putIfAbsent(brandId, () => true);
    try {
      final result = await _database.getInitialWhere(
          productCollection, "brandId", brandId);
      brandProducts.putIfAbsent(brandId,
          () => result.docs.map((e) => Product.fromJson(e.data())).toList());
    } catch (e) {
      debugPrint("Something went wrong with $e");
    }
    brandProductLoading[brandId] = false;
  }

  Future<void> getMoreBrandProducts(String brandId, List<String> startAfterId,
      [int limit = 10]) async {
    try {
      final result = await _database.fetchMoreWhere(
          productCollection, startAfterId, "brandId", brandId);
      final previousList = brandProducts[brandId];
      for (var element in result.docs) {
        previousList?.add(Product.fromJson(element.data()));
      }
      brandProducts[brandId] = previousList ?? [];
    } catch (e) {
      debugPrint("Something went wrong with $e");
    }
  }

  Future<void> getInitialShopProducts(String shopId, [int limit = 10]) async {
    if (!(shopProducts[shopId] == null) ||
        shopProducts[shopId]?.isNotEmpty == true) {
      return;
    }
    shopProductLoading.putIfAbsent(shopId, () => true);
    try {
      final result =
          await _database.getInitialWhere(productCollection, "shopId", shopId);
      shopProducts.putIfAbsent(shopId,
          () => result.docs.map((e) => Product.fromJson(e.data())).toList());
    } catch (e) {
      debugPrint("Something went wrong with $e");
    }
    shopProductLoading[shopId] = false;
  }

  Future<void> getMoreShopProducts(String shopId, List<String> startAfterId,
      [int limit = 10]) async {
    try {
      final result = await _database.fetchMoreWhere(
          productCollection, startAfterId, "shopId", shopId);
      final previousList = shopProducts[shopId];
      for (var element in result.docs) {
        previousList?.add(Product.fromJson(element.data()));
      }
      shopProducts[shopId] = previousList ?? [];
    } catch (e) {
      debugPrint("Something went wrong with $e");
    }
  }

  //**End */
  late ByteData oleoBold;
  late ByteData cherryUnicode;
  @override
  Future<void> onInit() async {
    oleoBold = await rootBundle.load("fonts/OleoScriptSwashCaps-Bold.ttf");
    cherryUnicode = await rootBundle.load("fonts/Cherry_Unicode.ttf");
    final value = addressKVBox.get(selectedAddressKey);
    if (!(value == null)) {
      selectedAddressId.value = value.first[0];
    }
    getInitialMenuMainCategories();
    getInitialHomeProducts();
    getInitialShops();
    getInitialBrands();
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
        timeSales.value =
            event.docs.map((e) => TimeSale.fromJson(e.data())).toList();
      }
      if (timeSaleLoading.value) {
        timeSaleLoading.value = false;
      }
    });
  }

  ///
  ///For HiveBox Changing
  Product changeHiveToProduct(FavouriteItem item) {
    return Product(
      id: item.id,
      name: item.name,
      images: item.images,
      description: item.description,
      price: item.price,
      subCategoryId: item.subCategoryId,
      reviewCount: item.reviewCount,
      totalQuantity: item.totalQuantity,
      remainQuantity: item.remainQuantity,
      dateTime: item.dateTime,
    );
  }

  FavouriteItem changeProductToHive(Product p, String productType) {
    return FavouriteItem(
      id: p.id,
      barCode: p.barCode,
      brandId: p.brandId,
      dateTime: p.dateTime,
      description: p.description,
      images: p.images,
      mainCategoryId: p.mainCategoryId,
      name: p.name,
      nameArray: p.nameArray,
      price: p.price,
      productType: productType,
      promotion: p.promotion,
      promotionId: p.promotionId,
      remainQuantity: p.remainQuantity,
      reviewCount: p.reviewCount,
      saleCount: p.saleCount,
      shopId: p.shopId,
      sizeColorImagePrice: p.sizeColorImagePrice,
      subCategoryId: p.subCategoryId,
      totalQuantity: p.totalQuantity,
    );
  }

  //Get WeekPromotion
  WeekPromotion getWeekPromotion(String id) {
    return weekPromotions.where((p0) => p0.id == id).first;
  }

  //Get TimeSalePromotion
  TimeSale getTimeSale(String id) {
    return timeSales.where((p0) => p0.id == id).first;
  }

  String getProductType(String promotionId) {
    if (promotionId.isEmpty) {
      return normalProduct;
    }
    //First Search in WeekPromotions
    final resultFromWeek = weekPromotions.where((p0) => p0.id == promotionId);
    if (resultFromWeek.isNotEmpty) {
      //If match,we assign week
      return weekPromotionProduct;
    } else {
      //Second Search in TimeSale
      final resultFromTime = timeSales.where((p0) => p0.id == promotionId);
      if (resultFromTime.isNotEmpty) {
        return timeSaleProduct;
      }
    }
    return normalProduct;
  }

  //for home
  var isPopUp = false.obs;
  void changePopUp(bool value) => isPopUp.value = value;
}
