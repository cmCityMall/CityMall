import 'dart:async';
import 'dart:io';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/model/cips.dart';
import 'package:citymall/model/main_category.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../colors/hexandcolor.dart';
import '../../../constant/collection_path.dart';
import '../../../model/brand.dart';
import '../../../model/product.dart';
import '../../../model/shop.dart';
import '../../../model/sub_category.dart';
import '../../../server/database.dart';
import '../../../show_loading/show_loading.dart';

enum ProductStatusType {
  none,
  nEW,
  recommend,
}

class ProductController extends GetxController {
  final _database = Database();
  final DBDataController _dataController = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxList<Product> products = <Product>[].obs;
  RxList<Product> searchItems = <Product>[].obs;
  RxList<String> removeImageList = <String>[].obs;
  RxList<Brand> brands = <Brand>[].obs;
  RxList<Shop> shops = <Shop>[].obs;
  RxList<MainCategory> mainCategories = <MainCategory>[].obs;

  RxList<SubCategory> subCategories = <SubCategory>[].obs;
  final TextEditingController editingController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController totalQuantityController = TextEditingController();
  final TextEditingController remainQuantityController =
      TextEditingController();
  RxMap<String, CIPS> colorImagePriceSize = <String, CIPS>{}.obs;

  var isSearch = false.obs;
  var isFile = false.obs;
  //Selected Type
  RxList<String> pickedImage = <String>[].obs;
  var selectedBrandId = "".obs;
  var selectedSubCategoryId = "".obs;
  var selectedMainCategoryId = "".obs;
  var selectedShopId = "".obs;
  var selectedPromotionId = "".obs;
  //Error
  var pickedImageError = <String>[].obs;
  var selectedBrandIdError = "".obs;
  var selectedSubCategoryIdError = "".obs;
  var selectedMainCategoryIdError = "".obs;
  var selectedShopIdError = "".obs;
  var selectedPromotionIdError = "".obs;
  //Temporary
  var isLoading = true.obs;
  var isFirstTimePressed = false.obs;
  //
  Future<void> setSelectedMainCategoryId(String value) async {
    selectedMainCategoryId.value = value;
    await fetchSubCategories();
  }

  Future<void> fetchSubCategories() async {
    debugPrint("****Fetching sub categori.....");
    try {
      _database.firestore
          .collection(subCategoryCollection)
          .where("parentId",
              isEqualTo: mainCategories
                  .where((p0) => p0.name == selectedMainCategoryId.value)
                  .first
                  .id)
          .get()
          .then((value) {
        debugPrint("****Fetching Success: ${value.docs.length}");
        if (value.docs.isNotEmpty) {
          subCategories.value =
              value.docs.map((e) => SubCategory.fromJson(e.data())).toList();
        } else {
          subCategories.value = [];
        }
      });
    } catch (e) {
      debugPrint("******Fetching Error: $e");
    }
  }

  void setSelectedSubCategoryId(String vaue) =>
      selectedSubCategoryId.value = vaue;
  void setSelectedBrandId(String value) => selectedBrandId.value = value;
  void setSelectedShopId(String value) => selectedShopId.value = value;
  void setSelectedPromotionId(String value) {
    selectedPromotionId.value = value;
  }

  //Error
  void setSelectedMainCategoryIdError(String value) =>
      selectedMainCategoryIdError.value = value;
  void setSelectedSubCategoryIdError(String vaue) =>
      selectedSubCategoryIdError.value = vaue;
  void setSelectedBrandIdError(String value) =>
      selectedBrandIdError.value = value;
  void setSelectedShopIdError(String value) =>
      selectedShopIdError.value = value;
  void setSelectedPromotionIdError(String value) =>
      selectedPromotionIdError.value = value;
  //

  String? validate(String? value, String label) {
    if (!(value == null) && value.isNotEmpty) {
      return null;
    } else {
      return "$label is required";
    }
  }

