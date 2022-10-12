import 'dart:developer';

import 'package:citymall/constant/collection_path.dart';
import 'package:citymall/server/api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrderMainController extends GetxController {
  var eta = "".obs;
  void setETA(String time) => eta.value = time;
  Future<void> cancelOrder(String orderId, String userId) async {
    Api.notifyUserAboutHistOrder("Canceled", "Your order is canceled.", userId)
        .then((value) async {
      //After cancel,change order's status to 2
      FirebaseFirestore.instance
          .collection(purchaseCollection)
          .doc(orderId)
          .update({
            "status": 2,
          })
          .then((value) => Get.back())
          .catchError((e) {
            log("**Error when update order status to 2...");
          });
    }).catchError((e) {
      log("****Error when send push about cancel order.");
    });
  }

  Future<void> deliverOrder(String orderId, String userId, String eta) async {
    Api.notifyUserAboutHistOrder(
            "Delivered", "Your order is delivered.", userId)
        .then((value) async {
      //After cancel,change order's status to 2
      FirebaseFirestore.instance
          .collection(purchaseCollection)
          .doc(orderId)
          .update({
            "status": 1,
            "eta": eta,
          })
          .then((value) => Get.back())
          .catchError((e) {
            log("**Error when update order status to 1...");
          });
    }).catchError((e) {
      log("****Error when send push about delivered order.");
    });
  }
}
