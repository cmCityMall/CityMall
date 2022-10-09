import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/clickcontroller.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/model/cart_product.dart';
import 'package:citymall/productdetailsscreen/product_detail_controller.dart';
import 'package:citymall/productdetailsscreen/viewallreviewscreen.dart';
import 'package:citymall/rout_screens/rout_1.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../controller/cart_controller.dart';
import '../widgets/other/cache_image.dart';
import '../widgets/other/cart_icon_widget.dart';
import '../widgets/other/related_address_widget.dart';

// ignore: must_be_immutable
class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());
  final ColorClickController ontapColorController =
      Get.put(ColorClickController());
  final SizeClickController ontapSizeController =
      Get.put(SizeClickController());
  final ArrowClickController arrowClickController =
      Get.put(ArrowClickController());
  final AddressClickController1 addressClickController1 =
      Get.put(AddressClickController1());
  /*  List<Map> topRatedProductList = [
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

  List<Map> bottomAddressList = [
    {
      "icon": Images.homefill,
      "text1": "Home Address",
      "text2": "+91 12345 67890",
    },
    {
      "icon": Images.office,
      "text1": "Office Address",
      "text2": "+91 98765 43210",
    },
  ]; */

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find();
    final DBDataController dataController = Get.find();
    final ProductDetailController detailController = Get.find();
    final currentProduct = dataController.selectedProduct.value;
    return Scaffold(
      backgroundColor: themeController.isLightTheme.value
          ? ColorResources.white6
          : ColorResources.black4,
      appBar: AppBar(
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
            color: themeController.isLightTheme.value
                ? ColorResources.black2
                : ColorResources.white,
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
              child: CartIconWidget(
                themeController: themeController,
                color: ColorResources.white,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 240,
                    width: Get.width,
                    color: themeController.isLightTheme.value
                        ? ColorResources.white6
                        : ColorResources.black4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Container(
                            height: 240,
                            width: 210,
                            color: themeController.isLightTheme.value
                                ? ColorResources.white6
                                : ColorResources.black4,
                            child: Obx(() {
                              return CustomCacheNetworkImage(
                                //Proudct first image
                                imageUrl:
                                    detailController.selectedImage.isNotEmpty
                                        ? detailController.selectedImage.value
                                        : currentProduct!.images.first,
                                boxFit: BoxFit.cover,
                              );
                            }),
                          ),
                        ),
                        //SizedBox(width: Get.width / 10.27),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: EdgeInsets.only(top: 50, right: 20),
                              child: Obx(
                                () => Container(
                                  height:
                                      arrowClickController.click.value == false
                                          ? 100
                                          : 200,
                                  width: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.white
                                        : ColorResources.black1,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Obx(
                                          () => InkWell(
                                            onTap: () {
                                              arrowClickController.click.value =
                                                  !arrowClickController
                                                      .click.value;
                                            },
                                            child: SvgPicture.asset(
                                              arrowClickController
                                                          .click.value ==
                                                      false
                                                  ? Images.arrowup
                                                  : Images.arrowdown,
                                              color: themeController
                                                      .isLightTheme.value
                                                  ? ColorResources.grey8
                                                  : ColorResources.white,
                                            ),
                                          ),
                                        ),
                                        Divider(
                                          thickness: 0.6,
                                          color: ColorResources.grey6,
                                        ),
                                        //Images for Product to Choose
                                        ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: arrowClickController
                                                      .click.value ==
                                                  false
                                              ? 1
                                              : currentProduct!.images.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5),
                                              child: Container(
                                                height: 42,
                                                width: 42,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  color: ColorResources.grey6,
                                                ),
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    child:
                                                        CustomCacheNetworkImage(
                                                      imageUrl: currentProduct!
                                                          .images[index],
                                                      boxFit: BoxFit.contain,
                                                    )),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    // height: Get.height,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: themeController.isLightTheme.value
                          ? ColorResources.white
                          : ColorResources.black1,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(100),
                      ),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 34,
                          color: ColorResources.black.withOpacity(0.04),
                          spreadRadius: 0,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Product Name
                              Expanded(
                                child: Text(
                                  currentProduct!.name,
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_BOLD,
                                    fontSize: 24,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.black2
                                        : ColorResources.white,
                                  ),
                                ),
                              ),
                              //Rating Star
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, right: 5),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: ColorResources.yellow,
                                    ),
                                    SizedBox(width: 9),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Product Price
                              Obx(() {
                                return Text(
                                  detailController.selectedPrice.value == 0
                                      ? "${currentProduct.price}"
                                      : "${detailController.selectedPrice.value}",
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_EXTRA_BOLD,
                                    fontSize: 25,
                                    color: ColorResources.blue1,
                                  ),
                                );
                              }),
                              //TOtal Sale
                              Text(
                                "(932 Sale)",
                                style: TextStyle(
                                  fontFamily: TextFontFamily.SEN_REGULAR,
                                  fontSize: 14,
                                  color: themeController.isLightTheme.value
                                      ? ColorResources.grey5
                                      : ColorResources.white.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(
                            thickness: 0.5,
                            color: themeController.isLightTheme.value
                                ? ColorResources.grey8
                                : ColorResources.white.withOpacity(0.2),
                          ),
                          SizedBox(height: 10),
                          !(currentProduct.sizeColorImagePrice == null) &&
                                  currentProduct.sizeColorImagePrice!.isNotEmpty
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //Color
                                    Expanded(
                                      child: Column(
                                        children: [
                                          //Label
                                          const Text(
                                            "COLOR",
                                            style: TextStyle(
                                              fontFamily:
                                                  TextFontFamily.SEN_REGULAR,
                                              fontSize: 13,
                                              color: ColorResources.grey11,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          //Child
                                          Wrap(
                                            children: currentProduct
                                                .sizeColorImagePrice!.entries
                                                .map((e) {
                                              final color = e.value["color"];
                                              return Obx(
                                                () => InkWell(
                                                  onTap: () {
                                                    detailController
                                                            .setSelectedColor =
                                                        color;
                                                    detailController
                                                            .setSelectedPrice =
                                                        e.value["price"];
                                                    detailController
                                                            .setSelectedImage =
                                                        e.value["image"];
                                                  },
                                                  child: Container(
                                                    height: 35,
                                                    width: 35,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: themeController
                                                              .isLightTheme
                                                              .value
                                                          ? detailController
                                                                      .selectedColor ==
                                                                  color
                                                              ? ColorResources
                                                                  .white9
                                                              : ColorResources
                                                                  .white
                                                          : detailController
                                                                      .selectedColor ==
                                                                  color
                                                              ? ColorResources
                                                                  .white9
                                                              : ColorResources
                                                                  .black1,
                                                    ),
                                                    child: Center(
                                                      child: CircleAvatar(
                                                        radius: detailController
                                                                    .selectedColor ==
                                                                color
                                                            ? 9
                                                            : 6,
                                                        backgroundColor:
                                                            HexColor(color),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //Size
                                    Expanded(
                                      child: Column(
                                        children: [
                                          //Label
                                          const Text(
                                            "SIZE",
                                            style: TextStyle(
                                              fontFamily:
                                                  TextFontFamily.SEN_REGULAR,
                                              fontSize: 13,
                                              color: ColorResources.grey11,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          //Child
                                          Wrap(
                                            children: currentProduct
                                                .sizeColorImagePrice!.entries
                                                .map((e) {
                                              final size =
                                                  e.value["size"] as String;
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Obx(
                                                  () => InkWell(
                                                    onTap: () {
                                                      detailController
                                                              .setSelectedSize =
                                                          size;
                                                      detailController
                                                              .setSelectedPrice =
                                                          e.value["price"];
                                                      /*  detailController
                                                        .setSelectedImage =
                                                    e.value["image"]; */
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        color: themeController
                                                                .isLightTheme
                                                                .value
                                                            ? detailController
                                                                        .selectedSize
                                                                        .value ==
                                                                    size
                                                                ? ColorResources
                                                                    .blue1
                                                                : ColorResources
                                                                    .white
                                                            : detailController
                                                                        .selectedSize
                                                                        .value ==
                                                                    size
                                                                ? ColorResources
                                                                    .blue1
                                                                : ColorResources
                                                                    .black1,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        border: Border.all(
                                                            width: 1.5,
                                                            color: detailController
                                                                        .selectedSize
                                                                        .value ==
                                                                    size
                                                                ? ColorResources
                                                                    .blue1
                                                                : ColorResources
                                                                    .white9),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          size,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                TextFontFamily
                                                                    .SEN_REGULAR,
                                                            fontSize: 20,
                                                            color: detailController
                                                                        .selectedSize
                                                                        .value ==
                                                                    size
                                                                ? ColorResources
                                                                    .white
                                                                : ColorResources
                                                                    .blue1,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                          SizedBox(height: 20),
                          Container(
                            height: 175,
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

                                ///Description.............///
                                Text(
                                  currentProduct.description,
                                  maxLines: 5,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    height: 1.3,
                                    fontFamily: TextFontFamily.SEN_REGULAR,
                                    fontSize: 13,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.grey5
                                        : ColorResources.white.withOpacity(0.6),
                                  ),
                                ),
                                SizedBox(height: 10),
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
                                                    fontFamily:
                                                        TextFontFamily.SEN_BOLD,
                                                    fontSize: 18,
                                                    color: themeController
                                                            .isLightTheme.value
                                                        ? ColorResources.black2
                                                        : ColorResources.white,
                                                  ),
                                                ),
                                                SizedBox(height: 15),
                                                Text(
                                                  currentProduct.description,
                                                  style: TextStyle(
                                                    height: 1.3,
                                                    fontFamily: TextFontFamily
                                                        .SEN_REGULAR,
                                                    fontSize: 13,
                                                    color: themeController
                                                            .isLightTheme.value
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
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            topRight: Radius.circular(25)),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
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
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              InkWell(
                                onTap: () {
                                  if (detailController.reviewList.isNotEmpty) {
                                    Get.to(() => ViewAllReviewScreen());
                                  }
                                },
                                child: Row(
                                  children: [
                                    const Text(
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
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              RatingBar(
                                itemSize: 20,
                                maxRating: 5,
                                initialRating: currentProduct.reviewCount + 0.0,
                                itemCount: 5,
                                direction: Axis.horizontal,
                                ratingWidget: RatingWidget(
                                  full: const Icon(
                                    Icons.star,
                                    color: ColorResources.yellow,
                                  ),
                                  empty: const Icon(
                                    Icons.star,
                                    color: ColorResources.white2,
                                  ),
                                  half: const Icon(Icons.star),
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                              SizedBox(width: 8),
                              Text(
                                "${currentProduct.reviewCount + 0.0}",
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
                          detailController.reviewList.isNotEmpty
                              ? Container(
                                  height: 280,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.white
                                        : ColorResources.black1,
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 4,
                                        color: ColorResources.black
                                            .withOpacity(0.020),
                                        spreadRadius: 0,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: 2,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final review =
                                          detailController.reviewList[index];
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              leading: CachedNetworkImage(
                                                imageBuilder:
                                                    (conext, imageUrl) {
                                                  return CircleAvatar(
                                                    radius: 30,
                                                    backgroundImage: imageUrl,
                                                  );
                                                },
                                                progressIndicatorBuilder:
                                                    (context, url, status) {
                                                  return Shimmer.fromColors(
                                                    baseColor: Colors.grey,
                                                    highlightColor:
                                                        Colors.white,
                                                    child: Container(
                                                      color: Colors.white,
                                                    ),
                                                  );
                                                },
                                                errorWidget:
                                                    (context, url, whatever) {
                                                  return const Text(
                                                      "Image not available");
                                                },
                                                imageUrl: review.user.image,
                                                fit: BoxFit.contain,
                                              ),
                                              title: Text(
                                                review.user.userName,
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily:
                                                      TextFontFamily.SEN_BOLD,
                                                  color: themeController
                                                          .isLightTheme.value
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
                                              trailing: Text(
                                                DateFormat.yMMMMd()
                                                    .format(review.dateTime),
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontFamily: TextFontFamily
                                                      .SEN_REGULAR,
                                                  color: themeController
                                                          .isLightTheme.value
                                                      ? ColorResources.grey4
                                                      : ColorResources.white
                                                          .withOpacity(0.6),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              review.reviewMessage,
                                              style: TextStyle(
                                                height: 1.3,
                                                fontSize: 12,
                                                fontFamily:
                                                    TextFontFamily.SEN_REGULAR,
                                                color: themeController
                                                        .isLightTheme.value
                                                    ? ColorResources.grey4
                                                    : ColorResources.white
                                                        .withOpacity(0.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : const SizedBox(),
                          SizedBox(height: 20),
                          /* Row(
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
                                  // selectedIndex = 0;
                                  // Navigator.of(context, rootNavigator: true)
                                  //     .pushReplacement(MaterialPageRoute(
                                  //   builder: (context) => NavigationBarBottom(),
                                  // ));
                                  // Navigator.pushReplacement(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => MenuViewAllScreen(),
                                  //     ));
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "View all",
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
                          SizedBox(height: 15), */
                          /* GridView.builder(
                            itemCount: topRatedProductList.length,
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
                                    padding: const EdgeInsets.symmetric(
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
                                                  topRatedProductList[index]
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
                                              padding: const EdgeInsets.all(5),
                                              child: Image.asset(
                                                topRatedProductList[index]
                                                    ["image"],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          topRatedProductList[index]["text"],
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: TextFontFamily.SEN_BOLD,
                                            color: themeController
                                                    .isLightTheme.value
                                                ? ColorResources.black2
                                                : ColorResources.white,
                                          ),
                                        ),
                                        Text(
                                          topRatedProductList[index]["price"],
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
                          ), */
                          SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 90,
                width: Get.width,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: themeController.isLightTheme.value
                      ? ColorResources.white
                      : ColorResources.black1,
                ),
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  child: Row(
                    children: [
                      CartIconWidget(
                        themeController: themeController,
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            cartController.addIntoCart(CartProduct(
                              id: currentProduct.id,
                              name: currentProduct.name,
                              image: detailController.selectedImage.isNotEmpty
                                  ? detailController.selectedImage.value
                                  : currentProduct.images.first,
                              lastPrice:
                                  detailController.selectedPrice.value == 0
                                      ? currentProduct.price
                                      : detailController.selectedPrice.value,
                              color:
                                  detailController.selectedColor.value.isEmpty
                                      ? null
                                      : detailController.selectedColor.value,
                              size: detailController.selectedSize.value.isEmpty
                                  ? null
                                  : detailController.selectedSize.value,
                              count: 0,
                            ));
                            /* Get.bottomSheet(
                              Container(
                                child: RelatedAddressWidget(
                                    themeController: themeController,
                                    addressClickController1:
                                        addressClickController1),
                              ),
                              backgroundColor:
                                  themeController.isLightTheme.value
                                      ? ColorResources.white
                                      : ColorResources.black4,
                            ); */
                          },
                          child: Container(
                            height: 50,
                            width: Get.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: ColorResources.blue1,
                            ),
                            child: const Center(
                              child: Text(
                                "Add to cart",
                                style: TextStyle(
                                  fontFamily: TextFontFamily.SEN_BOLD,
                                  fontSize: 20,
                                  color: ColorResources.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
