import 'dart:developer';
import 'dart:io';

import 'package:citymall/controller/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../constant/collection_path.dart';
import '../model/cart_product.dart';
import '../model/purchase.dart';
import '../model/reward_product.dart';
import 'api.dart';

class Database {
  final firestore = FirebaseFirestore.instance;

  Future<void> write({
    required String collectionPath,
    required String documentPath,
    required Map<String, dynamic> data,
  }) async {
    await firestore.collection(collectionPath).doc(documentPath).set(data);
  }

  Future<void> delete({
    required String collectionPath,
    required String documentPath,
  }) async {
    await firestore.collection(collectionPath).doc(documentPath).delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchCollectionWithoutOrder(
      String collectionPath) {
    return FirebaseFirestore.instance.collection(collectionPath).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> watchCollection(
      String collectionPath) {
    return FirebaseFirestore.instance
        .collection(collectionPath)
        .orderBy("dateTime", descending: true)
        .snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getInitial(String collectionPath,
      [int limit = 10]) async {
    return await FirebaseFirestore.instance
        .collection(collectionPath)
        .orderBy("dateTime", descending: true)
        .limit(limit)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getInitialWhere(
      String collectionPath, dynamic field, dynamic compareField,
      [int limit = 10]) async {
    return await FirebaseFirestore.instance
        .collection(collectionPath)
        .orderBy("dateTime", descending: true)
        .where(field, isEqualTo: compareField)
        .limit(limit)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getInitialWhereTwo(
      String collectionPath,
      dynamic field1,
      dynamic compareField1,
      dynamic field2,
      dynamic compareField2,
      dynamic orderBy,
      [int limit = 10]) async {
    return await FirebaseFirestore.instance
        .collection(collectionPath)
        .orderBy(orderBy)
        .where(field1, isEqualTo: compareField1)
        .where(field2, isGreaterThan: compareField2)
        .limit(limit)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchMoreWhere(
      String collectionPath,
      List<String> startAfterId,
      dynamic field,
      dynamic compareField,
      [limit = 10]) async {
    return await FirebaseFirestore.instance
        .collection(collectionPath)
        .where(field, isEqualTo: compareField)
        .orderBy("dateTime", descending: true)
        .startAfter(startAfterId)
        .limit(limit)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchMoreWhereTwo(
      String collectionPath,
      List<String> startAfterId,
      dynamic field1,
      dynamic compareField1,
      dynamic field2,
      dynamic compareField2,
      [limit = 10]) async {
    return await FirebaseFirestore.instance
        .collection(collectionPath)
        .where(field1, isEqualTo: compareField1)
        .where(field2, isEqualTo: compareField2)
        .orderBy("dateTime", descending: true)
        .startAfter(startAfterId)
        .limit(limit)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchMore(
      String collectionPath, String startAfterId,
      [limit = 10]) async {
    return await FirebaseFirestore.instance
        .collection(collectionPath)
        .orderBy("dateTime", descending: true)
        .startAfter([startAfterId])
        .limit(limit)
        .get();
  }

  Future<void> writePurchase(Purchase purchase) async {
    if (purchase.screenShotImage.isNotEmpty) {
      //For prepay
      uploadImage(purchase.screenShotImage).then((value) async {
        write(
          collectionPath: purchaseCollection,
          documentPath: purchase.id,
          data: purchase.copyWith(screenShotImage: value).toJson(),
        ).then((value) async {
          await decreaseProductQuantity(
              purchase.items, purchase.rewardProducts);
          await increaseAndReducePoint(purchase.items, purchase.rewardProducts);
          //After purchase uploaded.Push send FCM
          Api.sendOrder(
                  "အော်ဒါတင်ခြင်း",
                  "🧑အမည်:${purchase.personalAddress.fullName}\n"
                      "🏠လိပ်စာ: ${purchase.personalAddress.address}\n"
                      "☎: ${purchase.personalAddress.phoneNumber}")
              .then((value) => log("*****Success push notification*****"));
        }).catchError((e) {
          log("****Error in uploading purchase: $e");
        });
      }).catchError((e) {
        log("Error in $e");
      });
    } else {
      write(
        collectionPath: purchaseCollection,
        documentPath: purchase.id,
        data: purchase.toJson(),
      ).then((value) async {
        await decreaseProductQuantity(purchase.items, purchase.rewardProducts);
        await increaseAndReducePoint(purchase.items, purchase.rewardProducts);
        //After purchase uploaded.Push send FCM
        Api.sendOrder(
                "အော်ဒါတင်ခြင်း",
                "🧑အမည်:${purchase.personalAddress.fullName}\n"
                    "🏠လိပ်စာ: ${purchase.personalAddress.address}\n"
                    "☎: ${purchase.personalAddress.phoneNumber}")
            .then((value) => log("*****Success push notification*****"));
      }).catchError((e) {
        log("****Error in uploading purchase: $e");
      });
    }
  }

  Future<String> uploadImage(String imagePath) async {
    final snapshot = await FirebaseStorage.instance
        .ref()
        .child("screenShot/${Uuid().v1()}")
        .putFile(File(imagePath));
    final resultImage = await snapshot.ref.getDownloadURL();
    return resultImage;
  }

  //Decrease Product's Quantity
  Future<void> decreaseProductQuantity(
      List<CartProduct>? items, List<RewardProduct>? rewardProducts) async {
    if (!(items == null)) {
      for (var product in items) {
        await updateRemainQuantity(
            productCollection, product.id, product.count);
      }
    }
    if (!(rewardProducts == null)) {
      for (var p in rewardProducts) {
        await updateRemainQuantity(rewardProductCollection, p.id, p.count);
      }
    }
  }

  Future<void> updateRemainQuantity(
      String collection, String prouctId, int count) async {
    //debugPrint("******${product.snapshot}*****");
    FirebaseFirestore.instance.runTransaction((transaction) async {
      //secure snapshot
      final secureSnapshot = await transaction
          .get(FirebaseFirestore.instance.collection(collection).doc(prouctId));

      final int remainQuan = secureSnapshot.get("remainQuantity") as int;

      transaction.update(secureSnapshot.reference, {
        "remainQuantity": remainQuan - count,
      });
    });
  }

  //--------------Functions For Reward System------------------------------//
  //Give Point Depend on Order Product Count
  Future<void> increaseCurrentUserPoint(int increasePoint) async {
    final AuthController authController = Get.find();
    FirebaseFirestore.instance.runTransaction(
      (transaction) async {
        final secureSnapshot = await transaction.get(FirebaseFirestore.instance
            .collection(userCollection)
            .doc(authController.currentUser.value!.id));

        final int previousPoint = secureSnapshot.get("points") as int;
        log("*********Point in increase current user point function:$increasePoint");
        transaction.update(
          secureSnapshot.reference,
          {
            "points": previousPoint + increasePoint,
          },
        );
      },
    );
  }

  //Reduce Point Depend on Order Product Count
  Future<void> reduceCurrentUserPoint(int reducePoint) async {
    final AuthController authController = Get.find();
    FirebaseFirestore.instance.runTransaction(
      (transaction) async {
        final secureSnapshot = await transaction.get(FirebaseFirestore.instance
            .collection(userCollection)
            .doc(authController.currentUser.value!.id));

        final int previousPoint = secureSnapshot.get("points") as int;

        transaction.update(
          secureSnapshot.reference,
          {
            "points": previousPoint - reducePoint,
          },
        );
      },
    );
  }

  Future<void> increaseAndReducePoint(
      List<CartProduct>? items, List<RewardProduct>? rewardProducts) async {
    if (!(items == null)) {
      //To increase RewardPoint
      int totalPay = 0;
      for (var e in items) {
        totalPay = e.count * e.lastPrice;
      }
      try {
        await increaseCurrentUserPoint(
            int.parse("${totalPay / 100}".split('.').first));
      } catch (e) {
        log("IncreaseFailed: $e");
      }
    }
    if (!(rewardProducts == null)) {
      //TO Reduce Reward Point
      int totalPoints = 0;
      for (var item in rewardProducts) {
        totalPoints += item.requiredPoint * item.count;
      }
      try {
        await reduceCurrentUserPoint(totalPoints);
      } catch (e) {
        log("*****ReduceFailed: $e");
      }
    }
  }
//-----------------------------------------------------------------------//
}
