import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/productdetailsscreen/productdetailscreen.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class ViewAllReviewScreen extends StatelessWidget {
  ViewAllReviewScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
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
              Get.off(ProductDetailScreen());
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
                      initialRating: 4,
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
                      "4.5",
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
                    itemCount: 4,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage(Images.reviewprofile),
                              ),
                              title: Text(
                                "John Doe",
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
                                initialRating: 4,
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
                                "December 10, 2022",
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
                              "air max are always very comfortable fit, clean and"
                              "just perfect in every way. just the box was too small"
                              "and scrunched the sneakers up a little bit,",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
