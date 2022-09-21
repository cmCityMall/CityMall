import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/favoritegridfavoritecontroller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);

  final ThemeController themeController = Get.put(ThemeController());
  final FavouriteController controller = Get.put(FavouriteController());
  List<Map> favoriteGridList = [
    {
      "image": Images.purseimage,
      "text": "Nike Air Max 270 React ENG",
      "price": "\$299,43",
    },
    {
      "image": Images.shoesimage,
      "text": "Nike Air Max 270 React ENG",
      "price": "\$299,43",
    },
    {
      "image": Images.clothesimage,
      "text": "Mentli Solid Blue Sliim Fit",
      "price": "\$50,00",
    },
    {
      "image": Images.nacklessimage,
      "text": "Korea Choker The Black",
      "price": "\$29,43",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeController.isLightTheme.value
          ? ColorResources.white
          : ColorResources.black4,
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: GridView.builder(
              itemCount: favoriteGridList.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: Get.width > 450
                    ? 1.58 / 2.1
                    : Get.width < 370
                        ? 1.62 / 2.68
                        : 1.8 / 2.5,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: themeController.isLightTheme.value
                          ? ColorResources.white
                          : ColorResources.black5,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: themeController.isLightTheme.value
                              ? ColorResources.blue1.withOpacity(0.05)
                              : ColorResources.black1,
                          spreadRadius: 0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                backgroundColor: ColorResources.white6,
                                contentPadding: EdgeInsets.zero,
                                title: "",
                                titlePadding: EdgeInsets.zero,
                                content: Center(
                                  child: Image.asset(
                                    favoriteGridList[index]["image"],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 150,
                              width: Get.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: ColorResources.white6,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Image.asset(
                                  favoriteGridList[index]["image"],
                                ),
                              ),
                            ),
                          ),
                          Text(
                            favoriteGridList[index]["text"],
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: TextFontFamily.SEN_BOLD,
                              color: themeController.isLightTheme.value
                                  ? ColorResources.black2
                                  : ColorResources.white,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                favoriteGridList[index]["price"],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: TextFontFamily.SEN_EXTRA_BOLD,
                                  color: ColorResources.blue1,
                                ),
                              ),
                              Obx(
                                () => InkWell(
                                  onTap: () {
                                    controller.favourite[index] =
                                        !controller.favourite[index];
                                  },
                                  child: controller.favourite[index] == false
                                      ? SvgPicture.asset(
                                          Images.blankfavoriteicon)
                                      : SvgPicture.asset(
                                          Images.fillfavoriteicon),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RatingBar(
                                itemSize: 16,
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
                              Text(
                                "932 Sale",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: TextFontFamily.SEN_REGULAR,
                                  color: ColorResources.white3,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
