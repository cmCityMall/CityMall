import 'dart:developer';
import 'dart:io';

import 'package:citymall/constant/collection_path.dart';
import 'package:citymall/model/sub_category.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../../../model/main_category.dart';
import '../../../server/database.dart';
import '../../../show_loading/show_loading.dart';

class MCController extends GetxController {
  final _database = Database();
  RxList<SubCategory> subCategoryList = <SubCategory>[].obs;
  RxMap<String, SubCategory> selectedSubCategorysMap =
      <String, SubCategory>{}.obs;
  RxMap<String, SubCategory> removedSubCategorysMap =
      <String, SubCategory>{}.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxList<MainCategory> mainCategories = <MainCategory>[].obs;
  final TextEditingController nameController = TextEditingController();
  var pickedImage = "".obs;
  var isMenu = true.obs;
  var isFirstTimePressed = false.obs;
  void changeIsMenu(bool value) => isMenu.value = value;
  var removeSubCategoryLoading = false.obs;
  var addSubCategoryLoading = false.obs;
  String? validate(String? value) {
    if (!(value == null) && value.isNotEmpty) {
      return null;
    } else {
      return "Name is required";
    }
  }

  void clearAll() {
    nameController.clear();
    pickedImage.value = "";
  }

  Future<void> delete(String id) async {
    await _database.delete(
      collectionPath: mainCategoryCollection,
      documentPath: id,
    );
  }

  Future<void> save() async {
    isFirstTimePressed.value = true;

    if (formKey.currentState?.validate() == true && pickedImage.isNotEmpty) {
      showLoading();
      try {
        await FirebaseStorage.instance
            .ref()
            .child("mainCategories/${Uuid().v1()}")
            .putFile(File(pickedImage.value))
            .then((snapshot) async {
          await snapshot.ref.getDownloadURL().then((value) async {
            final ad = MainCategory(
              id: Uuid().v1(),
              image: value,
              name: nameController.text,
              isMenu: isMenu.value,
              dateTime: DateTime.now(),
            );
            await _database.write(
              collectionPath: mainCategoryCollection,
              documentPath: ad.id,
              data: ad.toJson(),
            );
            isFirstTimePressed.value = false;
            clearAll();
            hideLoading();
          });
        });
      } catch (e) {
        hideLoading();
        Get.snackbar("Failed!", "Try Again");
        debugPrint("****$e");
      }
    }
  }

  pickImage() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      pickedImage.value = image?.path ?? "";
    } catch (e) {
      debugPrint("Error Bank Slip Image Picking");
    }
  }

  //**Method for Add,Remove Product */
/*   void addIntoRemoveMap(Product p) {
    removedProductsMap.putIfAbsent(p.id, () => p);
  }
 */
  void selectSubOrNot(SubCategory sub) {
    log("******selected product or not");
    if (!selectedSubCategorysMap.containsKey(sub.id)) {
      selectedSubCategorysMap.putIfAbsent(sub.id, () => sub);
    }
  }

  void addIntoRemoveMap(SubCategory s) {
    removedSubCategorysMap.putIfAbsent(s.id, () => s);
  }

  Future<void> removeSubCategoriesFromMain() async {
    if (selectedSubCategorysMap.isNotEmpty) {
      try {
        showLoading();
        for (var element in selectedSubCategorysMap.entries) {
          await _database.firestore
              .collection(subCategoryCollection)
              .doc(element.value.id)
              .update({
            "parentId": "",
          });
        }
        hideLoading();
        //For UI
        if (Get.isBottomSheetOpen!) {
          Get.back();
        }
        removedSubCategorysMap.clear();
        selectedSubCategorysMap.clear();
      } catch (e) {
        hideLoading();
        Get.snackbar("Failed!", "Please try again.");
      }
    } else {
      Get.back();
    }
  }

  Future<void> addSubCategoryToMain(String parentId) async {
    if (selectedSubCategorysMap.isNotEmpty) {
      try {
        showLoading();
        for (var element in selectedSubCategorysMap.entries) {
          await _database.firestore
              .collection(subCategoryCollection)
              .doc(element.value.id)
              .update({
            "parentId": parentId,
          });
        }
        hideLoading();
        //For UI
        if (Get.isBottomSheetOpen!) {
          Get.back();
        }
        selectedSubCategorysMap.clear();
      } catch (e) {
        hideLoading();
        Get.snackbar("Failed!", "Please try again.");
      }
    } else {
      Get.back();
    }
  }

  Future<void> getSubCategoryFromMain(String parentId) async {
    removeSubCategoryLoading.value = true;
    try {
      _database.firestore
          .collection(subCategoryCollection)
          .where("parentId", isEqualTo: parentId)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          for (var element in value.docs) {
            final p = SubCategory.fromJson(element.data());
            removedSubCategorysMap.putIfAbsent(p.id, () => p);
          }
        }
        removeSubCategoryLoading.value = false;
      });
    } catch (e) {
      removeSubCategoryLoading.value = false;
    }
  }

  Future<void> getSubCategoryAll(String parentId) async {
    addSubCategoryLoading.value = true;
    try {
      _database.firestore.collection(subCategoryCollection).get().then((value) {
        subCategoryList.value =
            value.docs.map((e) => SubCategory.fromJson(e.data())).toList();
        addSubCategoryLoading.value = false;
        debugPrint("*********Loading: ${addSubCategoryLoading.value}");
      });
    } catch (e) {
      addSubCategoryLoading.value = false;
      log("*****Eror: $e");
    }
  }

  //**End */

  @override
  void onInit() {
    _database
        .watchCollectionWithoutOrder(mainCategoryCollection)
        .listen((event) {
      if (event.docs.isNotEmpty) {
        mainCategories.value =
            event.docs.map((e) => MainCategory.fromJson(e.data())).toList();
      }
    });
    super.onInit();
  }
}
