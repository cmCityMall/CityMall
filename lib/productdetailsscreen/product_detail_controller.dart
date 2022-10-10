import 'dart:developer';

import 'package:citymall/constant/collection_path.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/model/product.dart';
import 'package:citymall/model/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../controller/auth_controller.dart';
import '../server/database.dart';

class ProductDetailController extends GetxController {
  final DBDataController dataController = Get.find();
  final Database _database = Database();
  Rxn<Product> currentProduct = Rxn<Product>();
  //**For Pagination */
  final ScrollController scrollController =
      ScrollController(initialScrollOffset: 0);
  var isLoading = false.obs;
  var isFetchMoreLoading = false.obs;
  var selectedColor = "".obs;
  var selectedSize = "".obs;
  var selectedPrice = 0.obs;
  var selectedImage = "".obs;
  set setSelectedImage(String v) => selectedImage.value = v;
  set setSelectedColor(String v) => selectedColor.value = v;
  set setSelectedSize(String v) => selectedSize.value = v;
  set setSelectedPrice(int v) => selectedPrice.value = v;

  //**For Review */
  final AuthController _authController = Get.find();
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController reviewController = TextEditingController();
  RxList<Review> reviewsList = <Review>[].obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var isWritingReviewLoading = false.obs;
  var rating = 0.0.obs;
  var rateError = false.obs;
  var reviewError = false.obs;
  var firstTimePressed = false.obs;

  void changeRating(double value) {
    rating.value = value;
    ratingController.text = value.toString();
  }

  Future<void> writeReiew(String productId) async {
    firstTimePressed.value = true;
    if (isWritingReviewLoading.value) {
      return;
    }
    if (checkValidate()) {
      isWritingReviewLoading.value = true;
      final currentUser = _authController.currentUser
          .value!; /*TO DO TO insert with real 
      authenticated user.*/
      final review = Review(
        id: Uuid().v1(),
        productId: productId,
        user: currentUser,
        rating: rating.value,
        reviewMessage: reviewController.text,
        dateTime: DateTime.now(),
      );
      try {
        await _database.write(
          collectionPath: reviewCollection,
          documentPath: review.id,
          data: review.toJson(),
        );
        await updateRating(productId);
        isWritingReviewLoading.value = false;
        clearAll();
        reviewsList.add(review);
        reviewsList
            .sort((v1, v2) => v1.dateTime.millisecondsSinceEpoch.compareTo(
                  v2.dateTime.millisecondsSinceEpoch,
                ));
        reviewsList.value = reviewsList.reversed.toList();
        log("******Review List: ${reviewsList.length}");
      } catch (e) {
        log("*****Review Write Failed!: $e..");
        isWritingReviewLoading.value = false;
      }
    }
  }

  void clearAll() {
    rating.value = 0.0;
    ratingController.clear();
    reviewController.clear();
  }

  Future<void> updateRating(String productId) async {
    await _database.firestore.runTransaction((transaction) async {
      final secureSnapshot = await transaction.get(
          _database.firestore.collection(productCollection).doc(productId));
      final double previousRating = secureSnapshot.get("reviewCount");
      try {
        transaction.set(
          secureSnapshot.reference,
          {
            "reviewCount": previousRating + rating.value,
          },
          SetOptions(merge: true),
        );
      } catch (e) {
        log("****Update Review Error: $e");
      }
    });
  }

  bool checkValidate() {
    if (validateReview() && validateRating()) {
      return true;
    } else {
      return false;
    }
  }

  bool validateReview() {
    if (reviewController.text.isEmpty) {
      reviewError.value = true;
      return false;
    } else {
      reviewError.value = false;
      return true;
    }
  }

  bool validateRating() {
    if (rating.value < 0 || rating.value == 0) {
      rateError.value = true;
      return false;
    } else {
      rateError.value = false;
      return true;
    }
  }
  //**End */

  Future<void> getInitialWhere() async {
    isLoading.value = true;
    try {
      final result = await _database.getInitialWhere(
        reviewCollection,
        "productId",
        dataController.selectedProduct.value!.id,
      );
      if (result.docs.isNotEmpty) {
        reviewsList.value =
            result.docs.map((e) => Review.fromJson(e.data())).toList();
      }
    } catch (e) {
      log("****Error: $e");
    }
    isLoading.value = false;
  }

  Future<void> fetchWhere(List<String> startAfterId) async {
    try {
      final result = await _database.fetchMoreWhere(
        reviewCollection,
        startAfterId,
        "productId",
        dataController.selectedProduct.value!.id,
      );
      if (result.docs.isNotEmpty) {
        for (var e in result.docs) {
          reviewsList.add(Review.fromJson(e.data()));
        }
      }
    } catch (e) {
      log("****Error: $e");
    }
  }

  @override
  Future<void> onInit() async {
    await getInitialWhere();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!(isLoading.value)) {
          isLoading.value = true;
          final lastD = reviewsList.last;
          fetchWhere([lastD.toJson()["dateTime"]])
              .then((value) => isLoading.value = false);
        }
      }
    });
    FirebaseFirestore.instance
        .collection(productCollection)
        .doc(dataController.selectedProduct.value!.id)
        .withConverter<Product>(
          fromFirestore: (snap, __) => Product.fromJson(snap.data()!),
          toFirestore: (e, __) => e.toJson(),
        )
        .snapshots()
        .listen((event) {
      currentProduct.value = event.data();
    });
    super.onInit();
  }
}
