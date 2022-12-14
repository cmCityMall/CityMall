import 'dart:developer';
import 'package:citymall/menuscreens/settingscreens/saveaddressscreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:citymall/cartscreen/cartscreen.dart';
import 'package:citymall/categorybrandscreen/categorybrandscreen.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/db_data_controller.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/favoritescreen/favoritescreen.dart';
import 'package:citymall/homescreen/home.dart';
import 'package:citymall/homescreen/menupage.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/notificationscreen/notificationscreen.dart';
import 'package:citymall/rout_screens/rout_2.dart';
import 'package:citymall/searchscreen/searchscreen.dart';
import 'package:citymall/searchscreen/subsearchscreen.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import '../constant/constant.dart';
import '../model/hive_personal_address.dart';
import '../searchscreen/search_controller.dart';

class NavigationBarBottom extends StatefulWidget {
  @override
  _NavigationBarBottomState createState() => _NavigationBarBottomState();
}

int selectedIndex = 0;
final ThemeController themeController = Get.put(ThemeController());

class _NavigationBarBottomState extends State<NavigationBarBottom> {
  Map<int, GlobalKey<NavigatorState>> navigatorKeys = {
    0: GlobalKey(),
    1: GlobalKey(),
    2: GlobalKey(),
    3: GlobalKey(),
    4: GlobalKey(),
  };

