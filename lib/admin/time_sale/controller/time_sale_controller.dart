import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:citymall/admin/time_sale/bin/time_sale_binding.dart';
import 'package:citymall/constant/collection_path.dart';
import 'package:citymall/model/time_sale.dart';
import 'package:citymall/server/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../model/product.dart';
import '../../../show_loading/show_loading.dart';

class TimeSaleController extends GetxController {
  final Database _database = Database();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxList<Product> productList = <Product>[].obs;
  RxMap<String, Product> selectedProductsMap = <String, Product>{}.obs;
  RxMap<String, Product> removedProductsMap = <String, Product>{}.obs;
//Instance Variable
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController percentageController = TextEditingController();
  var startDate = DateTime.now().obs;
  var endDate = DateTime.now().obs;
  var pickedImage = "".obs;
  Rxn<TimeSale> selectedTimeSale = Rxn<TimeSale>();
//ui state
  var isFirstTimePressed = false.obs;
  var removeProductLoading = false.obs;
  var addProductLoading = false.obs;
//**Method for instance variable */
  void setSelectedTimeSale(TimeSale t) => selectedTimeSale.value = t;
  void changeStartDate(DateTime d) {
    startDate.value = d;
    debugPrint("***Change Start Date: ${startDate.toString()}");
  }

  void changeEndDate(DateTime d) => endDate.value = d;
  void clearAll() {
    nameController.clear();
    descController.clear();
    percentageController.clear();
    pickedImage.value = "";
  }

  String? validate(String? value, String label) {
    if (!(value == null) && value.isNotEmpty) {
      return null;
    } else {
      return "$label is required";
    }
  }

  pickImage() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      pickedImage.value = image?.path ?? "";
    } catch (e) {
      debugPrint("Error Image Picking");
    }
  }

  /***End */

  //**Method for upload and delete TimeSale */
  Future<void> delete(String id) async {
    await _database.delete(
      collectionPath: timeSaleCollection,
      documentPath: id,
    );
  }

  Future<void> save() async {
    isFirstTimePressed.value = true;
    if (formKey.currentState?.validate() == true &&
        pickedImage.isNotEmpty &&
        startDate.value.millisecondsSinceEpoch >
            DateTime.now().millisecondsSinceEpoch &&
        endDate.value.millisecondsSinceEpoch >
            DateTime.now().millisecondsSinceEpoch) {
      showLoading();
      try {
        var percentage = int.parse(percentageController.text);

        await FirebaseStorage.instance
            .ref()
            .child("timeSale/${Uuid().v1()}")
            .putFile(File(pickedImage.value))
            .then((snapshot) async {
          await snapshot.ref.getDownloadURL().then((value) async {
            final ad = TimeSale(
              id: Uuid().v1(),
              image: value,
              name: nameController.text,
              desc: descController.text,
              percentage: int.parse(percentageController.text),
              startDate: startDate.value,
              endDate: endDate.value,
            );
            await _database.write(
              collectionPath: timeSaleCollection,
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
    } else {
      debugPrint("********TimeSaleForm not validate");
    }
  }
  //**End */

  //**Method for Add,Remove Product */
/*   void addIntoRemoveMap(Product p) {
    removedProductsMap.putIfAbsent(p.id, () => p);
  }
 */
  void selectProductOrNot(Product product) {
    log("******selected product or not");
    if (!selectedProductsMap.containsKey(product.id)) {
      selectedProductsMap.putIfAbsent(product.id, () => product);
    }
  }

  void addIntoRemoveMap(Product p) {
    removedProductsMap.putIfAbsent(p.id, () => p);
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
      _database.firestore.collection(productCollection).get().then((value) {
        productList.value =
            value.docs.map((e) => Product.fromJson(e.data())).toList();
        addProductLoading.value = false;
        debugPrint("*********Loading: ${addProductLoading.value}");
      });
    } catch (e) {
      addProductLoading.value = false;
      log("*****Eror: $e");
    }
  }

  //**End */

}
