import 'package:carousel_slider/carousel_slider.dart';
import 'package:citymall/admin/week_promotion/view/week_promotion_view.dart';
import 'package:citymall/categorybrandscreen/brand_view_all.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/constant/constant.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/controller/flash_sale_controller.dart';
import 'package:citymall/controller/homegridfavouritecontroller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/controller/week_promotion_controller.dart';
import 'package:citymall/homescreen/cameradashboardscreen/cameradeshboard.dart';
import 'package:citymall/homescreen/fashionmandashboardscreen/fashionmandashboardscreen.dart';
import 'package:citymall/homescreen/flashdashboard/flashdashboard.dart';
import 'package:citymall/homescreen/menuviewallscreen.dart';
import 'package:citymall/homescreen/recomendedscreen.dart';
import 'package:citymall/homescreen/weekpromotionscreen.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/model/favourite_item.dart';
import 'package:citymall/productdetailsscreen/productdetailscreen.dart';
import 'package:citymall/shop/shop_detail_view.dart';
import 'package:citymall/shop/shop_view_all.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:citymall/week_promotion/week_promotion_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../categorybrandscreen/brand_view_all_binding.dart';
import '../categorybrandscreen/subcategory1.dart';
import '../productdetailsscreen/product_detail_binding.dart';
import '../shop/shop_view_all_binding.dart';
import '../utils/widgets/loading_widget.dart';

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
    final FlashSaleController flashController = Get.find();
    final WeekPromotionControllerUser weekPromotionController = Get.find();
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
              //Advertisement
              Obx(() {
                if (dbDataController.advertisementLoading.value) {
                  return const LoadingWidget();
                }
                if (dbDataController.advertisements.isEmpty) {
                  return const SizedBox();
                }
                return CarouselSlider.builder(
                  itemCount: dbDataController.advertisements.length,
                  itemBuilder:
                      (BuildContext context, index, int pageViewIndex) => Stack(
                    children: [
                      Container(
                        height: 200,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(
                              dbDataController.advertisements[index].image,
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
                            dbDataController.advertisements.length,
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
                );
              }),
              SizedBox(height: 15),
              //Menu Main Catgory
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
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
                      Get.to(() => MenuViewAllScreen());
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
              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                  ),
                  itemCount: dbDataController.menuMainCategories.length > 12
                      ? 12
                      : dbDataController.menuMainCategories.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final mainCategory =
                        dbDataController.menuMainCategories[index];
                    return InkWell(
                      onTap: () {
                        ///Make Sure To Do Require Function*/
                        dbDataController.setSelectedMain(
                          mainCategory.id,
                          mainCategory.name,
                        );
                        dbDataController
                            .getInitialSubCategories(mainCategory.id);
                        dbDataController.getSliderProducts(mainCategory.id);
                        dbDataController
                            .getInitialDiscountProducts(mainCategory.id);
                        dbDataController
                            .getInitialPopularProducts(mainCategory.id);
                        dbDataController.getInitialNewProducts(mainCategory.id);
                        Get.to(() => CameraDeshBoard());
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: Image.network(mainCategory.image)),
                              const SizedBox(height: 8),
                              Text(
                                mainCategory.name,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: TextFontFamily.SEN_REGULAR,
                                  color: themeController.isLightTheme.value
                                      ? ColorResources.black2
                                      : ColorResources.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),

              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Week Promotions",
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
                      Get.to(() => WeekPromotionViewAll());
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
              Obx(() {
                if (dbDataController.promotionsLoading.value) {
                  return const LoadingWidget();
                }
                if (dbDataController.weekPromotions.isEmpty) {
                  return const SizedBox();
                }
                return Container(
                  height: 170,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: themeController.isLightTheme.value
                        ? ColorResources.white1
                        : ColorResources.black1,
                  ),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dbDataController.weekPromotions.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final weekPromo =
                            dbDataController.weekPromotions[index];
                        return InkWell(
                          onTap: () {
                            weekPromotionController
                                .setSelectedWeekPromotion(weekPromo);
                            weekPromotionController
                                .getInitialProducts(weekPromo.id);
                            Get.to(() => WeekPromotionScreen());
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
                                    child: Image.network(
                                      dbDataController
                                          .weekPromotions[index].image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    dbDataController.weekPromotions[index].desc,
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
                );
              }),
              const SizedBox(height: 20),
              Obx(() {
                if (dbDataController.timeSaleLoading.value) {
                  return const LoadingWidget();
                }
                if (dbDataController.timeSales.isEmpty) {
                  return const SizedBox();
                }
                final timeSale = dbDataController.timeSales.first;
                final date = timeSale.endDate;
                final hour = date.hour;
                final minute = date.minute;
                final second = date.second;
                return InkWell(
                  onTap: () {
                    flashController.setSelectedFlash(timeSale);
                    flashController.getInitialProducts(timeSale.id);
                    Get.to(() => FlashSaleScreen());
                  },
                  child: Container(
                    height: 130,
                    width: Get.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(timeSale.image),
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
                              text(timeSale.name!),
                              text(timeSale.desc!),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 13,
                          bottom: 13,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "End Sale In:",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: TextFontFamily.SEN_REGULAR,
                                  color: ColorResources.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  container("$hour"),
                                  const SizedBox(width: 2),
                                  text1(),
                                  const SizedBox(width: 2),
                                  container("$minute"),
                                  const SizedBox(width: 2),
                                  text1(),
                                  const SizedBox(width: 2),
                                  container("$second"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              /* const SizedBox(height: 21),
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
              const SizedBox(height: 14),
              Obx(() {
                if (dbDataController.mainCategoryLoading.value) {
                  return const LoadingWidget();
                }
                if (dbDataController.mainCategories.isEmpty) {
                  return const SizedBox();
                }
                final list = dbDataController.mainCategories;
                return Container(
                  height: 168,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: themeController.isLightTheme.value
                        ? ColorResources.white1
                        : ColorResources.black1,
                  ),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
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
                                    image: NetworkImage(list[index].image),
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
                              list[index].name,
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
                );
              }), */
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Shops",
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
                      Get.to(() => ShopViewAll(),
                          binding: ShopViewAllBinding());
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
              SizedBox(height: 13),
              Obx(() {
                if (dbDataController.shopLoading.value) {
                  return const LoadingWidget();
                }
                if (dbDataController.shopRxList.isEmpty) {
                  return const SizedBox();
                }
                return Container(
                  height: 170,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: themeController.isLightTheme.value
                        ? ColorResources.white1
                        : ColorResources.black1,
                  ),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dbDataController.shopRxList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final weekPromo = dbDataController.shopRxList[index];
                        return InkWell(
                          onTap: () {
                            dbDataController.setSelectedShop(weekPromo);
                            dbDataController
                                .getInitialShopProducts(weekPromo.id);
                            Get.to(() => const ShopDetailView());
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
                                    child: Image.network(
                                      dbDataController.shopRxList[index].image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    dbDataController.shopRxList[index].name,
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
                );
              }),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular product",
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
                      Get.to(() => RecomendedScreen());
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
                itemCount: 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.55,
                ),
                itemBuilder: (context, index) {
                  final product = dbDataController.homePopularProducts[index];
                  return InkWell(
                    onTap: () {
                      dbDataController.setSelectedProduct(product);
                      Get.to(
                        () => ProductDetailScreen(),
                        binding: ProductDetailBinding(),
                      );
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
                                    child: Image.network(
                                      product.images.first,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 160,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: ColorResources.white6,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Image.network(
                                    product.images.first,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              product.name,
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
                                  "${product.price}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontFamily: TextFontFamily.SEN_EXTRA_BOLD,
                                    color: ColorResources.blue1,
                                  ),
                                ),
                                //Favourite Icon
                                ValueListenableBuilder(
                                  valueListenable:
                                      Hive.box<FavouriteItem>(favouriteBox)
                                          .listenable(),
                                  builder: (context, Box<FavouriteItem> box,
                                      widget) {
                                    final currentObj = box.get(product.id);

                                    if (!(currentObj == null)) {
                                      return IconButton(
                                          onPressed: () {
                                            box.delete(currentObj.id);
                                          },
                                          icon: const Icon(
                                            FontAwesomeIcons.solidHeart,
                                            color: Colors.red,
                                            size: 25,
                                          ));
                                    }
                                    return IconButton(
                                        onPressed: () {
                                          box.put(
                                            product.id,
                                            FavouriteItem(
                                              id: product.id,
                                              name: product.name,
                                              image: product.images.first,
                                              price: product.price,
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.favorite_outline,
                                          color: Colors.red,
                                          size: 25,
                                        ));
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RatingBar(
                                  itemSize: 16,
                                  maxRating: 5,
                                  initialRating: product.reviewCount + 0.0,
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
                                  "${product.reviewCount + 0.0}",
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
              const SizedBox(height: 15),

              Obx(() {
                if (dbDataController.timeSaleLoading.value) {
                  return const LoadingWidget();
                }
                if (dbDataController.timeSales.isEmpty) {
                  return const SizedBox();
                }
                final timeSale = dbDataController.timeSales[1];
                final date = timeSale.endDate;
                final hour = date.hour;
                final minute = date.minute;
                final second = date.second;
                return InkWell(
                  onTap: () {
                    flashController.setSelectedFlash(timeSale);
                    flashController.getInitialProducts(timeSale.id);
                    Get.to(() => FlashSaleScreen());
                  },
                  child: Container(
                    height: 130,
                    width: Get.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(timeSale.image),
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
                              text(timeSale.name!),
                              text(timeSale.desc!),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 13,
                          bottom: 13,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "End Sale In:",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: TextFontFamily.SEN_REGULAR,
                                  color: ColorResources.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  container("$hour"),
                                  const SizedBox(width: 2),
                                  text1(),
                                  const SizedBox(width: 2),
                                  container("$minute"),
                                  const SizedBox(width: 2),
                                  text1(),
                                  const SizedBox(width: 2),
                                  container("$second"),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              SizedBox(height: 13),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Brands",
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
                      Get.to(
                        () => BrandViewAll(),
                        binding: BrandViewAllBinding(),
                      );
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
              const SizedBox(height: 20),
              Obx(() {
                if (dbDataController.brandLoading.value) {
                  return const LoadingWidget();
                }
                if (dbDataController.brandRxList.isEmpty) {
                  return const SizedBox();
                }
                return Container(
                  height: 170,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: themeController.isLightTheme.value
                        ? ColorResources.white1
                        : ColorResources.black1,
                  ),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: dbDataController.brandRxList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final weekPromo = dbDataController.brandRxList[index];
                        return InkWell(
                          onTap: () {
                            dbDataController.setSelectedBrand(weekPromo);
                            dbDataController
                                .getInitialBrandProducts(weekPromo.id);
                            Get.to(() => const BrandsDetailView());
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
                                    child: Image.network(
                                      dbDataController.brandRxList[index].image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    dbDataController.brandRxList[index].name,
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
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
