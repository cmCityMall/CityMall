import 'package:carousel_slider/carousel_slider.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/controller/homegridfavouritecontroller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/homescreen/cameradashboardscreen/cameradeshboard.dart';
import 'package:citymall/homescreen/fashionmandashboardscreen/fashionmandashboardscreen.dart';
import 'package:citymall/homescreen/flashdashboard/flashdashboard.dart';
import 'package:citymall/homescreen/menuviewallscreen.dart';
import 'package:citymall/homescreen/recomendedscreen.dart';
import 'package:citymall/homescreen/weekpromotionscreen.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/productdetailsscreen/productdetailscreen.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ThemeController themeController = Get.put(ThemeController());

  final HomeFavouriteController controller = Get.put(HomeFavouriteController());

  bool isOpened = false;

  final GlobalKey<SideMenuState> _sideMenuKey = GlobalKey<SideMenuState>();

  final GlobalKey<SideMenuState> _endSideMenuKey = GlobalKey<SideMenuState>();

  toggleMenu([bool end = false]) {
    if (end) {
      final _state = _endSideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    } else {
      final _state = _sideMenuKey.currentState!;
      if (_state.isOpened) {
        _state.closeSideMenu();
      } else {
        _state.openSideMenu();
      }
    }
  }

  List<Map> sliderlist = [
    {
      "image": Images.slider1,
    },
    {
      "image": Images.slider2,
    },
    {
      "image": Images.slider3,
    },
  ];

  /* List<Map> menuList = [
    {
      "image": Images.camera,
      "text": "Camera",
    },
    {
      "image": Images.food,
      "text": "Food ",
    },
    {
      "image": Images.handphone,
      "text": "Hand\nphone",
    },
    {
      "image": Images.gamming,
      "text": "Gamming",
    },
    {
      "image": Images.food,
      "text": "Food ",
    },
  ]; */

  List<Map> weekPromotionList = [
    {
      "image": Images.phoneimage,
      "text": "Discount 10%",
    },
    {
      "image": Images.clothesimage,
      "text": "Start From 50\$",
    },
    {
      "image": Images.cosmaticsimage,
      "text": "Start From 50\$",
    },
  ];

  List<Map> categoryList = [
    {
      "image": Images.fashionman,
      "text": "Fashion Man",
    },
    {
      "image": Images.smartphone,
      "text": "Smart Phone",
    },
    {
      "image": Images.fashiongirl,
      "text": "Fashion Girl",
    },
    {
      "image": Images.smartphone,
      "text": "Smart Phone",
    },
  ];

  List<Map> homeGridList = [
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

  Text text(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: TextFontFamily.SEN_REGULAR,
        fontSize: 24,
        color: ColorResources.white,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Container container(String text) {
    return Container(
      height: 31,
      width: 31,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: ColorResources.white,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontFamily: TextFontFamily.SEN_BOLD,
            fontSize: 14,
            color: ColorResources.black8,
          ),
        ),
      ),
    );
  }

  Text text1() {
    return Text(
      ":",
      style: TextStyle(
        fontFamily: TextFontFamily.SEN_BOLD,
        fontSize: 14,
        color: ColorResources.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DBDataController dbDataController = Get.find();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeController.isLightTheme.value
          ? ColorResources.white1
          : ColorResources.black1,
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              CarouselSlider.builder(
                itemCount: sliderlist.length,
                itemBuilder: (BuildContext context, index, int pageViewIndex) =>
                    Stack(
                  children: [
                    Container(
                      height: 200,
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: AssetImage(
                            sliderlist[index]["image"],
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: Get.width >= 411 ? 200 : 150,
                      child: Row(
                        children: List.generate(
                          sliderlist.length,
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
                  height: 200,
                  autoPlay: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  initialPage: 3,
                  viewportFraction: 0.98,
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Menu",
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
                      Get.to(MenuViewAllScreen());
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
              SizedBox(height: 13),
              Container(
                height: 100,
                width: Get.width,
                decoration: BoxDecoration(
                  color: themeController.isLightTheme.value
                      ? ColorResources.white1
                      : ColorResources.black1,
                ),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dbDataController.mainCategories.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final mainCategory =
                          dbDataController.mainCategories[index];
                      return InkWell(
                        onTap: () {
                          dbDataController.setSelectedMain(mainCategory.id);
                          dbDataController.getSubCategories(mainCategory.id);
                          Get.off(CameraDeshBoard());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            height: 100,
                            width: 80,
                            decoration: BoxDecoration(
                              color: themeController.isLightTheme.value
                                  ? ColorResources.white1
                                  : ColorResources.black1,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: ColorResources.blue2),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: themeController.isLightTheme.value
                                      ? ColorResources.white4
                                      : ColorResources.white.withOpacity(0.05),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(mainCategory.image),
                                    SizedBox(height: 8),
                                    Text(
                                      mainCategory.name,
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontFamily: TextFontFamily.SEN_REGULAR,
                                        color:
                                            themeController.isLightTheme.value
                                                ? ColorResources.black2
                                                : ColorResources.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(height: 15),
              Text(
                "Week Promotion",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: TextFontFamily.SEN_BOLD,
                  color: themeController.isLightTheme.value
                      ? ColorResources.black2
                      : ColorResources.white,
                ),
              ),
              SizedBox(height: 13),
              Container(
                height: 170,
                width: Get.width,
                decoration: BoxDecoration(
                  color: themeController.isLightTheme.value
                      ? ColorResources.white1
                      : ColorResources.black1,
                ),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: weekPromotionList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(WeekPromotionScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            height: 170,
                            width: 145,
                            decoration: BoxDecoration(
                              color: themeController.isLightTheme.value
                                  ? ColorResources.white5
                                  : ColorResources.black7,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 105,
                                  width: 105,
                                  decoration: BoxDecoration(
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.white5
                                        : ColorResources.black7,
                                  ),
                                  child: Image.asset(
                                    weekPromotionList[index]["image"],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  weekPromotionList[index]["text"],
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: TextFontFamily.SEN_BOLD,
                                    color: ColorResources.blue1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Get.off(FlashSaleScreen());
                },
                child: Container(
                  height: 130,
                  width: Get.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Images.promotionimage),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 14,
                        top: 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            text("Super Flash Sale"),
                            text("50% Off"),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 13,
                        bottom: 13,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "End Sale In:",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: TextFontFamily.SEN_REGULAR,
                                color: ColorResources.white,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                container("08"),
                                SizedBox(width: 2),
                                text1(),
                                SizedBox(width: 2),
                                container("34"),
                                SizedBox(width: 2),
                                text1(),
                                SizedBox(width: 2),
                                container("52"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 21),
              Text(
                "Category",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: TextFontFamily.SEN_BOLD,
                  color: themeController.isLightTheme.value
                      ? ColorResources.black2
                      : ColorResources.white,
                ),
              ),
              SizedBox(height: 14),
              Container(
                height: 168,
                width: Get.width,
                decoration: BoxDecoration(
                  color: themeController.isLightTheme.value
                      ? ColorResources.white1
                      : ColorResources.black1,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: InkWell(
                            onTap: () {
                              Get.off(FashionManDashboard());
                            },
                            child: Container(
                              height: 168,
                              width: 122,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image:
                                      AssetImage(categoryList[index]["image"]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  Images.categoryhomecanvas,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          left: 21,
                          child: Text(
                            categoryList[index]["text"],
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: TextFontFamily.SEN_REGULAR,
                              fontWeight: FontWeight.w500,
                              color: ColorResources.white,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recomended",
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
                      Get.off(RecomendedScreen());
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
                itemCount: homeGridList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
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
                      Get.off(ProductDetailScreen());
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
                                      homeGridList[index]["image"],
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
                                    homeGridList[index]["image"],
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              homeGridList[index]["text"],
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
                                  homeGridList[index]["price"],
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
                                      size: 10,
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
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
