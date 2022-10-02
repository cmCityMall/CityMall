import 'dart:developer';
import 'dart:io';

import 'package:citymall/model/product.dart';
import 'package:citymall/model/week_promotion.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:citymall/constant/collection_path.dart';
import 'package:citymall/show_loading/show_loading.dart';
import 'package:uuid/uuid.dart';
import '../../../server/database.dart';

class WeekPromotionController extends GetxController {
  final _database = Database();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxList<Product> productList = <Product>[].obs;
  RxMap<String, Product> selectedProductsMap = <String, Product>{}.obs;
  RxMap<String, Product> removedProductsMap = <String, Product>{}.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController promoController = TextEditingController();
  var isFirstTimePressed = false.obs;
  //Error
  var pickImageError = "".obs;
  //
  var pickedImage = "".obs;
  var isPercentage = true.obs;
  var removeProductLoading = false.obs;
  var addProductLoading = false.obs;

  String? validate(String? value, String label) {
    if (!(value == null) && value.isNotEmpty) {
      return null;
    } else {
      return "$label is required";
    }
  }

  void changeIsPercentage() {
    isPercentage.value = !isPercentage.value;
  }

  void clearAll() {
    nameController.clear();
    pickedImage.value = "";
  }

  Future<void> delete(String id) async {
    await _database.delete(
      collectionPath: promotionCollection,
      documentPath: id,
    );
  }

  void addIntoRemoveMap(Product p) {
    removedProductsMap.putIfAbsent(p.id, () => p);
  }

  Future<void> save() async {
    isFirstTimePressed.value = true;
    if (pickedImage.isEmpty) {
      pickImageError.value = "Image is required.";
    }
    if (formKey.currentState?.validate() == true && pickedImage.isNotEmpty) {
      showLoading();
      try {
        var percentage =
            isPercentage.value ? int.parse(promoController.text) : 0;
        var discountPrice =
            isPercentage.value ? int.parse(promoController.text) : 0;
        await FirebaseStorage.instance
            .ref()
            .child("weekPromotions/${Uuid().v1()}")
            .putFile(File(pickedImage.value))
            .then((snapshot) async {
          await snapshot.ref.getDownloadURL().then((value) async {
            final ad = WeekPromotion(
              id: Uuid().v1(),
              image: value,
              desc: nameController.text,
              isPercentage: isPercentage.value,
              percentage: percentage,
              descountPrice: discountPrice,
              dateTime: DateTime.now(),
            );
            await _database.write(
              collectionPath: promotionCollection,
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

  void selectProductOrNot(Product product) {
    log("******selected product or not");
    if (!selectedProductsMap.containsKey(product.id)) {
      selectedProductsMap.putIfAbsent(product.id, () => product);
    }
  }

  Future<void> removeProductsToPromotion() async {
    if (removedProductsMap.isNotEmpty) {
      try {
        showLoading();
        for (var element in removedProductsMap.entries) {
          await _database.firestore
              .collection(productCollection)
              .doc(element.value.id)
              .update({
            "promotion": 0,
            "promotionId": "",
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

  Future<void> addProductsToPromotion(String promotionId, int promotion) async {
    if (selectedProductsMap.isNotEmpty) {
      try {
        showLoading();
        for (var element in selectedProductsMap.entries) {
          await _database.firestore
              .collection(productCollection)
              .doc(element.value.id)
              .update({
            "promotion": promotion,
            "promotionId": promotionId,
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

  Future<void> getProductsFromPromotion(String promotionId) async {
    removeProductLoading.value = true;
    try {
      _database.firestore
          .collection(productCollection)
          .where("promotionId", isEqualTo: promotionId)
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

  Future<void> getProductsExceptCurrentPromotion(String promotionId) async {
    addProductLoading.value = true;
    try {
      _database.firestore
          .collection(productCollection)
          .where("promotionId", isNotEqualTo: promotionId)
          .get()
          .then((value) {
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
}
