import 'package:citymall/constant/collection_path.dart';
import 'package:citymall/constant/mock.dart';
import 'package:citymall/model/auth_user.dart';
import 'package:citymall/model/brand.dart';
import 'package:citymall/model/main_category.dart';
import 'package:citymall/model/review.dart';
import 'package:citymall/model/week_promotion.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../model/product.dart';
import '../model/shop.dart';
import '../model/sub_category.dart';

class DBDataController extends GetxController {
  List<MainCategory> mainCategories = [];
  List<SubCategory> subCategories = [];
  List<Brand> brands = [];
  List<Shop> shops = [];
  List<WeekPromotion> weekPromotions = [];
  List<Product> products = [];
  List<AuthUser> authUsers = [];
  Future<void> writeSubCategory() async {
    for (var p = 0; p < 5; p++) {
      for (var x = 0; x < 50; x++) {
        for (var u = 0; u < 5; u++) {
          final id = Uuid().v1();
          await FirebaseFirestore.instance
              .collection(reviewCollection)
              .doc(id)
              .set(Review(
                id: id,
                productId: products[p].id,
                user: authUsers[u],
                rating: 1,
                reviewMessage: "Such a beautiful and good prodct.",
                dateTime: DateTime.now(),
              ).toJson());
        }
      }
    }
  }

  @override
  void onInit() {
    getAll();
    super.onInit();
  }

  Future<void> getAll() async {
    FirebaseFirestore.instance
        .collection(productCollection)
        .limit(5)
        .withConverter<Product>(
            fromFirestore: (snapshot, options) =>
                Product.fromJson(snapshot.data()!),
            toFirestore: (m, __) => m.toJson())
        .get()
        .then((value) {
      products = value.docs.map((e) => e.data()).toList();
      debugPrint(
          "***********ProductListLength: ${products.length}\n first product: ${products.first.name}");
    });

    FirebaseFirestore.instance
        .collection(userCollection)
        .withConverter<AuthUser>(
            fromFirestore: (snapshot, options) =>
                AuthUser.fromJson(snapshot.data()!),
            toFirestore: (m, __) => m.toJson())
        .get()
        .then((value) {
      authUsers = value.docs.map((e) => e.data()).toList();
      debugPrint("***********AuthUserLength: ${authUsers.length}");
    });
  }
}
