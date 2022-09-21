import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/clickcontroller.dart';
import 'package:citymall/controller/slidercontroller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DialogueScreen extends StatelessWidget {
  DialogueScreen({Key? key}) : super(key: key);

  final ThemeController themeController = Get.put(ThemeController());
  SliderController sliderController = Get.put(SliderController());
  final BrandClickController ontapBrandController =
      Get.put(BrandClickController());
  final ReviewClickController ontapReviewController =
      Get.put(ReviewClickController());
  final SortByClickController ontapSortByController =
      Get.put(SortByClickController());
  final ResetApplyClickController ontapResetApplyController =
      Get.put(ResetApplyClickController());

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: themeController.isLightTheme.value
          ? ColorResources.white
          : ColorResources.black1,
      titlePadding: EdgeInsets.all(0),
      contentPadding: EdgeInsets.all(0),
      content: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Divider(
                thickness: 0.5,
                color: themeController.isLightTheme.value
                    ? ColorResources.grey4
                    : ColorResources.white.withOpacity(0.4),
              ),
              SizedBox(height: 15),
              Text(
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
                  min: 0,
                  max: 60,
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
                    "\$ 50.000",
                    style: TextStyle(
                      fontFamily: TextFontFamily.SEN_BOLD,
                      fontSize: 12,
                      color: themeController.isLightTheme.value
                          ? ColorResources.black2
                          : ColorResources.white,
                    ),
                  ),
                  Text(
                    "\$ 100.000",
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
              SizedBox(height: 20),
              Divider(
                thickness: 0.5,
                color: themeController.isLightTheme.value
                    ? ColorResources.grey4
                    : ColorResources.white.withOpacity(0.4),
              ),
              SizedBox(height: 15),
              Text(
                "Brand",
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
                        if (ontapBrandController.one.isTrue ||
                            ontapBrandController.two.isTrue ||
                            ontapBrandController.three.isTrue ||
                            ontapBrandController.four.isTrue ||
                            ontapBrandController.five.isTrue ||
                            ontapBrandController.six.isTrue ||
                            ontapBrandController.seven.isTrue ||
                            ontapBrandController.eight.isTrue) {
                          ontapBrandController.one(false);
                          ontapBrandController.two(false);
                          ontapBrandController.three(false);
                          ontapBrandController.four(false);
                          ontapBrandController.five(false);
                          ontapBrandController.six(false);
                          ontapBrandController.seven(false);
                          ontapBrandController.eight(false);
                        }
                        ontapBrandController.one(true);
                      },
                      child: Container(
                        height: 24,
                        width: 52,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeController.isLightTheme.value
                                ? ontapBrandController.one.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.white13
                                : ontapBrandController.one.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.black4,
                          ),
                          color: themeController.isLightTheme.value
                              ? ColorResources.white13
                              : ColorResources.black4,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            "Nike",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_REGULAR,
                              fontSize: 10,
                              color: themeController.isLightTheme.value
                                  ? ontapBrandController.one.isTrue
                                      ? ColorResources.blue1
                                      : ColorResources.black2
                                  : ontapBrandController.one.isTrue
                                      ? ColorResources.blue1
                                      : ColorResources.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Obx(
                    () => InkWell(
                      onTap: () {
                        if (ontapBrandController.one.isTrue ||
                            ontapBrandController.two.isTrue ||
                            ontapBrandController.three.isTrue ||
                            ontapBrandController.four.isTrue ||
                            ontapBrandController.five.isTrue ||
                            ontapBrandController.six.isTrue ||
                            ontapBrandController.seven.isTrue ||
                            ontapBrandController.eight.isTrue) {
                          ontapBrandController.one(false);
                          ontapBrandController.two(false);
                          ontapBrandController.three(false);
                          ontapBrandController.four(false);
                          ontapBrandController.five(false);
                          ontapBrandController.six(false);
                          ontapBrandController.seven(false);
                          ontapBrandController.eight(false);
                        }
                        ontapBrandController.two(true);
                      },
                      child: Container(
                        height: 24,
                        width: 52,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeController.isLightTheme.value
                                ? ontapBrandController.two.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.white13
                                : ontapBrandController.two.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.black4,
                          ),
                          color: themeController.isLightTheme.value
                              ? ColorResources.white13
                              : ColorResources.black4,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            "Korea",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_REGULAR,
                              fontSize: 10,
                              color: themeController.isLightTheme.value
                                  ? ontapBrandController.two.isTrue
                                      ? ColorResources.blue1
                                      : ColorResources.black2
                                  : ontapBrandController.two.isTrue
                                      ? ColorResources.blue1
                                      : ColorResources.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Obx(
                    () => InkWell(
                      onTap: () {
                        if (ontapBrandController.one.isTrue ||
                            ontapBrandController.two.isTrue ||
                            ontapBrandController.three.isTrue ||
                            ontapBrandController.four.isTrue ||
                            ontapBrandController.five.isTrue ||
                            ontapBrandController.six.isTrue ||
                            ontapBrandController.seven.isTrue ||
                            ontapBrandController.eight.isTrue) {
                          ontapBrandController.one(false);
                          ontapBrandController.two(false);
                          ontapBrandController.three(false);
                          ontapBrandController.four(false);
                          ontapBrandController.five(false);
                          ontapBrandController.six(false);
                          ontapBrandController.seven(false);
                          ontapBrandController.eight(false);
                        }
                        ontapBrandController.three(true);
                      },
                      child: Container(
                        height: 24,
                        width: 52,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeController.isLightTheme.value
                                ? ontapBrandController.three.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.white13
                                : ontapBrandController.three.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.black4,
                          ),
                          color: themeController.isLightTheme.value
                              ? ColorResources.white13
                              : ColorResources.black4,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            "Mentli",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_REGULAR,
                              fontSize: 10,
                              color: themeController.isLightTheme.value
                                  ? ontapBrandController.three.isTrue
                                      ? ColorResources.blue1
                                      : ColorResources.black2
                                  : ontapBrandController.three.isTrue
                                      ? ColorResources.blue1
                                      : ColorResources.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Obx(
                    () => InkWell(
                      onTap: () {
                        if (ontapBrandController.one.isTrue ||
                            ontapBrandController.two.isTrue ||
                            ontapBrandController.three.isTrue ||
                            ontapBrandController.four.isTrue ||
                            ontapBrandController.five.isTrue ||
                            ontapBrandController.six.isTrue ||
                            ontapBrandController.seven.isTrue ||
                            ontapBrandController.eight.isTrue) {
                          ontapBrandController.one(false);
                          ontapBrandController.two(false);
                          ontapBrandController.three(false);
                          ontapBrandController.four(false);
                          ontapBrandController.five(false);
                          ontapBrandController.six(false);
                          ontapBrandController.seven(false);
                          ontapBrandController.eight(false);
                        }
                        ontapBrandController.six(true);
                      },
                      child: Container(
                        height: 24,
                        width: 52,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeController.isLightTheme.value
                                ? ontapBrandController.six.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.white13
                                : ontapBrandController.six.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.black4,
                          ),
                          color: themeController.isLightTheme.value
                              ? ColorResources.white13
                              : ColorResources.black4,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            "Prada",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_REGULAR,
                              fontSize: 10,
                              color: themeController.isLightTheme.value
                                  ? ontapBrandController.six.isTrue
                                      ? ColorResources.blue1
                                      : ColorResources.black2
                                  : ontapBrandController.six.isTrue
                                      ? ColorResources.blue1
                                      : ColorResources.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Obx(
                    () => InkWell(
                      onTap: () {
                        if (ontapBrandController.one.isTrue ||
                            ontapBrandController.two.isTrue ||
                            ontapBrandController.three.isTrue ||
                            ontapBrandController.four.isTrue ||
                            ontapBrandController.five.isTrue ||
                            ontapBrandController.six.isTrue ||
                            ontapBrandController.seven.isTrue ||
                            ontapBrandController.eight.isTrue) {
                          ontapBrandController.one(false);
                          ontapBrandController.two(false);
                          ontapBrandController.three(false);
                          ontapBrandController.four(false);
                          ontapBrandController.five(false);
                          ontapBrandController.six(false);
                          ontapBrandController.seven(false);
                          ontapBrandController.eight(false);
                        }
                        ontapBrandController.seven(true);
                      },
                      child: Container(
                        height: 24,
                        width: 52,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeController.isLightTheme.value
                                ? ontapBrandController.seven.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.white13
                                : ontapBrandController.seven.isTrue
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
                              "Samsung ",
                              style: TextStyle(
                                fontFamily: TextFontFamily.SEN_REGULAR,
                                fontSize: 10,
                                color: themeController.isLightTheme.value
                                    ? ontapBrandController.seven.isTrue
                                        ? ColorResources.blue1
                                        : ColorResources.black2
                                    : ontapBrandController.seven.isTrue
                                        ? ColorResources.blue1
                                        : ColorResources.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Obx(
                    () => InkWell(
                      onTap: () {
                        if (ontapBrandController.one.isTrue ||
                            ontapBrandController.two.isTrue ||
                            ontapBrandController.three.isTrue ||
                            ontapBrandController.four.isTrue ||
                            ontapBrandController.five.isTrue ||
                            ontapBrandController.six.isTrue ||
                            ontapBrandController.seven.isTrue ||
                            ontapBrandController.eight.isTrue) {
                          ontapBrandController.one(false);
                          ontapBrandController.two(false);
                          ontapBrandController.three(false);
                          ontapBrandController.four(false);
                          ontapBrandController.five(false);
                          ontapBrandController.six(false);
                          ontapBrandController.seven(false);
                          ontapBrandController.eight(false);
                        }
                        ontapBrandController.eight(true);
                      },
                      child: Container(
                        height: 24,
                        width: 52,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeController.isLightTheme.value
                                ? ontapBrandController.eight.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.white13
                                : ontapBrandController.eight.isTrue
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
                              "Samsung ",
                              style: TextStyle(
                                fontFamily: TextFontFamily.SEN_REGULAR,
                                fontSize: 10,
                                color: themeController.isLightTheme.value
                                    ? ontapBrandController.eight.isTrue
                                        ? ColorResources.blue1
                                        : ColorResources.black2
                                    : ontapBrandController.eight.isTrue
                                        ? ColorResources.blue1
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
              SizedBox(height: 12),
              Row(
                children: [
                  Obx(
                    () => InkWell(
                      onTap: () {
                        if (ontapBrandController.one.isTrue ||
                            ontapBrandController.two.isTrue ||
                            ontapBrandController.three.isTrue ||
                            ontapBrandController.four.isTrue ||
                            ontapBrandController.five.isTrue ||
                            ontapBrandController.six.isTrue ||
                            ontapBrandController.seven.isTrue ||
                            ontapBrandController.eight.isTrue) {
                          ontapBrandController.one(false);
                          ontapBrandController.two(false);
                          ontapBrandController.three(false);
                          ontapBrandController.four(false);
                          ontapBrandController.five(false);
                          ontapBrandController.six(false);
                          ontapBrandController.seven(false);
                          ontapBrandController.eight(false);
                        }
                        ontapBrandController.four(true);
                      },
                      child: Container(
                        height: 24,
                        width: 52,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeController.isLightTheme.value
                                ? ontapBrandController.four.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.white13
                                : ontapBrandController.four.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.black4,
                          ),
                          color: themeController.isLightTheme.value
                              ? ColorResources.white13
                              : ColorResources.black4,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            "Sony",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_REGULAR,
                              fontSize: 10,
                              color: themeController.isLightTheme.value
                                  ? ontapBrandController.four.isTrue
                                      ? ColorResources.blue1
                                      : ColorResources.black2
                                  : ontapBrandController.four.isTrue
                                      ? ColorResources.blue1
                                      : ColorResources.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Obx(
                    () => InkWell(
                      onTap: () {
                        if (ontapBrandController.one.isTrue ||
                            ontapBrandController.two.isTrue ||
                            ontapBrandController.three.isTrue ||
                            ontapBrandController.four.isTrue ||
                            ontapBrandController.five.isTrue ||
                            ontapBrandController.six.isTrue ||
                            ontapBrandController.seven.isTrue ||
                            ontapBrandController.eight.isTrue) {
                          ontapBrandController.one(false);
                          ontapBrandController.two(false);
                          ontapBrandController.three(false);
                          ontapBrandController.four(false);
                          ontapBrandController.five(false);
                          ontapBrandController.six(false);
                          ontapBrandController.seven(false);
                          ontapBrandController.eight(false);
                        }
                        ontapBrandController.five(true);
                      },
                      child: Container(
                        height: 24,
                        width: 52,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeController.isLightTheme.value
                                ? ontapBrandController.five.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.white13
                                : ontapBrandController.five.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.black4,
                          ),
                          color: themeController.isLightTheme.value
                              ? ColorResources.white13
                              : ColorResources.black4,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            "Sony",
                            style: TextStyle(
                              fontFamily: TextFontFamily.SEN_REGULAR,
                              fontSize: 10,
                              color: themeController.isLightTheme.value
                                  ? ontapBrandController.five.isTrue
                                      ? ColorResources.blue1
                                      : ColorResources.black2
                                  : ontapBrandController.five.isTrue
                                      ? ColorResources.blue1
                                      : ColorResources.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 22),
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
                        if (ontapReviewController.one.isTrue ||
                            ontapReviewController.two.isTrue ||
                            ontapReviewController.three.isTrue ||
                            ontapReviewController.four.isTrue) {
                          ontapReviewController.one(false);
                          ontapReviewController.two(false);
                          ontapReviewController.three(false);
                          ontapReviewController.four(false);
                        }
                        ontapReviewController.one(true);
                      },
                      child: Container(
                        height: 24,
                        //width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeController.isLightTheme.value
                                ? ontapReviewController.one.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.white13
                                : ontapReviewController.one.isTrue
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
                                      ? ontapBrandController.one.isTrue
                                          ? ColorResources.blue1
                                          : ColorResources.black2
                                      : ontapBrandController.one.isTrue
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
                        if (ontapReviewController.one.isTrue ||
                            ontapReviewController.two.isTrue ||
                            ontapReviewController.three.isTrue ||
                            ontapReviewController.four.isTrue) {
                          ontapReviewController.one(false);
                          ontapReviewController.two(false);
                          ontapReviewController.three(false);
                          ontapReviewController.four(false);
                        }
                        ontapReviewController.two(true);
                      },
                      child: Container(
                        height: 24,
                        // width: 90,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeController.isLightTheme.value
                                ? ontapReviewController.two.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.white13
                                : ontapReviewController.two.isTrue
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
                                      ? ontapReviewController.two.isTrue
                                          ? ColorResources.blue1
                                          : ColorResources.black2
                                      : ontapReviewController.two.isTrue
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
                        if (ontapReviewController.one.isTrue ||
                            ontapReviewController.two.isTrue ||
                            ontapReviewController.three.isTrue ||
                            ontapReviewController.four.isTrue) {
                          ontapReviewController.one(false);
                          ontapReviewController.two(false);
                          ontapReviewController.three(false);
                          ontapReviewController.four(false);
                        }
                        ontapReviewController.three(true);
                      },
                      child: Container(
                        height: 24,
                        //width: 75,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeController.isLightTheme.value
                                ? ontapReviewController.three.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.white13
                                : ontapReviewController.three.isTrue
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
                                      ? ontapReviewController.three.isTrue
                                          ? ColorResources.blue1
                                          : ColorResources.black2
                                      : ontapReviewController.three.isTrue
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
                        if (ontapReviewController.one.isTrue ||
                            ontapReviewController.two.isTrue ||
                            ontapReviewController.three.isTrue ||
                            ontapReviewController.four.isTrue) {
                          ontapReviewController.one(false);
                          ontapReviewController.two(false);
                          ontapReviewController.three(false);
                          ontapReviewController.four(false);
                        }
                        ontapReviewController.four(true);
                      },
                      child: Container(
                        height: 24,
                        width: 62,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeController.isLightTheme.value
                                ? ontapReviewController.four.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.white13
                                : ontapReviewController.four.isTrue
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
                                      ? ontapReviewController.four.isTrue
                                          ? ColorResources.blue1
                                          : ColorResources.black2
                                      : ontapReviewController.four.isTrue
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
                        if (ontapSortByController.one.isTrue ||
                            ontapSortByController.two.isTrue ||
                            ontapSortByController.three.isTrue ||
                            ontapSortByController.four.isTrue ||
                            ontapSortByController.five.isTrue) {
                          ontapSortByController.one(false);
                          ontapSortByController.two(false);
                          ontapSortByController.three(false);
                          ontapSortByController.four(false);
                          ontapSortByController.five(false);
                        }
                        ontapSortByController.one(true);
                      },
                      child: Container(
                        height: 24,
                        //width: 52,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeController.isLightTheme.value
                                ? ontapSortByController.one.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.white13
                                : ontapSortByController.one.isTrue
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
                                    ? ontapSortByController.one.isTrue
                                        ? ColorResources.blue1
                                        : ColorResources.black2
                                    : ontapSortByController.one.isTrue
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
                  Obx(
                    () => InkWell(
                      onTap: () {
                        if (ontapSortByController.one.isTrue ||
                            ontapSortByController.two.isTrue ||
                            ontapSortByController.three.isTrue ||
                            ontapSortByController.four.isTrue ||
                            ontapSortByController.five.isTrue) {
                          ontapSortByController.one(false);
                          ontapSortByController.two(false);
                          ontapSortByController.three(false);
                          ontapSortByController.four(false);
                          ontapSortByController.five(false);
                        }
                        ontapSortByController.two(true);
                      },
                      child: Container(
                        height: 24,
                        //width: 52,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeController.isLightTheme.value
                                ? ontapSortByController.two.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.white13
                                : ontapSortByController.two.isTrue
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
                              "Featured",
                              style: TextStyle(
                                fontFamily: TextFontFamily.SEN_REGULAR,
                                fontSize: 12,
                                color: themeController.isLightTheme.value
                                    ? ontapSortByController.two.isTrue
                                        ? ColorResources.blue1
                                        : ColorResources.black2
                                    : ontapSortByController.two.isTrue
                                        ? ColorResources.blue1
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
              SizedBox(height: 10),
              Row(
                children: [
                  Obx(
                    () => InkWell(
                      onTap: () {
                        if (ontapSortByController.one.isTrue ||
                            ontapSortByController.two.isTrue ||
                            ontapSortByController.three.isTrue ||
                            ontapSortByController.four.isTrue ||
                            ontapSortByController.five.isTrue) {
                          ontapSortByController.one(false);
                          ontapSortByController.two(false);
                          ontapSortByController.three(false);
                          ontapSortByController.four(false);
                          ontapSortByController.five(false);
                        }
                        ontapSortByController.three(true);
                      },
                      child: Container(
                        height: 24,
                        //width: 52,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeController.isLightTheme.value
                                ? ontapSortByController.three.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.white13
                                : ontapSortByController.three.isTrue
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
                              "Price: High to Low",
                              style: TextStyle(
                                fontFamily: TextFontFamily.SEN_REGULAR,
                                fontSize: 12,
                                color: themeController.isLightTheme.value
                                    ? ontapSortByController.three.isTrue
                                        ? ColorResources.blue1
                                        : ColorResources.black2
                                    : ontapSortByController.three.isTrue
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
                  Obx(
                    () => InkWell(
                      onTap: () {
                        if (ontapSortByController.one.isTrue ||
                            ontapSortByController.two.isTrue ||
                            ontapSortByController.three.isTrue ||
                            ontapSortByController.four.isTrue ||
                            ontapSortByController.five.isTrue) {
                          ontapSortByController.one(false);
                          ontapSortByController.two(false);
                          ontapSortByController.three(false);
                          ontapSortByController.four(false);
                          ontapSortByController.five(false);
                        }
                        ontapSortByController.four(true);
                      },
                      child: Container(
                        height: 24,
                        //width: 52,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeController.isLightTheme.value
                                ? ontapSortByController.four.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.white13
                                : ontapSortByController.four.isTrue
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
                              "Feutred",
                              style: TextStyle(
                                fontFamily: TextFontFamily.SEN_REGULAR,
                                fontSize: 12,
                                color: themeController.isLightTheme.value
                                    ? ontapSortByController.four.isTrue
                                        ? ColorResources.blue1
                                        : ColorResources.black2
                                    : ontapSortByController.four.isTrue
                                        ? ColorResources.blue1
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
              SizedBox(height: 10),
              Obx(
                () => InkWell(
                  onTap: () {
                    if (ontapSortByController.one.isTrue ||
                        ontapSortByController.two.isTrue ||
                        ontapSortByController.three.isTrue ||
                        ontapSortByController.four.isTrue ||
                        ontapSortByController.five.isTrue) {
                      ontapSortByController.one(false);
                      ontapSortByController.two(false);
                      ontapSortByController.three(false);
                      ontapSortByController.four(false);
                      ontapSortByController.five(false);
                    }
                    ontapSortByController.five(true);
                  },
                  child: Container(
                    height: 24,
                    width: 105,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: themeController.isLightTheme.value
                            ? ontapSortByController.five.isTrue
                                ? ColorResources.blue1
                                : ColorResources.white13
                            : ontapSortByController.five.isTrue
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
                          "Newest Arrivals",
                          style: TextStyle(
                            fontFamily: TextFontFamily.SEN_REGULAR,
                            fontSize: 12,
                            color: themeController.isLightTheme.value
                                ? ontapSortByController.five.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.black2
                                : ontapSortByController.five.isTrue
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
              Row(
                children: [
                  Expanded(
                    child: Obx(
                      () => InkWell(
                        onTap: () {
                          if (ontapResetApplyController.one.isTrue ||
                              ontapResetApplyController.two.isTrue) {
                            ontapResetApplyController.one(false);
                            ontapResetApplyController.two(false);
                          }
                          ontapResetApplyController.one(true);
                        },
                        child: Container(
                          height: 50,
                          width: Get.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: themeController.isLightTheme.value
                                  ? ontapResetApplyController.one.isTrue
                                      ? ColorResources.blue1
                                      : ColorResources.black2
                                  : ontapResetApplyController.one.isTrue
                                      ? ColorResources.blue1
                                      : ColorResources.white,
                            ),
                            color: themeController.isLightTheme.value
                                ? ontapResetApplyController.one.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.white
                                : ontapResetApplyController.one.isTrue
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
                                    ? ontapResetApplyController.one.isTrue
                                        ? ColorResources.white
                                        : ColorResources.black2
                                    : ontapBrandController.one.isTrue
                                        ? ColorResources.white
                                        : ColorResources.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Obx(
                      () => InkWell(
                        onTap: () {
                          if (ontapResetApplyController.one.isTrue ||
                              ontapResetApplyController.two.isTrue) {
                            ontapResetApplyController.one(false);
                            ontapResetApplyController.two(false);
                          }
                          ontapResetApplyController.two(true);
                        },
                        child: Container(
                          height: 50,
                          width: Get.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: themeController.isLightTheme.value
                                  ? ontapResetApplyController.two.isTrue
                                      ? ColorResources.blue1
                                      : ColorResources.black2
                                  : ontapResetApplyController.two.isTrue
                                      ? ColorResources.blue1
                                      : ColorResources.white,
                            ),
                            color: themeController.isLightTheme.value
                                ? ontapResetApplyController.two.isTrue
                                    ? ColorResources.blue1
                                    : ColorResources.white
                                : ontapResetApplyController.two.isTrue
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
                                    ? ontapResetApplyController.two.isTrue
                                        ? ColorResources.white
                                        : ColorResources.black2
                                    : ontapBrandController.two.isTrue
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
            ],
          ),
        ),
      ),
    );
  }
}
