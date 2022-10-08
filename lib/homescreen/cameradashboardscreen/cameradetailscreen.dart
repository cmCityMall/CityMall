import 'package:carousel_slider/carousel_slider.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/homescreen/flashdashboard/flashdashboard.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/rout_screens/rout_1.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CameraDetailScreen extends StatelessWidget {
  CameraDetailScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());
  List<Map> topRatedList = [
    {
      "image": Images.purseimage,
      "text": "Nike Air Max 270\nReact ENG",
      "price": "\$299,43",
    },
    {
      "image": Images.shoesimage,
      "text": "Nike Air Max 270\nReact ENG",
      "price": "\$299,43",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeController.isLightTheme.value
          ? ColorResources.black
          : ColorResources.black4,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: themeController.isLightTheme.value
                ? ColorResources.white6
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
              "Product Detail",
              style: TextStyle(
                fontFamily: TextFontFamily.SEN_BOLD,
                fontSize: 22,
                color: ColorResources.white,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8, right: 25),
                child: InkWell(
                  onTap: () {
                    selectedIndex = 4;
                    Navigator.of(context, rootNavigator: true)
                        .pushReplacement(MaterialPageRoute(
                      builder: (context) => NavigationBarBottom(),
                    ));
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: themeController.isLightTheme.value
                          ? ColorResources.white
                          : ColorResources.black6,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        Images.cartblank,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: CarouselSlider.builder(
                itemCount: 4,
                itemBuilder: (BuildContext context, index, int pageViewIndex) =>
                    Stack(
                  children: [
                    Container(
                      width: Get.width,
                      child: Image.asset(
                        Images.cameraslider,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: Get.width >= 411 ? 210 : 150,
                      child: Row(
                        children: List.generate(
                          4,
                          (position) => Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Container(
                              width: position == index ? 14 : 5,
                              height: 5,
                              decoration: BoxDecoration(
                                //shape: BoxShape.circle,
                                borderRadius: BorderRadius.circular(
                                    index == position ? 7 : 2.5),
                                color: index == position
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
                options: CarouselOptions(
                  height: 300,
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  initialPage: 3,
                  viewportFraction: 1,
                  //aspectRatio: 3.0,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                    color: themeController.isLightTheme.value
                        ? ColorResources.white
                        : ColorResources.black1,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                          color: ColorResources.red1,
                        ),
                        child: ListTile(
                          leading: Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: SvgPicture.asset(
                              Images.containerimage,
                              color: ColorResources.white,
                            ),
                          ),
                          title: Padding(
                            padding: EdgeInsets.only(bottom: 8),
                            child: Text(
                              "Flash Sale",
                              style: TextStyle(
                                fontFamily: TextFontFamily.SEN_REGULAR,
                                fontWeight: FontWeight.w800,
                                fontSize: 22,
                                color: ColorResources.white,
                              ),
                            ),
                          ),
                          trailing: Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(
                              "9 Available",
                              style: TextStyle(
                                fontFamily: TextFontFamily.SEN_BOLD,
                                fontSize: 16,
                                color: ColorResources.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Compact Camera\nHigh...",
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_BOLD,
                                    fontSize: 24,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.black2
                                        : ColorResources.white,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: ColorResources.yellow,
                                      ),
                                      Text(
                                        "4.5",
                                        style: TextStyle(
                                          fontFamily: TextFontFamily.SEN_BOLD,
                                          fontSize: 18,
                                          color:
                                              themeController.isLightTheme.value
                                                  ? ColorResources.black2
                                                  : ColorResources.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "\$299,43",
                                      style: TextStyle(
                                        fontFamily:
                                            TextFontFamily.SEN_EXTRA_BOLD,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 25,
                                        color: ColorResources.blue1,
                                      ),
                                    ),
                                    Text(
                                      "\$250,00",
                                      style: TextStyle(
                                        fontFamily: TextFontFamily.SEN_REGULAR,
                                        fontSize: 16,
                                        color:
                                            themeController.isLightTheme.value
                                                ? ColorResources.grey4
                                                : ColorResources.white
                                                    .withOpacity(0.4),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "(65)",
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_BOLD,
                                    fontSize: 16,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.grey4
                                        : ColorResources.white.withOpacity(0.4),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Divider(
                              thickness: 0.5,
                              color: ColorResources.grey4,
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: 140,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: themeController.isLightTheme.value
                                    ? ColorResources.white
                                    : ColorResources.black1,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color:
                                        ColorResources.black.withOpacity(0.018),
                                    spreadRadius: 0,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Detail Product",
                                    style: TextStyle(
                                      fontFamily: TextFontFamily.SEN_BOLD,
                                      fontSize: 18,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.black2
                                          : ColorResources.white,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "(1) - MackBook Pro",
                                    style: TextStyle(
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      fontSize: 14,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.grey12
                                          : ColorResources.white
                                              .withOpacity(0.4),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "(2) - SSD 256 GB",
                                    style: TextStyle(
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      fontSize: 14,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.grey12
                                          : ColorResources.white
                                              .withOpacity(0.6),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "(3) Ram 8 GB DDR4",
                                    style: TextStyle(
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      fontSize: 14,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.grey12
                                          : ColorResources.white
                                              .withOpacity(0.6),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "(4) Non Touch Bar",
                                    style: TextStyle(
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      fontSize: 14,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.grey12
                                          : ColorResources.white
                                              .withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              height: 165,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: themeController.isLightTheme.value
                                    ? ColorResources.white
                                    : ColorResources.black1,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(8),
                                  bottomLeft: Radius.circular(8),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 4,
                                    color:
                                        ColorResources.black.withOpacity(0.018),
                                    spreadRadius: 0,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Description",
                                    style: TextStyle(
                                      fontFamily: TextFontFamily.SEN_BOLD,
                                      fontSize: 18,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.black2
                                          : ColorResources.white,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Lorem Ipsum is simply dummy text of the printing"
                                    "and typesetting industry. Lorem Ipsum has been the"
                                    "indu stry's standard dummy text ever since the"
                                    "1500s, whe an unknown printer took a galley of type"
                                    "and sc rambled it to make a type printer took a...",
                                    style: TextStyle(
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      fontSize: 13,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.grey5
                                          : ColorResources.white
                                              .withOpacity(0.6),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  InkWell(
                                    onTap: () {
                                      Get.bottomSheet(
                                        Container(
                                          //height: 250,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 15),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Description",
                                                    style: TextStyle(
                                                      fontFamily: TextFontFamily
                                                          .SEN_BOLD,
                                                      fontSize: 18,
                                                      color: themeController
                                                              .isLightTheme
                                                              .value
                                                          ? ColorResources
                                                              .black2
                                                          : ColorResources
                                                              .white,
                                                    ),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Lorem Ipsum is simply dummy text of the printing"
                                                    "and typesetting industry. Lorem Ipsum has been the"
                                                    "indu stry's standard dummy text ever since the"
                                                    "1500s, whe an unknown printer took a galley of type"
                                                    "and sc rambled it to make a type printer took a...",
                                                    style: TextStyle(
                                                      fontFamily: TextFontFamily
                                                          .SEN_REGULAR,
                                                      fontSize: 13,
                                                      color: themeController
                                                              .isLightTheme
                                                              .value
                                                          ? ColorResources.grey5
                                                          : ColorResources.white
                                                              .withOpacity(0.6),
                                                    ),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Lorem Ipsum is simply dummy text of the printing"
                                                    "and typesetting industry.",
                                                    style: TextStyle(
                                                      fontFamily: TextFontFamily
                                                          .SEN_REGULAR,
                                                      fontSize: 13,
                                                      color: themeController
                                                              .isLightTheme
                                                              .value
                                                          ? ColorResources.grey5
                                                          : ColorResources.white
                                                              .withOpacity(0.6),
                                                    ),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Lorem Ipsum is simply dummy text of the printing"
                                                    "and typesetting industry. Lorem Ipsum has been the"
                                                    "indu stry's standard dummy text ever since the"
                                                    "1500s, whe an unknown.",
                                                    style: TextStyle(
                                                      fontFamily: TextFontFamily
                                                          .SEN_REGULAR,
                                                      fontSize: 13,
                                                      color: themeController
                                                              .isLightTheme
                                                              .value
                                                          ? ColorResources.grey5
                                                          : ColorResources.white
                                                              .withOpacity(0.6),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        backgroundColor:
                                            themeController.isLightTheme.value
                                                ? ColorResources.white
                                                : ColorResources.black1,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(25)),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "View More",
                                          style: TextStyle(
                                            fontFamily: TextFontFamily.SEN_BOLD,
                                            fontSize: 15,
                                            color: ColorResources.blue1,
                                          ),
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color: ColorResources.blue1,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Top Rated Products",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: TextFontFamily.SEN_BOLD,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.black2
                                        : ColorResources.white,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    //Get.off(RecomendedScreen());
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        "View all  ",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily:
                                              TextFontFamily.SEN_REGULAR,
                                          color: ColorResources.blue1,
                                        ),
                                      ),
                                      SvgPicture.asset(Images.viewallarrow),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            //SizedBox(height: 10),
                            GridView.builder(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              itemCount: topRatedList.length,
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
                                          color:
                                              themeController.isLightTheme.value
                                                  ? ColorResources.blue1
                                                      .withOpacity(0.05)
                                                  : ColorResources.black1,
                                          spreadRadius: 0,
                                          offset: Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                                    topRatedList[index]
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
                                                  topRatedList[index]["image"],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            topRatedList[index]["text"],
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily:
                                                  TextFontFamily.SEN_BOLD,
                                              color: themeController
                                                      .isLightTheme.value
                                                  ? ColorResources.black2
                                                  : ColorResources.white,
                                            ),
                                          ),
                                          Text(
                                            topRatedList[index]["price"],
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontFamily:
                                                  TextFontFamily.SEN_EXTRA_BOLD,
                                              color: ColorResources.blue1,
                                            ),
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
                                                    color:
                                                        ColorResources.yellow,
                                                  ),
                                                  empty: Icon(
                                                    Icons.star,
                                                    color:
                                                        ColorResources.white2,
                                                  ),
                                                  half: Icon(Icons.star),
                                                ),
                                                onRatingUpdate: (rating) {},
                                              ),
                                              Text(
                                                "932 Sale",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontFamily: TextFontFamily
                                                      .SEN_REGULAR,
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
                            SizedBox(height: 30),
                            Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.grey10
                                        : ColorResources.white.withOpacity(0.8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: SvgPicture.asset(
                                      Images.cartblank,
                                      color: ColorResources.black,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    width: Get.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: ColorResources.blue1,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Pay",
                                        style: TextStyle(
                                          fontFamily: TextFontFamily.SEN_BOLD,
                                          fontSize: 20,
                                          color: ColorResources.white,
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
                    ],
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
