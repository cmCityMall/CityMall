import 'package:carousel_slider/carousel_slider.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/fashionmanhomefavoritecontroller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/homescreen/fashionmandashboardscreen/fashionmansubcategoryviewallscreen.dart';
import 'package:citymall/homescreen/fashionmandashboardscreen/mansscreen.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/rout_screens/rout_1.dart';
import 'package:citymall/searchscreen/subsearchscreen.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class FashionManDashboard extends StatelessWidget {
  FashionManDashboard({Key? key}) : super(key: key);

  final ThemeController themeController = Get.put(ThemeController());
  final FashionManHomeFavouriteController favorite =
      Get.put(FashionManHomeFavouriteController());
  List<Map> fashionManSliderlist = [
    {
      "image": Images.fashionmanslider1,
    },
    {
      "image": Images.cameraslider2,
    },
    {
      "image": Images.cameraslider3,
    },
  ];

  List<Map> fashionManHomeGridList = [
    {
      "image": Images.mans,
      "text": "Mans",
    },
    {
      "image": Images.shirt,
      "text": "Shirt",
    },
    {
      "image": Images.tshirt,
      "text": "T-Shirt",
    },
    {
      "image": Images.watch,
      "text": "Watch",
    },
    {
      "image": Images.shoes,
      "text": "Shoes",
    },
    {
      "image": Images.cctv,
      "text": "CCTV",
    },
  ];

  List<Map> itemDiscountList = [
    {
      "image": Images.purseimage,
      "text": "Nike Air Max 270\nReact ENG",
      "text1": "10%",
      "price": "\$299,43",
    },
    {
      "image": Images.shoesimage,
      "text": "Nike Air Max 270\nReact ENG",
      "text1": "10%",
      "price": "\$299,43",
    },
  ];

  List<Map> itemPopularNewList = [
    {
      "image": Images.clothesimage,
      "text": "Mentli Solid Blue\nSliim Fit",
      "text1": "10%",
      "price": "\$50,00",
    },
    {
      "image": Images.nacklessimage,
      "text": "Korea Choker The\nBlack",
      "text1": "10%",
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
              selectedIndex = 0;
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
        title: Text(
          "Fashion Man",
          style: TextStyle(
            fontFamily: TextFontFamily.SEN_BOLD,
            fontSize: 22,
            color: themeController.isLightTheme.value
                ? ColorResources.black2
                : ColorResources.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: InkWell(
              onTap: () {
                Get.off(SubSearchScreen());
              },
              child: SvgPicture.asset(
                Images.search,
                color: themeController.isLightTheme.value
                    ? ColorResources.white3
                    : ColorResources.white.withOpacity(0.6),
              ),
            ),
          ),
        ],
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
            padding: EdgeInsets.symmetric(vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CarouselSlider.builder(
                    itemCount: fashionManSliderlist.length,
                    itemBuilder:
                        (BuildContext context, index, int pageViewIndex) =>
                            Stack(
                      children: [
                        Container(
                          height: 200,
                          width: Get.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage(
                                  fashionManSliderlist[index]["image"]),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              Images.fashionmanslidercanvas,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Text(
                              "Man Style",
                              style: TextStyle(
                                fontFamily: TextFontFamily.SEN_BOLD,
                                fontSize: 18,
                                color: ColorResources.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    options: CarouselOptions(
                      height: 180,
                      autoPlay: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      initialPage: 3,
                      viewportFraction: 0.75,
                      //aspectRatio: 3.0,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Sub Category",
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: TextFontFamily.SEN_BOLD,
                                color: themeController.isLightTheme.value
                                    ? ColorResources.black2
                                    : ColorResources.white,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FashionManSubCategoryViewAllScreen(),
                                    ));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "View all  ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      color: ColorResources.blue1,
                                    ),
                                  ),
                                  SvgPicture.asset(Images.viewallarrow),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Container(
                          height: Get.height > 805 ? 140 : 115,
                          width: Get.width,
                          color: themeController.isLightTheme.value
                              ? ColorResources.white1
                              : ColorResources.black1,
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 2.2,
                            ),
                            itemCount: fashionManHomeGridList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, right: 5),
                                child: InkWell(
                                  onTap: () {
                                    Get.off(MansScreen());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      image: DecorationImage(
                                        image: AssetImage(
                                            fashionManHomeGridList[index]
                                                ["image"]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        fashionManHomeGridList[index]["text"],
                                        style: TextStyle(
                                          fontFamily: TextFontFamily.SEN_BOLD,
                                          fontSize: 14,
                                          color: ColorResources.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Item Discount",
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: TextFontFamily.SEN_BOLD,
                                color: themeController.isLightTheme.value
                                    ? ColorResources.black2
                                    : ColorResources.white,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => MenuScreen(),
                                //     ));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "View all  ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      color: ColorResources.blue1,
                                    ),
                                  ),
                                  SvgPicture.asset(Images.viewallarrow),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        GridView.builder(
                          itemCount: itemDiscountList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                                          ? ColorResources.blue1
                                              .withOpacity(0.05)
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.defaultDialog(
                                                backgroundColor:
                                                    ColorResources.white6,
                                                contentPadding: EdgeInsets.zero,
                                                title: "",
                                                titlePadding: EdgeInsets.zero,
                                                content: Center(
                                                  child: Image.asset(
                                                    itemDiscountList[index]
                                                        ["image"],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: 150,
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: ColorResources.white6,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Image.asset(
                                                  itemDiscountList[index]
                                                      ["image"],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            child: Container(
                                              height: 22,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(8),
                                                ),
                                                color: ColorResources.blue1,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  itemDiscountList[index]
                                                      ["text1"],
                                                  style: TextStyle(
                                                    color: ColorResources.white,
                                                    fontSize: 12,
                                                    fontFamily:
                                                        TextFontFamily.SEN_BOLD,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        itemDiscountList[index]["text"],
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: TextFontFamily.SEN_BOLD,
                                          color:
                                              themeController.isLightTheme.value
                                                  ? ColorResources.black2
                                                  : ColorResources.white,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            itemDiscountList[index]["price"],
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
                                                favorite.favourite1[index] =
                                                    !favorite.favourite1[index];
                                              },
                                              child: favorite
                                                          .favourite1[index] ==
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
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Item Popular",
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: TextFontFamily.SEN_BOLD,
                                color: themeController.isLightTheme.value
                                    ? ColorResources.black2
                                    : ColorResources.white,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => MenuScreen(),
                                //     ));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "View all  ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      color: ColorResources.blue1,
                                    ),
                                  ),
                                  SvgPicture.asset(Images.viewallarrow),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        GridView.builder(
                          itemCount: itemPopularNewList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                                          ? ColorResources.blue1
                                              .withOpacity(0.05)
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.defaultDialog(
                                                backgroundColor:
                                                    ColorResources.white6,
                                                contentPadding: EdgeInsets.zero,
                                                title: "",
                                                titlePadding: EdgeInsets.zero,
                                                content: Center(
                                                  child: Image.asset(
                                                    itemPopularNewList[index]
                                                        ["image"],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: 150,
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: ColorResources.white6,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Image.asset(
                                                  itemPopularNewList[index]
                                                      ["image"],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            child: Container(
                                              height: 22,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(8),
                                                ),
                                                color: ColorResources.blue1,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  itemPopularNewList[index]
                                                      ["text1"],
                                                  style: TextStyle(
                                                    color: ColorResources.white,
                                                    fontSize: 12,
                                                    fontFamily:
                                                        TextFontFamily.SEN_BOLD,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        itemPopularNewList[index]["text"],
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: TextFontFamily.SEN_BOLD,
                                          color:
                                              themeController.isLightTheme.value
                                                  ? ColorResources.black2
                                                  : ColorResources.white,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            itemPopularNewList[index]["price"],
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
                                                favorite.favourite2[index] =
                                                    !favorite.favourite2[index];
                                              },
                                              child: favorite
                                                          .favourite2[index] ==
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
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "New Item",
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: TextFontFamily.SEN_BOLD,
                                color: themeController.isLightTheme.value
                                    ? ColorResources.black2
                                    : ColorResources.white,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => MenuScreen(),
                                //     ));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "View all  ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      color: ColorResources.blue1,
                                    ),
                                  ),
                                  SvgPicture.asset(Images.viewallarrow),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        GridView.builder(
                          itemCount: itemPopularNewList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                                          ? ColorResources.blue1
                                              .withOpacity(0.05)
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.defaultDialog(
                                                backgroundColor:
                                                    ColorResources.white6,
                                                contentPadding: EdgeInsets.zero,
                                                title: "",
                                                titlePadding: EdgeInsets.zero,
                                                content: Center(
                                                  child: Image.asset(
                                                    itemPopularNewList[index]
                                                        ["image"],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: 150,
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: ColorResources.white6,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Image.asset(
                                                  itemPopularNewList[index]
                                                      ["image"],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 0,
                                            child: Container(
                                              height: 22,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(8),
                                                ),
                                                color: ColorResources.blue1,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  itemPopularNewList[index]
                                                      ["text1"],
                                                  style: TextStyle(
                                                    color: ColorResources.white,
                                                    fontSize: 12,
                                                    fontFamily:
                                                        TextFontFamily.SEN_BOLD,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        itemPopularNewList[index]["text"],
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: TextFontFamily.SEN_BOLD,
                                          color:
                                              themeController.isLightTheme.value
                                                  ? ColorResources.black2
                                                  : ColorResources.white,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            itemPopularNewList[index]["price"],
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
                                                favorite.favourite2[index] =
                                                    !favorite.favourite2[index];
                                              },
                                              child: favorite
                                                          .favourite2[index] ==
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
