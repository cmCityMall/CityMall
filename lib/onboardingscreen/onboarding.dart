import 'package:citymall/authscreens/loginscreen.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final ThemeController themeController = Get.put(ThemeController());
  PageController pageController = PageController(initialPage: 0);
  int index = 0;
  List pageviewlist = [
    {
      "text1": "E-Commerce\nApplication",
      "text2": "E Commerce application template Buy"
          "this code template in codecanyon."
    },
    {
      "text1": "Choose Item",
      "text2": "Choose Items wherever you are with this"
          "application to make life easier."
    },
    {
      "text1": "Buy Item",
      "text2": "Shop from thousand brands in the world"
          "in one application at throwaway"
          "prices."
    }
  ];

  List pageviewlistlight = [
    {
      "image": Images.onboardlight1,
    },
    {
      "image": Images.onboardlight2,
    },
    {
      "image": Images.onboardlight3,
    }
  ];

  List pageviewlistdark = [
    {
      "image": Images.onboarddark1,
    },
    {
      "image": Images.onboarddark2,
    },
    {
      "image": Images.onboarddark3,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeController.isLightTheme.value
          ? ColorResources.white1
          : ColorResources.black1,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset(
              themeController.isLightTheme.value
                  ? Images.onboardbacklight
                  : Images.onboardbackdark,
            ),
          ),
          PageView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: pageviewlist.length,
            controller: pageController,
            scrollDirection: Axis.horizontal,
            onPageChanged: (i) {
              setState(
                () {
                  index = i;
                },
              );
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: Get.height / 6),
                    // SizedBox(height: 130),
                    Center(
                      child: SvgPicture.asset(themeController.isLightTheme.value
                          ? pageviewlistlight[index]["image"]
                          : pageviewlistdark[index]["image"]),
                    ),
                    // SizedBox(height: 50),
                    SizedBox(height: Get.height / 40),
                    Text(
                      pageviewlist[index]["text1"],
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: TextFontFamily.SEN_BOLD,
                        color: themeController.isLightTheme.value
                            ? ColorResources.black2
                            : ColorResources.white,
                      ),
                    ),
                    // SizedBox(height: 18),
                    SizedBox(height: Get.height / 40),
                    Text(
                      pageviewlist[index]["text2"],
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: TextFontFamily.SEN_REGULAR,
                        color: themeController.isLightTheme.value
                            ? ColorResources.grey
                            : ColorResources.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Positioned(
            bottom: 20,
            left: 40,
            child: Row(
              children: List.generate(
                pageviewlist.length,
                (position) => Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Container(
                    width: position == index ? 14 : 5,
                    height: 5,
                    decoration: BoxDecoration(
                      //shape: BoxShape.circle,
                      borderRadius:
                          BorderRadius.circular(index == position ? 7 : 2.5),
                      color: index == position
                          ? ColorResources.blue1
                          : ColorResources.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () {
                index == 2
                    ? Get.off(LoginScreen())
                    : pageController.nextPage(
                        duration: 300.milliseconds, curve: Curves.ease);
              },
              child: Container(
                height: 60,
                width: 170,
                decoration: BoxDecoration(
                  color: ColorResources.blue1,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
                ),
                child: Center(
                  child: index == 2
                      ? Text(
                          "Get Started",
                          style: TextStyle(
                              fontFamily: TextFontFamily.SEN_BOLD,
                              fontSize: 18,
                              color: ColorResources.white1),
                        )
                      : Text(
                          "Next",
                          style: TextStyle(
                              fontFamily: TextFontFamily.SEN_BOLD,
                              fontSize: 18,
                              color: ColorResources.white1),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