  void deleteImage(String path) {
    pickedImage.remove(path);
    removeImageList.add(path);
  }

  void onSearch(String name) {
    isSearch.value = true;
    searchItems.value = products
        .where((p0) => p0.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  Future<void> configureForEditProduct() async {
    if (_dataController.editProduct == null) {
      isLoading.value = false;
    } else {
      final product = _dataController.editProduct!;
      isLoading.value = true;
      nameController.text = product.name;
      descriptionController.text = product.description;
      priceController.text = product.price.toString();
      totalQuantityController.text = (product.totalQuantity).toString();
      remainQuantityController.text = (product.remainQuantity).toString();
      pickedImage.value = product.images;
      if (!(product.sizeColorImagePrice == null) ||
          product.sizeColorImagePrice?.isNotEmpty == true) {
        for (var element in product.sizeColorImagePrice!.entries) {
          colorImagePriceSize.putIfAbsent(
              element.key,
              () => CIPS.initial().copyWith(
                    color: element.value["color"] as String,
                    image: element.value["image"],
                    price: TextEditingController(
                        text: element.value["price"].toString()),
                    size: TextEditingController(text: element.value["size"]),
                  ));
        }
      }
      //Selected Type
      if (!(product.brandId == null) && product.brandId!.isNotEmpty) {
        selectedBrandId.value =
            brands.where((e) => e.id == product.brandId).first.name;
      }
      if (!(product.shopId == null) && product.shopId!.isNotEmpty) {
        selectedShopId.value =
            shops.where((e) => e.id == product.shopId).first.name;
      }
      if (!(product.promotionId == null) && product.promotionId!.isNotEmpty) {
        selectedPromotionId.value = _dataController.weekPromotions
            .where((e) => e.id == product.promotionId)
            .first
            .desc;
      }

      if (!(product.mainCategoryId == null) &&
          product.mainCategoryId!.isNotEmpty) {
        selectedMainCategoryId.value = mainCategories
            .where((e) => e.id == product.mainCategoryId)
            .first
            .name;
      }
      fetchSubCategories().then((value) {
        if (subCategories.isNotEmpty && product.subCategoryId.isNotEmpty) {
          selectedSubCategoryId.value = subCategories
              .where((e) => e.id == product.subCategoryId)
              .first
              .name;
        }
        isLoading.value = false;
      });
    }
  }

  pickSizeImage(String key) async {
    try {
      final XFile? images = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (!(images == null)) {
        colorImagePriceSize[key] = colorImagePriceSize[key]!.copyWith(
          image: images.path,
          isFileImage: true,
        );
      }
    } catch (e) {
      debugPrint("******Size Image Picking");
    }
  }

  void addColorImagePriceSize() {
    colorImagePriceSize.putIfAbsent(
      Uuid().v1(),
      () => CIPS(
        color: colorList[0],
        image: "",
        isFileImage: true,
        price: TextEditingController(text: "0"),
        size: TextEditingController(),
      ),
    );
  }

  void removeColorImagePriceSize(String key) {
    colorImagePriceSize.remove(key);
  }

  void changeSizeColor(String key, String value) {
    colorImagePriceSize[key] = colorImagePriceSize[key]!.copyWith(color: value);
  }

  void clearAll() {
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    totalQuantityController.clear();
    remainQuantityController.clear();
    pickedImage.value = [];
    selectedBrandId.value = "";
    selectedShopId.value = "";
    selectedMainCategoryId.value = "";
    selectedSubCategoryId.value = "";
    selectedPromotionId.value = "";
    colorImagePriceSize.clear();
    isFile.value = false;
  }

  Future<void> delete(String id) async {
    await _database.delete(
      collectionPath: productCollection,
      documentPath: id,
    );
  }

  bool checkSelectType() {
    if (pickedImage.isEmpty ||
        selectedBrandId.isEmpty ||
        selectedSubCategoryId.isEmpty ||
        selectedMainCategoryId.isEmpty ||
        selectedShopId.isEmpty ||
        selectedPromotionId.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void clearSearch() {
    editingController.clear();
    isSearch.value = false;
  }

  Future<List<String>> uploadMultipleImages(
      List<File> images, String productId) async {
    final List<String> resultImages = [];
    if (images.isEmpty) {
      //Check for edit
      return resultImages;
    }
    for (var element in images) {
      await FirebaseStorage.instance
          .ref()
          .child("products/$productId/${Uuid().v1()}")
          .putFile(element)
          .then((snapshot) async {
        await snapshot.ref
            .getDownloadURL()
            .then((value) => resultImages.add(value));
      });
    }
    return resultImages;
  }

  Future<void> edit() async {
    //final element = _homeController.editProduct!;
    if (formKey.currentState?.validate() == true && checkSelectType()) {
      showLoading();
      /* try {
        if (isFile.value) {
          final images = pickedImage.map<File>((e) => File(e)).toList();
          await uploadMultipleImages(images, element.id).then((value) async {
            final product = Product(
              id: element.id,
              name: nameController.text,
              image: value,
              discountPrice: int.parse(discountController.text),
              requirePoint: int.parse(requirePointController.text),
              rating: _homeController.editProduct.value?.rating ?? 0.0,
              description: descriptionController.text,
              features: featuresController.text,
              price: int.parse(priceController.text),
              status: statusType.value,
              parentId: subCategories
                  .where((e) => e.name == selectedSubCategoryName.value)
                  .first
                  .id,
              brandId: brands
                  .where((e) => e.name == selectedBrandName.value)
                  .first
                  .id,
              dateTime: DateTime.now(),
            );
            await _database.write(
              collectionPath: productsCollection,
              documentPath: product.id,
              data: product.toJson(),
            );
          });
          hideLoading();
          Get.back();
        } else {
          final product = Product(
            id: element.id,
            name: nameController.text,
            image: pickedImage,
            discountPrice: int.parse(discountController.text),
            requirePoint: int.parse(requirePointController.text),
            rating: _homeController.editProduct.value?.rating ?? 0.0,
            description: descriptionController.text,
            features: featuresController.text,
            price: int.parse(priceController.text),
            status: statusType.value,
            parentId: subCategories
                .where((e) => e.name == selectedSubCategoryName.value)
                .first
                .id,
            brandId:
                brands.where((e) => e.name == selectedBrandName.value).first.id,
            dateTime: DateTime.now(),
          );
          await _database.write(
            collectionPath: productsCollection,
            documentPath: product.id,
            data: product.toJson(),
          );
          hideLoading();
          Get.back();
        }
      } catch (e) {
        hideLoading();
        Get.snackbar("Failed!", "Try again.");
      } */
    }
  }

  Future<void> save() async {
    isFirstTimePressed.value = true;
    var mainId = "";
    var subId = "";
    var brandId = "";
    var shopId = "";
    var promoId = "";
    var promotion = 0;
    var tQuantity = 0;
    var rQuantity = 0;
    var name = nameController.text;
    var desc = descriptionController.text;
    var price = int.tryParse(priceController.text) ?? 0;
    try {
      mainId = mainCategories
          .where((e) => e.name == selectedMainCategoryId.value)
          .first
          .id;
      subId = subCategories
          .where((e) => e.name == selectedSubCategoryId.value)
          .first
          .id;
      brandId = brands.where((e) => e.name == selectedBrandId.value).first.id;
      shopId = shops.where((e) => e.name == selectedShopId.value).first.id;
      promoId = _dataController.weekPromotions
          .where((e) => e.desc == selectedPromotionId.value)
          .first
          .id;
      promotion = _dataController.weekPromotions
              .where((e) => e.desc == selectedPromotionId.value)
              .first
              .percentage ??
          0;
      tQuantity = int.parse(totalQuantityController.text.removeAllWhitespace);
      rQuantity = int.parse(remainQuantityController.text.removeAllWhitespace);
    } catch (e) {
      debugPrint("******$e");
    }

    if (formKey.currentState?.validate() == true && checkSelectType()) {
      showLoading();
      try {
        final id = _dataController.editProduct == null
            ? Uuid().v1()
            : _dataController.editProduct!.id;
        List<File> images = [];
        if (isFile.value) {
          //Check for save and edit
          images = pickedImage.map<File>((e) => File(e)).toList();
        }
        await uploadMultipleImages(images, id).then((value) async {
          uploadIfSizeImage(id).then((v) async {
            var sizeMap = <String, dynamic>{};
            if (colorImagePriceSize.isNotEmpty) {
              //check for empty sizemap\
              for (var element in colorImagePriceSize.entries) {
                sizeMap.putIfAbsent(
                    element.key,
                    () => {
                          "color": element.value.color,
                          "image": element.value.image,
                          "price": element.value.price.text,
                          "size": element.value.size.text,
                        });
              }
            }
            debugPrint("**SizeMap: $sizeMap");
            final product = Product(
              id: id,
              name: name,
              images: value.isNotEmpty ? value : pickedImage,
              description: desc,
              price: price,
              promotion: promotion,
              promotionId: promoId,
              mainCategoryId: mainId,
              subCategoryId: subId,
              shopId: shopId,
              brandId: brandId,
              reviewCount: 0,
              totalQuantity: tQuantity,
              remainQuantity: rQuantity,
              sizeColorImagePrice: sizeMap,
              dateTime: DateTime.now(),
            );
            await _database.write(
              collectionPath: productCollection,
              documentPath: product.id,
              data: product.toJson(),
            );
            isFirstTimePressed.value = false;
          });

          clearAll();
          hideLoading();
        });
      } catch (e) {
        hideLoading();
        Get.snackbar("Failed!", "Try Again");

        debugPrint("****$e");
      }
    } else {
      debugPrint("****Not valid");
    }
  }

  pickImage() async {
    try {
      final List<XFile>? images = await ImagePicker().pickMultiImage();
      if (!(images == null) && images.isNotEmpty) {
        pickedImage.value = images.map((e) => e.path).toList();
        isFile.value = true;
      }
    } catch (e) {
      isFile.value = false;
      debugPrint("Error Bank Slip Image Picking");
    }
  }

  @override
  void onInit() {
    _database.watchCollectionWithoutOrder(productCollection).listen((event) {
      if (event.docs.isNotEmpty) {
        products.value =
            event.docs.map((e) => Product.fromJson(e.data())).toList();
      }
    });
    _database.firestore.collection(shopCollection).get().then((value) =>
        shops.value = value.docs.map((e) => Shop.fromJson(e.data())).toList());
    _database.firestore.collection(brandCollection).get().then((value) => brands
        .value = value.docs.map((e) => Brand.fromJson(e.data())).toList());
    _database.firestore.collection(mainCategoryCollection).get().then((value) =>
        mainCategories.value =
            value.docs.map((e) => MainCategory.fromJson(e.data())).toList());
    super.onInit();
  }

  Future<void> uploadIfSizeImage(String productId) async {
    if (colorImagePriceSize.isNotEmpty) {
      try {
        //find file image
        var fileMap = colorImagePriceSize.entries
            .where((element) => element.value.isFileImage);
        if (fileMap.isNotEmpty) {
          //we need to store image first
          for (var element in fileMap) {
            final file = File(element.value.image);
            await FirebaseStorage.instance
                .ref()
                .child("products/$productId/${Uuid().v1()}")
                .putFile(file)
                .then((snapshot) async {
              await snapshot.ref.getDownloadURL().then(
                    (value) => colorImagePriceSize[element.key] =
                        colorImagePriceSize[element.key]!.copyWith(
                      image: value,
                    ),
                  );
            });
          }
        }
      } catch (e) {
        debugPrint("*****UploadIfImageSizeError: $e");
      }
    }
  }
}
