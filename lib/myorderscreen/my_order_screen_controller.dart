import 'dart:developer';

import 'package:citymall/constant/collection_path.dart';
import 'package:citymall/controller/auth_controller.dart';
import 'package:citymall/model/purchase.dart';
import 'package:citymall/server/database.dart';
import 'package:get/get.dart';

class MyOrderScreenController extends GetxController {
  final Database _database = Database();
  final AuthController authController = Get.find();
  RxList<Purchase> processList = <Purchase>[].obs;
  RxList<Purchase> deliveredList = <Purchase>[].obs;
  RxList<Purchase> cancelList = <Purchase>[].obs;
  var isLoading = false.obs;

  @override
  Future<void> onInit() async {
    //If Not Admin,need to fetch this user's orders
    isLoading.value = true;
    _database.firestore
        .collection(purchaseCollection)
        .orderBy("dateTime", descending: true)
        .where("userId", isEqualTo: authController.currentUser.value!.id)
        .get()
        .then((value) {
      final orderList =
          value.docs.map((e) => Purchase.fromJson(e.data())).toList();
      processList.value =
          orderList.where((element) => element.status == 0).toList();
      deliveredList.value =
          orderList.where((element) => element.status == 1).toList();
      cancelList.value =
          orderList.where((element) => element.status == 2).toList();
      isLoading.value = false;
    }).catchError((e) {
      isLoading.value = false;
      Get.back();
      log("*******Error when fetch current user's purchase: $e");
    });
    super.onInit();
  }
}
