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

import '../../../model/shop.dart';
import '../../../server/database.dart';

class BrandController extends GetxController {
  final _database = Database();
  RxList<Brand> brandList = <Brand>[].obs;
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
      selectedShopId.value = "Shop Id is required to select";
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
