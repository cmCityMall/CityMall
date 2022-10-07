import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/productdetailsscreen/product_detail_controller.dart';
import 'package:citymall/productdetailsscreen/productdetailscreen.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ViewAllReviewScreen extends StatelessWidget {
  ViewAllReviewScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    final DBDataController dataController = Get.find();
    final ProductDetailController detailController = Get.find();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeController.isLightTheme.value
          ? ColorResources.white
          : ColorResources.black4,
      appBar: AppBar(
        backgroundColor: themeController.isLightTheme.value
            ? ColorResources.white
            : ColorResources.black4,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              decoration: BoxDecoration(
                color: ColorResources.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 13,
                    color: ColorResources.blue1.withOpacity(0.3),
                    spreadRadius: 0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back,
                  color: ColorResources.black,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          "Reviews",
          style: TextStyle(
            fontFamily: TextFontFamily.SEN_BOLD,
            fontSize: 22,
            color: themeController.isLightTheme.value
                ? ColorResources.black2
                : ColorResources.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          height: Get.height,
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: themeController.isLightTheme.value
                ? ColorResources.white1
                : ColorResources.black1,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Review Product",
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: TextFontFamily.SEN_BOLD,
                    color: themeController.isLightTheme.value
                        ? ColorResources.black2
                        : ColorResources.white,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    RatingBar(
                      itemSize: 20,
                      maxRating: 5,
                      initialRating:
                          dataController.selectedProduct.value!.reviewCount +
                              0.0,
                      itemCount: 5,
                      direction: Axis.horizontal,
                      ratingWidget: RatingWidget(
                        full: Icon(
                          Icons.star,
                          color: ColorResources.yellow,
                        ),
                        empty: Icon(
                          Icons.star,
                          color: ColorResources.white2,
                        ),
                        half: Icon(Icons.star),
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    SizedBox(width: 8),
                    Text(
                      "${dataController.selectedProduct.value!.reviewCount + 0.0}",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: TextFontFamily.SEN_REGULAR,
                        fontWeight: FontWeight.w800,
                        color: themeController.isLightTheme.value
                            ? ColorResources.grey4
                            : ColorResources.white.withOpacity(0.6),
                      ),
                    ),
                    Text(
                      "(5 Review)",
                      style: TextStyle(
                        fontSize: 10,
                        fontFamily: TextFontFamily.SEN_REGULAR,
                        color: themeController.isLightTheme.value
                            ? ColorResources.grey4
                            : ColorResources.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: detailController.reviewList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final review = detailController.reviewList[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CachedNetworkImage(
                                imageBuilder: (conext, imageUrl) {
                                  return CircleAvatar(
                                    radius: 30,
                                    backgroundImage: imageUrl,
                                  );
                                },
                                progressIndicatorBuilder:
                                    (context, url, status) {
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey,
                                    highlightColor: Colors.white,
                                    child: Container(
                                      color: Colors.white,
                                    ),
                                  );
                                },
                                errorWidget: (context, url, whatever) {
                                  return const Text("Image not available");
                                },
                                imageUrl: review.user.image,
                                fit: BoxFit.contain,
                              ),
                              title: Text(
                                review.user.userName,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: TextFontFamily.SEN_BOLD,
                                  color: themeController.isLightTheme.value
                                      ? ColorResources.black1
                                      : ColorResources.white,
                                ),
                              ),
                              subtitle: RatingBar(
                                itemSize: 20,
                                maxRating: 5,
                                initialRating: review.rating,
                                itemCount: 5,
                                direction: Axis.horizontal,
                                ratingWidget: RatingWidget(
                                  full: Icon(
                                    Icons.star,
                                    color: ColorResources.yellow,
                                  ),
                                  empty: Icon(
                                    Icons.star,
                                    color: ColorResources.white2,
                                  ),
                                  half: Icon(Icons.star),
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                              trailing: Text(
                                DateFormat.yMMMMd().format(review.dateTime),
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: TextFontFamily.SEN_REGULAR,
                                  color: themeController.isLightTheme.value
                                      ? ColorResources.grey4
                                      : ColorResources.white.withOpacity(0.6),
                                ),
                              ),
                            ),
                            Text(
                              review.reviewMessage,
                              style: TextStyle(
                                height: 1.4,
                                fontSize: 12,
                                fontFamily: TextFontFamily.SEN_REGULAR,
                                color: themeController.isLightTheme.value
                                    ? ColorResources.grey4
                                    : ColorResources.white.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Obx(() => detailController.isFetchMoreLoading.value
                      ? AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          height: 35,
                          width: 35,
                          child: const CircularProgressIndicator(),
                        )
                      : const SizedBox()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
