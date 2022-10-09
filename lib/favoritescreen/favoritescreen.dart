import 'package:citymall/colors/colors.dart';
import 'package:citymall/constant/constant.dart';
import 'package:citymall/controller/favoritegridfavoritecontroller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/model/favourite_item.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: must_be_immutable
class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);

  final ThemeController themeController = Get.put(ThemeController());
  final FavouriteController controller = Get.put(FavouriteController());

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
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            color: themeController.isLightTheme.value
                ? ColorResources.white1
                : ColorResources.black1,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: ValueListenableBuilder(
              valueListenable:
                  Hive.box<FavouriteItem>(favouriteBox).listenable(),
              builder: (context, Box<FavouriteItem> box, widget) {
                if (box.isEmpty) {
                  return const Center(child: Text("No Favourite List"));
                }
                final list = box.values.map((e) => e).toList();
                return GridView.builder(
                  itemCount: list.length,
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
                                      child: Image.network(
                                        list[index].image,
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
                                    child: Image.network(
                                      list[index].image,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                list[index].name,
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
                                    list[index].price.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: TextFontFamily.SEN_EXTRA_BOLD,
                                      color: ColorResources.blue1,
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        box.delete(list[index].id);
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.solidHeart,
                                        color: Colors.red,
                                        size: 25,
                                      ))
                                ],
                              ),
                              /*  Row(
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
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      color: ColorResources.white3,
                                    ),
                                  ),
                                ],
                              ), */
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
