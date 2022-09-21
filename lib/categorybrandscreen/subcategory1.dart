import 'package:citymall/categorybrandscreen/subcategory2.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/recomendedfavoritecontroller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/rout_screens/rout_1.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SubCategoryScreen1 extends StatelessWidget {
  SubCategoryScreen1({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());
  final RecomendedFavouriteController controller =
      Get.put(RecomendedFavouriteController());
  List<Map> subcategory1GridList = [
    {
      "image": Images.nikeshoes1,
    },
    {
      "image": Images.nikeshoes2,
    },
    {
      "image": Images.nikeshoes3,
    },
    {
      "image": Images.nikeshoes4,
    },
    {
      "image": Images.nikeshoes5,
    },
    {
      "image": Images.nikeshoes6,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeController.isLightTheme.value
          ? ColorResources.white
          : ColorResources.black4,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: themeController.isLightTheme.value
                ? ColorResources.white
                : ColorResources.black4,
            leading: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: InkWell(
                onTap: () {
                  selectedIndex = 3;
                  Navigator.of(context, rootNavigator: true)
                      .pushReplacement(MaterialPageRoute(
                    builder: (context) => NavigationBarBottom(),
                  ));
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
            elevation: 0,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.asset(
                    Images.sliverimage1,
                    fit: BoxFit.cover,
                    width: Get.width,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text(
                      "Nike Sport",
                      style: TextStyle(
                        fontFamily: TextFontFamily.SEN_BOLD,
                        fontSize: 30,
                        color: ColorResources.black2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
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
                    padding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                    child: GridView.builder(
                      itemCount: subcategory1GridList.length,
                      physics: NeverScrollableScrollPhysics(),
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
                          onTap: () {
                            Get.off(SubCategoryScreen2());
                          },
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                            subcategory1GridList[index]
                                                ["image"],
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
                                          subcategory1GridList[index]["image"],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Nike Sport Shoes\nMan...",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: TextFontFamily.SEN_BOLD,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.black2
                                          : ColorResources.white,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$100,00",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily:
                                              TextFontFamily.SEN_EXTRA_BOLD,
                                          color: ColorResources.blue1,
                                        ),
                                      ),
                                      Obx(
                                        () => InkWell(
                                          onTap: () {
                                            controller.favourite1[index] =
                                                !controller.favourite1[index];
                                          },
                                          child: controller.favourite1[index] ==
                                                  false
                                              ? SvgPicture.asset(
                                                  Images.blankfavoriteicon)
                                              : SvgPicture.asset(
                                                  Images.fillfavoriteicon),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                          fontFamily:
                                              TextFontFamily.SEN_REGULAR,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
