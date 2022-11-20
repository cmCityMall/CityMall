import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/model/main_category.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../../constant/collection_path.dart';
import '../../../model/brand.dart';
import '../../../model/product.dart';
import '../../../model/reward_product.dart';
import '../../../model/shop.dart';
import '../../../server/database.dart';
import '../../../show_loading/show_loading.dart';

class RewardProductController extends GetxController {
  final _database = Database();
  final DBDataController _dataController = Get.find();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxList<RewardProduct> products = <RewardProduct>[].obs;
  RxList<RewardProduct> searchItems = <RewardProduct>[].obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController requiredPointController = TextEditingController();
  final TextEditingController totalQuantityController = TextEditingController();
  final TextEditingController remainQuantityController =
      TextEditingController();
  final TextEditingController editingController = TextEditingController();
  var isSearch = false.obs;
  var isFile = false.obs;
  //Selected Type
  var barCode = "".obs;
  var pickedImage = "".obs;
  //Error
  var pickedImageError = "".obs;
  var barCodeError = "".obs;
  //Temporary
  var isLoading = true.obs;
  var isFirstTimePressed = false.obs;

  void setBarCode(String value) => barCode.value = value;

  //Error
  void setBarCodeError(String value) => barCodeError.value = value;
  //

  String? validate(String? value, String label) {
    if (!(value == null) && value.isNotEmpty) {
      return null;
    } else {
      return "$label is required";
    }
  }

  void deleteImage(String path) {
    pickedImage.value = "";
  }

  void onSearch(String name) {
    isSearch.value = true;
    searchItems.value = products
        .where((p0) => p0.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  Future<void> configureForEditRewardProduct() async {
    if (!(_dataController.editRewardProduct == null)) {
      final rewardProduct = _dataController.editRewardProduct!;

      nameController.text = rewardProduct.name;
      descriptionController.text = rewardProduct.description;
      requiredPointController.text = rewardProduct.requiredPoint.toString();
      totalQuantityController.text = (rewardProduct.totalQuantity).toString();
      remainQuantityController.text = (rewardProduct.remainQuantity).toString();
      pickedImage.value = rewardProduct.image;
      //Selected Type
      barCode.value = rewardProduct.barCode ?? "";
    }
  }

  Future<void> scanBarCode() async {
    FlutterBarcodeScanner.scanBarcode(
            "#ff6666", "Cancel", false, ScanMode.DEFAULT)
        .then((value) {
      if (value != "-1") {
        barCode.value = value;
      }
      log("********Barcode Scan Value: $value");
    }).catchError((e) {
      log("*****Error scan bar code");
    });
  }

  pickSizeImage(String key) async {
    try {
      final XFile? images = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (!(images == null)) {
        pickedImage.value = images.path;
      }
    } catch (e) {
      debugPrint("******Size Image Picking");
    }
  }

  void clearAll() {
    nameController.clear();
    descriptionController.clear();
    requiredPointController.clear();
    totalQuantityController.clear();
    remainQuantityController.clear();
    pickedImage.value = "";
    barCode.value = "";
    isFile.value = false;
  }

  Future<void> delete(String id) async {
    await _database.delete(
      collectionPath: rewardProductCollection,
      documentPath: id,
    );
  }

  bool checkSelectType() {
    if (pickedImage.isEmpty || barCode.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void clearSearch() {
    editingController.clear();
    isSearch.value = false;
  }

  Future<void> scanBarCodeForSearch() async {
    FlutterBarcodeScanner.scanBarcode(
            "#ff6666", "Cancel", false, ScanMode.DEFAULT)
        .then((value) async {
      if (value != "-1") {
        searchWithBarCode(value);
      }
      log("********Barcode Scan Value: $value");
    }).catchError((e) {
      log("*****Error scan bar code");
    });
  }

  void searchWithBarCode(String value) {
    isSearch.value = true;
    try {
      log("********Search with Bar Code......***");
      final result = products.where((e) => e.barCode == value);
      log("********Result: ${result.length}\n SearchValue: $value****");
      if (result.isNotEmpty) {
        searchItems.value = [result.first];
      } else {
        searchItems.value = [];
      }
    } catch (e) {
      log("*******Error: $e");
    }
  }

  Future<String> uploadImage(File? image, String productId) async {
    if (image == null) {
      return "";
    }
    final snapshot = await FirebaseStorage.instance
        .ref()
        .child("rewardProducts/$productId/${Uuid().v1()}")
        .putFile(image);
    final resultImage = await snapshot.ref.getDownloadURL();
    return resultImage;
  }

  Future<void> save() async {
    isFirstTimePressed.value = true;
    var tQuantity = 0;
    var rQuantity = 0;
    var lBarCode = barCode.value;
    var name = nameController.text;
    var desc = descriptionController.text;
    var point = int.tryParse(requiredPointController.text) ?? 0;
    List<String> nameArray = [];
    var preString = "";
    for (var e in name.characters.toList()) {
      preString += e.toLowerCase();
      nameArray.add(preString);
    }
    log("*******NameArray: ${nameArray.toString()}");
    try {
      tQuantity = int.parse(totalQuantityController.text.removeAllWhitespace);
      rQuantity = int.parse(remainQuantityController.text.removeAllWhitespace);
    } catch (e) {
      debugPrint("******$e");
    }

    if (formKey.currentState?.validate() == true && checkSelectType()) {
      showLoading();
      try {
        final id = _dataController.editRewardProduct == null
            ? Uuid().v1()
            : _dataController.editRewardProduct!.id;
        File? image;
        if (isFile.value) {
          //Check for save and edit
          image = File(pickedImage.value);
        }
        uploadImage(image, id).then((value) async {
          log("Image: $value");
          final product = RewardProduct(
            id: id,
            name: name,
            image: value.isNotEmpty ? value : pickedImage.value,
            description: desc,
            requiredPoint: point,
            barCode: lBarCode,
            nameArray: nameArray,
            totalQuantity: tQuantity,
            remainQuantity: rQuantity,
            count: 0,
            dateTime: DateTime.now(),
          );
          await _database.write(
            collectionPath: rewardProductCollection,
            documentPath: product.id,
            data: product.toJson(),
          );
          isFirstTimePressed.value = false;
          clearAll();
          hideLoading();
          if (!(_dataController.editRewardProduct == null)) {
            Get.back();
          }
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

  dynamic tryCatchFunctin(dynamic function, {required dynamic defaultValue}) {
    dynamic value = "";
    try {
      value = function;
    } catch (e) {
      value = defaultValue;
    }

    return value;
  }

  pickImage() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (!(image == null)) {
        pickedImage.value = image.path;
        isFile.value = true;
      }
    } catch (e) {
      isFile.value = false;
      debugPrint("Error Bank Slip Image Picking");
    }
  }

  @override
  void onInit() {
    products.value = _dataController.rewardProducts;
    super.onInit();
  }
}
