import 'dart:io';

import 'package:citymall/model/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:citymall/constant/collection_path.dart';
import 'package:citymall/model/advertisement.dart';
import 'package:citymall/show_loading/show_loading.dart';
import 'package:uuid/uuid.dart';

import 'package:citymall/server/database.dart';

class ADController extends GetxController {
  final _database = Database();
  RxList<Product> addedProducts = <Product>[].obs;
  var pickedImage = "".obs;
  var isLoading = false.obs;

  void clearAll() {
    pickedImage.value = "";
  }

  Future<void> delete(String id) async {
    await _database.delete(
      collectionPath: advertisementCollection,
      documentPath: id,
    );
  }

  Future<void> save() async {
    showLoading();
    if (isLoading.value) {
      return;
    }
    if (pickedImage.isNotEmpty) {
      isLoading.value = true;
      try {
        await FirebaseStorage.instance
            .ref()
            .child("advertisements/${Uuid().v1()}")
            .putFile(File(pickedImage.value))
            .then((snapshot) async {
          await snapshot.ref.getDownloadURL().then((value) async {
            final ad = Advertisement(
              id: Uuid().v1(),
              image: value,
              dateTime: DateTime.now(),
            );
            await _database.write(
              collectionPath: advertisementCollection,
              documentPath: ad.id,
              data: ad.toJson(),
            );
            isLoading.value = false;
            clearAll();
          });
        });
      } catch (e) {
        Get.snackbar("Failed!", "Try Again");
        debugPrint("****$e");
        isLoading.value = false;
      }
    }
    hideLoading();
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
}
