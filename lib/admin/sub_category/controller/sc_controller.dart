import 'dart:io';

import 'package:citymall/constant/collection_path.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../model/main_category.dart';
import '../../../model/sub_category.dart';
import '../../../server/database.dart';
import '../../../show_loading/show_loading.dart';

class SCController extends GetxController {
  final DBDataController dataController = Get.find();
  final _database = Database();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RxList<SubCategory> subCatgories = <SubCategory>[].obs;
  final RxList<MainCategory> mainCategories = <MainCategory>[].obs;
  var selectedParentId = "".obs;
  var currentIndex = 0.obs;
  var pickedImage = "".obs;
  var pickedImageError = "".obs;
  var selectedParentError = "".obs;
  var isFirstTimePressed = false.obs;
  final TextEditingController nameController = TextEditingController();
  void setSelectedParentId(String value) => selectedParentId.value = value;
  String? validate(String? value) {
    if (!(value == null) && value.isNotEmpty) {
      return null;
    } else {
      return "Name is required";
    }
  }

  void setParentError(String value) => selectedParentError.value = value;
  void clearAll() {
    nameController.clear();
    pickedImage.value = "";
  }

  pickImage() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      pickedImage.value = image?.path ?? "";
      pickedImageError.value = "";
    } catch (e) {
      debugPrint("Error Bank Slip Image Picking");
    }
  }

  String getMainCategory(String id) =>
      mainCategories.where((e) => e.id == id).first.name;

  Future<void> delete(String id) async {
    await _database.delete(
      collectionPath: subCategoryCollection,
      documentPath: id,
    );
  }

  void setEmptyError() {
    pickedImageError.value = "";
    selectedParentError.value = "";
  }

  Future<void> save() async {
    isFirstTimePressed.value = true;
    if (pickedImage.isEmpty) {
      pickedImageError.value = "Image is required";
    }
    if (selectedParentId.isEmpty) {
      selectedParentError.value = "Main Category is required to select.";
    }

    if (formKey.currentState?.validate() == true &&
        pickedImage.isNotEmpty &&
        selectedParentId.value.isNotEmpty) {
      var parentId = mainCategories
          .where((e) => e.name == selectedParentId.value)
          .first
          .id;
      showLoading();
      setEmptyError();
      try {
        final ad = SubCategory(
          id: Uuid().v1(),
          name: nameController.text,
          parentId: parentId,
          dateTime: DateTime.now(),
        );
        await FirebaseStorage.instance
            .ref()
            .child("subCategories/${Uuid().v1()}")
            .putFile(File(pickedImage.value))
            .then((snapshot) async {
          await snapshot.ref.getDownloadURL().then((value) async {
            await _database.write(
              collectionPath: subCategoryCollection,
              documentPath: ad.id,
              data: ad.copyWith(image: value).toJson(),
            );
            isFirstTimePressed.value = false;
            hideLoading();
            clearAll();
          });
        });
      } catch (e) {
        hideLoading();
        Get.snackbar("Failed!", "Try Again");
        debugPrint("****$e");
      }
    }
  }

  void decreaseIndex() {
    if (currentIndex.value > 0) {
      currentIndex.value = currentIndex.value - 1;
      selectedParentId.value = mainCategories[currentIndex.value].name;
    }
    debugPrint("****SelectedCategory: ${selectedParentId.value}");
  }

  void increaseIndex() {
    if (currentIndex.value + 1 < mainCategories.length) {
      currentIndex.value = currentIndex.value + 1;
      selectedParentId.value = mainCategories[currentIndex.value].name;
    }
    debugPrint("****SelectedCategory: ${selectedParentId.value}");
  }

  @override
  void onInit() {
    _database
        .watchCollectionWithoutOrder(subCategoryCollection)
        .listen((event) {
      if (event.docs.isNotEmpty) {
        subCatgories.value =
            event.docs.map((e) => SubCategory.fromJson(e.data())).toList();
      }
    });
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
