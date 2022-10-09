import 'package:carousel_slider/carousel_slider.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/flashsale_product_detail/controller/fspd_controller.dart';
import 'package:citymall/homescreen/flashdashboard/flashdashboard.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/rout_screens/rout_1.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:citymall/widgets/other/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';
import '../../model/cart_product.dart';
import '../../widgets/other/cart_icon_widget.dart';
import '../controller/wppd_controller.dart';

// ignore: must_be_immutable
class WPPDView extends StatelessWidget {
  WPPDView({Key? key}) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    final DBDataController dataController = Get.find();
    final WPPDController wppdController = Get.find();
    final CartController cartController = Get.find();
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
                  child: CartIconWidget(
                    themeController: themeController,
                    color: ColorResources.white,
                  ),
                ),
              ),
            ],
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: CarouselSlider.builder(
                itemCount: dataController.selectedProduct.value!.images.length,
                itemBuilder: (BuildContext context, index, int pageViewIndex) =>
                    Stack(
                  children: [
                    Container(
                      width: Get.width,
                      child: CustomCacheNetworkImage(
                        imageUrl:
                            dataController.selectedProduct.value!.images[index],
                        boxFit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: Get.width >= 411 ? 210 : 150,
                      child: Row(
                        children: List.generate(
                          dataController.selectedProduct.value!.images.length,
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
                                Expanded(
                                  child: Text(
                                    dataController.selectedProduct.value!.name,
                                    style: TextStyle(
                                      fontFamily: TextFontFamily.SEN_BOLD,
                                      fontSize: 24,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.black2
                                          : ColorResources.white,
                                    ),
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
                                        "${dataController.selectedProduct.value!.reviewCount}",
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
                                      "${wppdController.discountPrice.value}",
                                      style: TextStyle(
                                        fontFamily:
                                            TextFontFamily.SEN_EXTRA_BOLD,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 25,
                                        color: ColorResources.blue1,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "${dataController.selectedProduct.value!.price}",
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
                            /* SizedBox(height: 20),
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
                            ), */
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
                                    dataController
                                        .selectedProduct.value!.description,
                                    maxLines: 5,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      height: 1.3,
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      fontSize: 13,
                                      color: themeController.isLightTheme.value
                                          ? ColorResources.grey5
                                          : ColorResources.white
                                              .withOpacity(0.6),
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
                                                    dataController
                                                        .selectedProduct
                                                        .value!
                                                        .description,
                                                    style: TextStyle(
                                                      height: 1.3,
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
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              topRight: Radius.circular(25)),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                            ), */
                            SizedBox(height: 30),
                            Row(
                              children: [
                                CartIconWidget(
                                  themeController: themeController,
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      final p =
                                          dataController.selectedProduct.value!;
                                      cartController.addIntoCart(CartProduct(
                                        id: p.id,
                                        name: p.name,
                                        image: p.images.first,
                                        lastPrice:
                                            wppdController.discountPrice.value,
                                        color: null,
                                        size: null,
                                        count: 0,
                                      ));
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
                                          "Add into cart",
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