  test(testPage) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => testPage,
      ));

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

  @override
  Widget build(BuildContext context) {
    final DBDataController dataController = Get.find();
    final SearchController searchController = Get.find();
    return GestureDetector(
      onHorizontalDragStart: (detail) {
        final _state = _endSideMenuKey.currentState;
        if (detail.globalPosition.direction < 1) {
          if (!(_state == null) && isOpened && _state.isOpened) {
            isOpened = false;
            _state.closeSideMenu();
          }
        } else {
          if (!(_state == null) &&
              isOpened == false &&
              _state.isOpened == false) {
            isOpened = true;
            _state.openSideMenu();
          }
        }
      },
      child: Obx(
        () => SideMenu(
          closeIcon: Icon(
            Icons.close,
            color: themeController.isLightTheme.value
                ? ColorResources.black
                : ColorResources.white,
          ),
          key: _endSideMenuKey,
          inverse: false,
          // end side menu
          background: themeController.isLightTheme.value
              ? ColorResources.white12
              : ColorResources.black1,
          type: SideMenuType.shrikNRotate,
          menu: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: MenuPage(),
          ),
          onChange: (_isOpened) {
            setState(() => isOpened = _isOpened);
          },
          child: SideMenu(
            closeIcon: Icon(
              Icons.close,
              color: themeController.isLightTheme.value
                  ? ColorResources.black
                  : ColorResources.white,
            ),
            background: themeController.isLightTheme.value
                ? ColorResources.white12
                : ColorResources.black1,
            key: _sideMenuKey,
            menu: MenuPage(),
            type: SideMenuType.shrikNRotate,
            onChange: (_isOpened) {
              setState(() => isOpened = _isOpened);
            },
            child: IgnorePointer(
              ignoring: isOpened,
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: themeController.isLightTheme.value
                    ? ColorResources.white1
                    : ColorResources.black1,
                appBar: AppBar(
                  backgroundColor: themeController.isLightTheme.value
                      ? selectedIndex == 0
                          ? ColorResources.white1
                          : ColorResources.white
                      : ColorResources.black4,
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  elevation: 0,
                  leading:
                      // drawerButton(),
                      Padding(
                    padding: EdgeInsets.all(8.0),
                    child:
                        //Obx(() =>
                        InkWell(
                      onTap: () {
                        toggleMenu();
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
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset(
                            Images.drawericon,
                            color: themeController.isLightTheme.value
                                ? ColorResources.black2
                                : ColorResources.white,
                          ),
                        ),
                      ),
                    ),
                    //),
                  ),
                  title: selectedIndex == 0
                      ? Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child:
                              //Address String
                              ValueListenableBuilder(
                            valueListenable:
                                Hive.box<List<String>>(addressKeyValueBox)
                                    .listenable(),
                            builder: (context, Box<List<String>> box, __) {
                              return ValueListenableBuilder(
                                valueListenable:
                                    Hive.box<HivePersonalAddress>(addressBox)
                                        .listenable(),
                                builder: (context,
                                    Box<HivePersonalAddress> personBox, __) {
                                  log("${personBox.length},${personBox.values.toString()}");
                                  return box.isEmpty
                                      ? TextButton(
                                          onPressed: () =>
                                              Get.to(() => SaveAddressScreen()),
                                          child: const Text(
                                            "Add Address",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily:
                                                  TextFontFamily.SEN_REGULAR,
                                              color: ColorResources.orange,
                                            ),
                                            textAlign: TextAlign.center,
                                          ))
                                      : DropdownButton(
                                          alignment: Alignment.center,
                                          underline: const SizedBox(),
                                          onTap: () =>
                                              dataController.changePopUp(true),
                                          icon: const SizedBox(),
                                          value: box.values.first[1],
                                          items: personBox.values.map((e) {
                                            log("${e.id},${e.address}");
                                            return DropdownMenuItem(
                                              onTap: () {
                                                box.put(selectedAddressKey,
                                                    [e.id, e.address]);
                                                dataController
                                                    .changePopUp(false);
                                              },
                                              value: e.address,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Obx(() => dataController
                                                          .isPopUp.value
                                                      ? const SizedBox()
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Delivery to ",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    TextFontFamily
                                                                        .SEN_REGULAR,
                                                                color: themeController
                                                                        .isLightTheme
                                                                        .value
                                                                    ? ColorResources
                                                                        .black2
                                                                    : ColorResources
                                                                        .white,
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .keyboard_arrow_down,
                                                              size: 12,
                                                              color: themeController
                                                                      .isLightTheme
                                                                      .value
                                                                  ? ColorResources
                                                                      .black2
                                                                  : ColorResources
                                                                      .white,
                                                            ),
                                                          ],
                                                        )),
                                                  Text(
                                                    e.address,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: TextFontFamily
                                                          .SEN_REGULAR,
                                                      color:
                                                          ColorResources.orange,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {},
                                        );
                                },
                              );
                            },
                          ),
                        )
                      : selectedIndex == 1
                          ? Text(
                              "Favorite",
                              style: TextStyle(
                                fontFamily: TextFontFamily.SEN_BOLD,
                                fontSize: 22,
                                color: themeController.isLightTheme.value
                                    ? ColorResources.black2
                                    : ColorResources.white,
                              ),
                            )
                          : selectedIndex == 2
                              ? Text(
                                  "Search",
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_BOLD,
                                    fontSize: 22,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.black2
                                        : ColorResources.white,
                                  ),
                                )
                              : selectedIndex == 3
                                  ? Text(
                                      "Category Shop",
                                      style: TextStyle(
                                        fontFamily: TextFontFamily.SEN_BOLD,
                                        fontSize: 22,
                                        color:
                                            themeController.isLightTheme.value
                                                ? ColorResources.black2
                                                : ColorResources.white,
                                      ),
                                    )
                                  : selectedIndex == 4
                                      ? Text(
                                          "Cart",
                                          style: TextStyle(
                                            fontFamily: TextFontFamily.SEN_BOLD,
                                            fontSize: 22,
                                            color: themeController
                                                    .isLightTheme.value
                                                ? ColorResources.black2
                                                : ColorResources.white,
                                          ),
                                        )
                                      : Container(),
                  actions: [
                    selectedIndex == 0
                        ? Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: SizedBox(
                              width: 45,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  alignment: Alignment.center,
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  elevation:
                                      MaterialStateProperty.resolveWith<double>(
                                    // As you said you dont need elevation. I'm returning 0 in both case
                                    (Set<MaterialState> states) {
                                      if (states
                                          .contains(MaterialState.disabled)) {
                                        return 0;
                                      }
                                      return 0; // Defer to the widget's default.
                                    },
                                  ),
                                ),
                                onPressed: () async {
                                  try {
                                    await launchUrl(
                                        Uri.parse('https://m.me/deluxbeauti'));
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: const FaIcon(
                                  FontAwesomeIcons.facebookMessenger,
                                  color: Colors.blue,
                                  size: 23,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    /* selectedIndex == 0 || selectedIndex == 1 || selectedIndex == 4
                        ? Padding(
                            padding: const EdgeInsets.only(top: 10, right: 8),
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
                                child: InkWell(
                                  onTap: () {
                                    final DBDataController dbDataController =
                                        Get.find();
    
                                    /*  Get.off(NotificationScreen()); */
                                  },
                                  child: SvgPicture.asset(
                                    Images.notification,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.white3
                                        : ColorResources.white.withOpacity(0.6),
                                  ),
                                ),
                              ),
                            ),
                          )
                        :  */ /* selectedIndex == 2
                            ? Container()
                            : selectedIndex == 3
                                ? Padding(
                                    padding: const EdgeInsets.only(right: 25),
                                    child: InkWell(
                                      onTap: () {
                                        Get.off(SubSearchScreen());
                                      },
                                      child: SvgPicture.asset(
                                        Images.search,
                                        color: themeController.isLightTheme.value
                                            ? ColorResources.white3
                                            : ColorResources.white
                                                .withOpacity(0.6),
                                      ),
                                    ),
                                  )
                                : Container(), */
                    if (selectedIndex == 2) ...[
                      //Barcode image
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          right: 20,
                          bottom: 8,
                        ),
                        child: InkWell(
                          onTap: () => searchController.scanBarCode(),
                          child: Image.asset(
                            Images.barCode,
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
                body: WillPopScope(
                  onWillPop: () async {
                    return !await Navigator.maybePop(
                        navigatorKeys[selectedIndex]!.currentState!.context);
                  },
                  child: IndexedStack(
                    index: selectedIndex,
                    children: <Widget>[
                      NavigatorPage(
                          child: HomeScreen(), navigatorKey: navigatorKeys[0]),
                      NavigatorPage(
                        child: FavoriteScreen(),
                        navigatorKey: navigatorKeys[1],
                      ),
                      NavigatorPage(
                        child: SearchScreen(),
                        navigatorKey: navigatorKeys[2],
                      ),
                      NavigatorPage(
                        child: CategoryBrandScreen(),
                        navigatorKey: navigatorKeys[3],
                        // title: "Menu",
                      ),
                      NavigatorPage(
                        child: CartScreen(),
                        navigatorKey: navigatorKeys[4],
                        // title: "Menu",
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  child: BottomNavigationBar(
                    selectedLabelStyle: const TextStyle(
                      color: ColorResources.blue,
                    ),
                    items: [
                      BottomNavigationBarItem(
                        icon: selectedIndex == 0
                            ? SvgPicture.asset(
                                Images.homefill,
                              )
                            : SvgPicture.asset(Images.homeblank),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: selectedIndex == 1
                            ? SvgPicture.asset(
                                Images.fillfavoriteicon,
                                height: 22,
                                width: 22,
                              )
                            : SvgPicture.asset(
                                Images.blankfavoriteicon,
                                height: 22,
                                width: 22,
                              ),
                        label: "Favourite",
                      ),
                      BottomNavigationBarItem(
                        icon: Container(),
                        label: "Search",
                      ),
                      BottomNavigationBarItem(
                        icon: selectedIndex == 3
                            ? SvgPicture.asset(
                                Images.categorybrandfill,
                              )
                            : SvgPicture.asset(Images.categorybrandblank),
                        label: "Shop",
                      ),
                      BottomNavigationBarItem(
                        icon: selectedIndex == 4
                            ? SvgPicture.asset(
                                Images.cartfill,
                              )
                            : SvgPicture.asset(Images.cartblank),
                        label: "Cart",
                      ),
                    ],
                    backgroundColor: themeController.isLightTheme.value
                        ? ColorResources.white
                        : ColorResources.black6,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: selectedIndex,
                    selectedItemColor: ColorResources.blue,
                    unselectedItemColor: ColorResources.black,
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    elevation: 5,
                  ),
                ),
                floatingActionButton: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 3,
                  ),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorResources.blue1,
                      boxShadow: [
                        BoxShadow(
                          color: themeController.isLightTheme.value
                              ? ColorResources.blue1.withOpacity(0.25)
                              : ColorResources.black1.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 15,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: FloatingActionButton(
                      onPressed: () {
                        selectedIndex = 2;
                        Navigator.of(context, rootNavigator: true)
                            .pushReplacement(MaterialPageRoute(
                          builder: (context) => NavigationBarBottom(),
                        ));
                      },
                      child: SvgPicture.asset(Images.search),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: ColorResources.blue1,
                    ),
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
