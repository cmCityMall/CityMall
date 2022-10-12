import 'dart:developer';

import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/clickcontroller.dart';
import 'package:citymall/controller/slidercontroller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../controller/ppva_controller.dart';

// ignore: must_be_immutable
class PopularDialogScreen extends StatelessWidget {
  PopularDialogScreen({Key? key}) : super(key: key);

  final ThemeController themeController = Get.put(ThemeController());
  SliderController sliderController = Get.put(SliderController());
  @override
  Widget build(BuildContext context) {
    final PPVAController actionController = Get.find();
    return AlertDialog(
      backgroundColor: themeController.isLightTheme.value
          ? ColorResources.white
          : ColorResources.black1,
      titlePadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(0),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Filter & Sorting",
                  style: TextStyle(
                    fontFamily: TextFontFamily.SEN_BOLD,
                    fontSize: 18,
                    color: themeController.isLightTheme.value
                        ? ColorResources.black2
                        : ColorResources.white,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.close,
                    color: themeController.isLightTheme.value
                        ? ColorResources.black2
                        : ColorResources.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 22),
            /* Divider(
              thickness: 0.5,
              color: themeController.isLightTheme.value
                  ? ColorResources.grey4
                  : ColorResources.white.withOpacity(0.4),
            ),
            SizedBox(height: 15), */
            /* Text(
              "Price",
              style: TextStyle(
                fontFamily: TextFontFamily.SEN_BOLD,
                fontSize: 14,
                color: themeController.isLightTheme.value
                    ? ColorResources.black2
                    : ColorResources.white,
              ),
            ),
            Obx(
              () => RangeSlider(
                divisions: 100,
                activeColor: ColorResources.blue1,
                inactiveColor: ColorResources.blue4,
                min: 3000.0,
                max: 10000.0,
                values: sliderController.values.value,
                labels: RangeLabels(
                  sliderController.startLabel.value,
                  sliderController.endLabel.value,
                ),
                onChanged: (value) {
                  sliderController.startLabel.value = value.start.toString();
                  sliderController.endLabel.value = value.end.toString();
                  sliderController.values.value = value;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "3000",
                  style: TextStyle(
                    fontFamily: TextFontFamily.SEN_BOLD,
                    fontSize: 12,
                    color: themeController.isLightTheme.value
                        ? ColorResources.black2
                        : ColorResources.white,
                  ),
                ),
                Text(
                  "10000",
                  style: TextStyle(
                    fontFamily: TextFontFamily.SEN_BOLD,
                    fontSize: 12,
                    color: themeController.isLightTheme.value
                        ? ColorResources.black2
                        : ColorResources.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 22), */
            Divider(
              thickness: 0.5,
              color: themeController.isLightTheme.value
                  ? ColorResources.grey4
                  : ColorResources.white.withOpacity(0.4),
            ),
            SizedBox(height: 15),
            Text(
              "Customer Reviews",
              style: TextStyle(
                fontFamily: TextFontFamily.SEN_BOLD,
                fontSize: 14,
                color: themeController.isLightTheme.value
                    ? ColorResources.black2
                    : ColorResources.white,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Obx(
                  () => InkWell(
                    onTap: () {
                      actionController.changeReview(0);
                    },
                    child: Container(
                      height: 24,
                      //width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: themeController.isLightTheme.value
                              ? actionController.reviewIndex.value == 0
                                  ? ColorResources.blue1
                                  : ColorResources.white13
                              : actionController.reviewIndex.value == 0
                                  ? ColorResources.blue1
                                  : ColorResources.black4,
                        ),
                        color: themeController.isLightTheme.value
                            ? ColorResources.white13
                            : ColorResources.black4,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Row(
                          children: [
                            RatingBar(
                              itemSize: 20,
                              maxRating: 4,
                              initialRating: 4,
                              itemCount: 4,
                              direction: Axis.horizontal,
                              ratingWidget: RatingWidget(
                                full: Icon(
                                  Icons.star,
                                  color: ColorResources.yellow,
                                ),
                                empty: Icon(
                                  Icons.star,
                                  color: ColorResources.white,
                                ),
                                half: Icon(Icons.star),
                              ),
                              onRatingUpdate: (rating) {},
                            ),
                            Text(
                              "& Up",
                              style: TextStyle(
                                fontFamily: TextFontFamily.SEN_REGULAR,
                                fontSize: 10,
                                color: themeController.isLightTheme.value
                                    ? actionController.reviewIndex.value == 0
                                        ? ColorResources.blue1
                                        : ColorResources.black2
                                    : actionController.reviewIndex.value == 0
                                        ? ColorResources.blue1
                                        : ColorResources.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Obx(
                  () => InkWell(
                    onTap: () {
                      actionController.changeReview(1);
                    },
                    child: Container(
                      height: 24,
                      // width: 90,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: themeController.isLightTheme.value
                              ? actionController.reviewIndex.value == 1
                                  ? ColorResources.blue1
                                  : ColorResources.white13
                              : actionController.reviewIndex.value == 1
                                  ? ColorResources.blue1
                                  : ColorResources.black4,
                        ),
                        color: themeController.isLightTheme.value
                            ? ColorResources.white13
                            : ColorResources.black4,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Row(
                          children: [
                            RatingBar(
                              itemSize: 20,
                              maxRating: 3,
                              initialRating: 3,
                              itemCount: 3,
                              direction: Axis.horizontal,
                              ratingWidget: RatingWidget(
                                full: Icon(
                                  Icons.star,
                                  color: ColorResources.yellow,
                                ),
                                empty: Icon(
                                  Icons.star,
                                  color: ColorResources.white,
                                ),
                                half: Icon(Icons.star),
                              ),
                              onRatingUpdate: (rating) {},
                            ),
                            Text(
                              "& Up",
                              style: TextStyle(
                                fontFamily: TextFontFamily.SEN_REGULAR,
                                fontSize: 10,
                                color: themeController.isLightTheme.value
                                    ? actionController.reviewIndex.value == 1
                                        ? ColorResources.blue1
                                        : ColorResources.black2
                                    : actionController.reviewIndex.value == 1
                                        ? ColorResources.blue1
                                        : ColorResources.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Obx(
                  () => InkWell(
                    onTap: () {
                      actionController.changeReview(2);
                    },
                    child: Container(
                      height: 24,
                      //width: 75,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: themeController.isLightTheme.value
                              ? actionController.reviewIndex.value == 2
                                  ? ColorResources.blue1
                                  : ColorResources.white13
                              : actionController.reviewIndex.value == 2
                                  ? ColorResources.blue1
                                  : ColorResources.black4,
                        ),
                        color: themeController.isLightTheme.value
                            ? ColorResources.white13
                            : ColorResources.black4,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Row(
                          children: [
                            RatingBar(
                              itemSize: 20,
                              maxRating: 2,
                              initialRating: 2,
                              itemCount: 2,
                              direction: Axis.horizontal,
                              ratingWidget: RatingWidget(
                                full: Icon(
                                  Icons.star,
                                  color: ColorResources.yellow,
                                ),
                                empty: Icon(
                                  Icons.star,
                                  color: ColorResources.white,
                                ),
                                half: Icon(Icons.star),
                              ),
                              onRatingUpdate: (rating) {},
                            ),
                            Text(
                              "& Up",
                              style: TextStyle(
                                fontFamily: TextFontFamily.SEN_REGULAR,
                                fontSize: 10,
                                color: themeController.isLightTheme.value
                                    ? actionController.reviewIndex.value == 2
                                        ? ColorResources.blue1
                                        : ColorResources.black2
                                    : actionController.reviewIndex.value == 2
                                        ? ColorResources.blue1
                                        : ColorResources.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Obx(
                  () => InkWell(
                    onTap: () {
                      actionController.changeReview(3);
                    },
                    child: Container(
                      height: 24,
                      width: 62,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: themeController.isLightTheme.value
                              ? actionController.reviewIndex.value == 3
                                  ? ColorResources.blue1
                                  : ColorResources.white13
                              : actionController.reviewIndex.value == 3
                                  ? ColorResources.blue1
                                  : ColorResources.black4,
                        ),
                        color: themeController.isLightTheme.value
                            ? ColorResources.white13
                            : ColorResources.black4,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Row(
                          children: [
                            RatingBar(
                              itemSize: 20,
                              maxRating: 1,
                              initialRating: 1,
                              itemCount: 1,
                              direction: Axis.horizontal,
                              ratingWidget: RatingWidget(
                                full: Icon(
                                  Icons.star,
                                  color: ColorResources.yellow,
                                ),
                                empty: Icon(
                                  Icons.star,
                                  color: ColorResources.white,
                                ),
                                half: Icon(Icons.star),
                              ),
                              onRatingUpdate: (rating) {},
                            ),
                            Text(
                              "& Up",
                              style: TextStyle(
                                fontFamily: TextFontFamily.SEN_REGULAR,
                                fontSize: 10,
                                color: themeController.isLightTheme.value
                                    ? actionController.reviewIndex.value == 3
                                        ? ColorResources.blue1
                                        : ColorResources.black2
                                    : actionController.reviewIndex.value == 3
                                        ? ColorResources.blue1
                                        : ColorResources.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(
              thickness: 0.5,
              color: themeController.isLightTheme.value
                  ? ColorResources.grey4
                  : ColorResources.white.withOpacity(0.4),
            ),
            SizedBox(height: 15),
            Text(
              "Sort by",
              style: TextStyle(
                fontFamily: TextFontFamily.SEN_BOLD,
                fontSize: 14,
                color: themeController.isLightTheme.value
                    ? ColorResources.black2
                    : ColorResources.white,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Obx(
                  () => InkWell(
                    onTap: () {
                      actionController
                          .changePriceSortType(PriceSortType.lowToHigh);
                    },
                    child: Container(
                      height: 24,
                      //width: 52,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: themeController.isLightTheme.value
                              ? actionController.priceSortType.value ==
                                      PriceSortType.lowToHigh
                                  ? ColorResources.blue1
                                  : ColorResources.white13
                              : actionController.priceSortType.value ==
                                      PriceSortType.lowToHigh
                                  ? ColorResources.blue1
                                  : ColorResources.black4,
                        ),
                        color: themeController.isLightTheme.value
                            ? ColorResources.white13
                            : ColorResources.black4,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Text(
                            "Price: Low to High",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_REGULAR,
                              fontSize: 12,
                              color: themeController.isLightTheme.value
                                  ? actionController.priceSortType.value ==
                                          PriceSortType.lowToHigh
                                      ? ColorResources.blue1
                                      : ColorResources.black2
                                  : actionController.priceSortType.value ==
                                          PriceSortType.lowToHigh
                                      ? ColorResources.blue1
                                      : ColorResources.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Obx(
                      () => InkWell(
                        onTap: () {
                          actionController
                              .changePriceSortType(PriceSortType.highToLow);
                        },
                        child: Container(
                          height: 24,
                          //width: 52,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: themeController.isLightTheme.value
                                  ? actionController.priceSortType.value ==
                                          PriceSortType.highToLow
                                      ? ColorResources.blue1
                                      : ColorResources.white13
                                  : actionController.priceSortType.value ==
                                          PriceSortType.highToLow
                                      ? ColorResources.blue1
                                      : ColorResources.black4,
                            ),
                            color: themeController.isLightTheme.value
                                ? ColorResources.white13
                                : ColorResources.black4,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Text(
                                "Price: High to Low",
                                style: TextStyle(
                                  fontFamily: TextFontFamily.SEN_REGULAR,
                                  fontSize: 12,
                                  color: themeController.isLightTheme.value
                                      ? actionController.priceSortType.value ==
                                              PriceSortType.highToLow
                                          ? ColorResources.blue1
                                          : ColorResources.black2
                                      : actionController.priceSortType.value ==
                                              PriceSortType.highToLow
                                          ? ColorResources.blue1
                                          : ColorResources.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                //Reset Sort
                Expanded(
                  child: Obx(
                    () => InkWell(
                      onTap: () {
                        log("****Reset Sorting...");
                        actionController.resetSort();
                        Get.back();
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeController.isLightTheme.value
                                ? ColorResources.blue1
                                : ColorResources.black2,
                          ),
                          color: themeController.isLightTheme.value
                              ? ColorResources.blue1
                              : ColorResources.black6,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Reset",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_REGULAR,
                              fontSize: 14,
                              color: themeController.isLightTheme.value
                                  ? ColorResources.white
                                  : ColorResources.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                //Apply Sort
                Expanded(
                  child: Obx(
                    () => InkWell(
                      onTap: () {
                        log("****Start Sorting...");
                        actionController.applySort();
                        Get.back();
                      },
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeController.isLightTheme.value
                                ? ColorResources.blue1
                                : ColorResources.black2,
                          ),
                          color: themeController.isLightTheme.value
                              ? ColorResources.blue1
                              : ColorResources.black6,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "Apply",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_REGULAR,
                              fontSize: 14,
                              color: themeController.isLightTheme.value
                                  ? ColorResources.white
                                  : ColorResources.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
