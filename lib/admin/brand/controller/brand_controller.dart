import 'dart:developer';
import 'dart:io';

import 'package:citymall/controller/db_data_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:citymall/constant/collection_path.dart';
import 'package:citymall/model/brand.dart';
import 'package:citymall/show_loading/show_loading.dart';
import 'package:uuid/uuid.dart';

import '../../../model/product.dart';
import '../../../model/shop.dart';
import '../../../server/database.dart';

class BrandController extends GetxController {
  final _database = Database();
  RxList<Brand> brandList = <Brand>[].obs;
  RxList<Product> productList = <Product>[].obs;
  RxMap<String, Product> selectedProductsMap = <String, Product>{}.obs;
  RxMap<String, Product> removedProductsMap = <String, Product>{}.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController subNameController = TextEditingController();
  List<Shop> shopList = <Shop>[].obs;
  final TextEditingController statusController = TextEditingController();
  var isFirstTimePressed = false.obs;
  //Error
  var pickImageError = "".obs;
  var selectedShopIdError = "".obs;
  //
  var pickedImage = "".obs;
  var selectedShopId = "".obs;

  //Loading for bottomsheet
  var removeProductLoading = false.obs;
  var addProductLoading = false.obs;

  //*********For Andding , Subtracting Products */
  void addIntoRemoveMap(Product p) {
    removedProductsMap.putIfAbsent(p.id, () => p);
  }

  void selectProductOrNot(Product product) {
    log("******selected product or not");
    if (!selectedProductsMap.containsKey(product.id)) {
      selectedProductsMap.putIfAbsent(product.id, () => product);
    }
  }

  Future<void> removeProductsFromBrand() async {
    if (removedProductsMap.isNotEmpty) {
      try {
        showLoading();
        for (var element in removedProductsMap.entries) {
          await _database.firestore
              .collection(productCollection)
              .doc(element.value.id)
              .update({
            "brandId": "",
          });
        }
        hideLoading();
        //For UI
        if (Get.isBottomSheetOpen!) {
          Get.back();
        }
        removedProductsMap.clear();
        selectedProductsMap.clear();
      } catch (e) {
        hideLoading();
        Get.snackbar("Failed!", "Please try again.");
      }
    } else {
      Get.back();
    }
  }

  Future<void> addProductsToBrand(String brandId) async {
    if (selectedProductsMap.isNotEmpty) {
      try {
        showLoading();
        for (var element in selectedProductsMap.entries) {
          await _database.firestore
              .collection(productCollection)
              .doc(element.value.id)
              .update({
            "brandId": brandId,
          });
        }
        hideLoading();
        //For UI
        if (Get.isBottomSheetOpen!) {
          Get.back();
        }
        selectedProductsMap.clear();
      } catch (e) {
        hideLoading();
        Get.snackbar("Failed!", "Please try again.");
      }
    } else {
      Get.back();
    }
  }

  Future<void> getProductsWithBrandId(String brandId) async {
    removeProductLoading.value = true;
    try {
      _database.firestore
          .collection(productCollection)
          .where("brandId", isEqualTo: brandId)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          for (var element in value.docs) {
            final p = Product.fromJson(element.data());
            selectedProductsMap.putIfAbsent(p.id, () => p);
          }
        }
        removeProductLoading.value = false;
      });
    } catch (e) {
      removeProductLoading.value = false;
      Get.snackbar("Failed!", "No products found.");
    }
  }

  Future<void> getProductsExceptCurrentBrand(String brandId) async {
    addProductLoading.value = true;
    try {
      _database.firestore.collection(productCollection).get().then((value) {
        productList.value =
            value.docs.map((e) => Product.fromJson(e.data())).toList();
        addProductLoading.value = false;
        debugPrint("*********Loading: ${addProductLoading.value}");
      });
    } catch (e) {
      addProductLoading.value = false;
      Get.snackbar("Failed!", "No products found.");
    }
  }
  /*************************End */

  void setSelectedShopIdError(String value) =>
      selectedShopIdError.value = value;

  void setSelectedShopId(String value) => selectedShopId.value = value;
  String? validate(String? value, String label) {
    if (!(value == null) && value.isNotEmpty) {
      return null;
    } else {
      return "$label is required";
    }
  }

  void clearAll() {
    nameController.clear();
    subNameController.clear();
    statusController.clear();
    pickedImage.value = "";
  }

  Future<void> delete(String id) async {
    await _database.delete(
      collectionPath: brandCollection,
      documentPath: id,
    );
  }

  Future<void> save() async {
    isFirstTimePressed.value = true;
    if (pickedImage.isEmpty) {
      pickImageError.value = "Image is required.";
    }
    if (selectedShopId.isEmpty) {
      selectedShopIdError.value = "Shop Id is required to select";
    }
    if (formKey.currentState?.validate() == true &&
        pickedImage.isNotEmpty &&
        selectedShopId.isNotEmpty) {
      showLoading();
      try {
        await FirebaseStorage.instance
            .ref()
            .child("brands/${Uuid().v1()}")
            .putFile(File(pickedImage.value))
            .then((snapshot) async {
          await snapshot.ref.getDownloadURL().then((value) async {
            final ad = Brand(
              id: Uuid().v1(),
              image: value,
              name: nameController.text,
              shopId: selectedShopId.value,
              dateTime: DateTime.now(),
            );
            await _database.write(
              collectionPath: brandCollection,
              documentPath: ad.id,
              data: ad.toJson(),
            );
            isFirstTimePressed.value = false;
            clearAll();
          });
        });
      } catch (e) {
        Get.snackbar("Failed!", "Try Again");
        debugPrint("****$e");
      }
      hideLoading();
    }
  }

  pickImage() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      pickedImage.value = image?.path ?? "";
      pickImageError.value = "";
    } catch (e) {
      debugPrint("Error Bank Slip Image Picking");
    }
  }

  @override
  void onInit() {
    _database.watchCollectionWithoutOrder(brandCollection).listen((event) {
      if (event.docs.isNotEmpty) {
        brandList.value =
            event.docs.map((e) => Brand.fromJson(e.data())).toList();
      }
    });
    _database.firestore.collection(shopCollection).get().then((value) =>
        shopList = value.docs.map((e) => Shop.fromJson(e.data())).toList());
    super.onInit();
  }
}
