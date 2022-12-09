import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:citymall/admin/orders/controller/order_main_controller.dart';
import 'package:citymall/admin/orders/order_print_view/order_print_view.dart';
import 'package:citymall/colors/colors.dart';
import 'package:citymall/controller/theme_controller.dart';
import 'package:citymall/images/images.dart';
import 'package:citymall/model/purchase.dart';
import 'package:citymall/textstylefontfamily/textfontfamily.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../rout_screens/rout_1.dart';
import '../../widgets/other/photo_viewer.dart';

// ignore: must_be_immutable
class OrderDetailView extends StatelessWidget {
  final Purchase purchase;
  final int amt;
  final bool isProcessing;
  final bool isPrepay;
  final bool isDelivered;
  OrderDetailView({
    Key? key,
    required this.purchase,
    required this.amt,
    required this.isProcessing,
    required this.isPrepay,
    required this.isDelivered,
  }) : super(key: key);
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    final OrderMainController orderMainController = Get.find();
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
              //Get.off(MyOrderScreen());
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
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
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
          "Order Detail",
          style: TextStyle(
            fontFamily: TextFontFamily.SEN_BOLD,
            fontSize: 22,
            color: themeController.isLightTheme.value
                ? ColorResources.black2
                : ColorResources.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          height: Get.height,
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
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat.yMMMMd().format(purchase.dateTime),
                    style: TextStyle(
                      fontFamily: TextFontFamily.SEN_REGULAR,
                      fontSize: 17,
                      color: themeController.isLightTheme.value
                          ? ColorResources.grey4
                          : ColorResources.white.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order Id: ${purchase.id.substring(0, 5)}",
                        style: TextStyle(
                          fontFamily: TextFontFamily.SEN_REGULAR,
                          fontSize: 17,
                          color: themeController.isLightTheme.value
                              ? ColorResources.grey4
                              : ColorResources.white.withOpacity(0.6),
                        ),
                      ),
                      Text(
                        "Amt: $amt MMK",
                        style: TextStyle(
                          fontFamily: TextFontFamily.SEN_BOLD,
                          fontSize: 15,
                          color: themeController.isLightTheme.value
                              ? ColorResources.black2
                              : ColorResources.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(thickness: 0.5, color: ColorResources.grey4),
                  const SizedBox(height: 20),
                  isProcessing && !isDelivered
                      ? const SizedBox()
                      : Text(
                          "ETA: ${purchase.eta}",
                          style: TextStyle(
                            fontFamily: TextFontFamily.SEN_BOLD,
                            fontSize: 19,
                            color: themeController.isLightTheme.value
                                ? ColorResources.black2
                                : ColorResources.white,
                          ),
                        ),
                  isProcessing ? const SizedBox() : const SizedBox(height: 18),
                  Text(
                    "Items Detail: ",
                    style: TextStyle(
                      fontFamily: TextFontFamily.SEN_BOLD,
                      fontSize: 19,
                      color: themeController.isLightTheme.value
                          ? ColorResources.black2
                          : ColorResources.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  !(purchase.items == null)
                      ? Container(
                          color: themeController.isLightTheme.value
                              ? ColorResources.white1
                              : ColorResources.black1,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: purchase.items!.length,
                            itemBuilder: (context, index) {
                              final item = purchase.items![index];
                              return ListTile(
                                leading: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: ColorResources.blue1,
                                  child: Text(
                                    "${index + 1}",
                                    style: const TextStyle(
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      fontSize: 14,
                                      color: ColorResources.white,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  item.name,
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_REGULAR,
                                    fontSize: 16,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.black2
                                        : ColorResources.white,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    item.color == null
                                        ? const SizedBox()
                                        : Text(
                                            "Color: ",
                                            style: TextStyle(
                                              fontFamily:
                                                  TextFontFamily.SEN_REGULAR,
                                              fontSize: 16,
                                              color: themeController
                                                      .isLightTheme.value
                                                  ? ColorResources.black2
                                                  : ColorResources.white,
                                            ),
                                          ),
                                    item.color == null
                                        ? const SizedBox()
                                        : Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: themeController
                                                      .isLightTheme.value
                                                  ? ColorResources.white9
                                                  : ColorResources.black1,
                                            ),
                                            child: Center(
                                              child: CircleAvatar(
                                                radius: 9,
                                                backgroundColor:
                                                    HexColor(item.color!),
                                              ),
                                            ),
                                          ),
                                    //Size
                                    item.size == null
                                        ? const SizedBox()
                                        : Text(
                                            "Size: ${item.size}",
                                            style: TextStyle(
                                              fontFamily:
                                                  TextFontFamily.SEN_REGULAR,
                                              fontSize: 16,
                                              color: themeController
                                                      .isLightTheme.value
                                                  ? ColorResources.black2
                                                  : ColorResources.white,
                                            ),
                                          ),
                                  ],
                                ),
                                trailing: Text(
                                  "${item.lastPrice * item.count}MMK",
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_REGULAR,
                                    fontSize: 16,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.black2
                                        : ColorResources.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 10),
                  //Reward Product.............//
                  Text(
                    "Reward Items Detail: ",
                    style: TextStyle(
                      fontFamily: TextFontFamily.SEN_BOLD,
                      fontSize: 19,
                      color: themeController.isLightTheme.value
                          ? ColorResources.black2
                          : ColorResources.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  !(purchase.rewardProducts == null)
                      ? Container(
                          color: themeController.isLightTheme.value
                              ? ColorResources.white1
                              : ColorResources.black1,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: purchase.rewardProducts!.length,
                            itemBuilder: (context, index) {
                              final item = purchase.rewardProducts![index];
                              return ListTile(
                                leading: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: ColorResources.blue1,
                                  child: Text(
                                    "${index + 1}",
                                    style: const TextStyle(
                                      fontFamily: TextFontFamily.SEN_REGULAR,
                                      fontSize: 14,
                                      color: ColorResources.white,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  item.name,
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_REGULAR,
                                    fontSize: 16,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.black2
                                        : ColorResources.white,
                                  ),
                                ),
                                trailing: Text(
                                  "${item.requiredPoint * item.count} points",
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_REGULAR,
                                    fontSize: 16,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.black2
                                        : ColorResources.white,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 10),
                  Text(
                    "Delivery Fee:  ${purchase.townShipNameAndFee["fee"]}MMK",
                    style: TextStyle(
                      fontFamily: TextFontFamily.SEN_BOLD,
                      fontSize: 18,
                      color: themeController.isLightTheme.value
                          ? ColorResources.black3
                          : ColorResources.white,
                    ),
                  ),
                  SizedBox(height: Get.height >= 805 ? 50 : 20),
                  Container(
                    height: 115,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: themeController.isLightTheme.value
                          ? ColorResources.white
                          : ColorResources.black13,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: ColorResources.blue1.withOpacity(0.05),
                          spreadRadius: 0,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            themeController.isLightTheme.value
                                ? Images.trackhomeimage
                                : Images.darktrackhomeimage,
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Delivery Address",
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_BOLD,
                                    fontSize: 18,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.black3
                                        : ColorResources.white,
                                  ),
                                ),
                                Text(
                                  "Home, Work & Other Address",
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_REGULAR,
                                    fontSize: 16,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.grey15.withOpacity(0.6)
                                        : ColorResources.white.withOpacity(0.6),
                                  ),
                                ),
                                Text(
                                  purchase.personalAddress.address,
                                  maxLines: 4,
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_REGULAR,
                                    fontSize: 14,
                                    color: themeController.isLightTheme.value
                                        ? ColorResources.grey15.withOpacity(0.6)
                                        : ColorResources.white.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //If Prepay,need to show ScreenShot
                  //PhotoView
                  isPrepay
                      ? Text(
                          "Screenshot: ",
                          style: TextStyle(
                            fontFamily: TextFontFamily.SEN_BOLD,
                            fontSize: 18,
                            color: themeController.isLightTheme.value
                                ? ColorResources.black3
                                : ColorResources.white,
                          ),
                        )
                      : const SizedBox(),
                  isPrepay
                      ? InkWell(
                          onTap: () {
                            //Show Dialog PhotoView
                            showDialog(
                              //barrierColor: Colors.white.withOpacity(0),
                              context: Get.context!,
                              builder: (context) {
                                return photoViewer(
                                  heroTags: purchase.screenShotImage,
                                );
                              },
                            );
                          },
                          child: Hero(
                            tag: purchase.screenShotImage,
                            child: CachedNetworkImage(
                              width: 200,
                              height: 200,
                              httpHeaders: const {
                                "maxAgeSeconds": "3600",
                                "method": "GET, HEAD",
                                "Access-Control-Allow-Origin": "*",
                                "Access-Control-Allow-Methods": "POST,HEAD",
                                "responseHeader": "Content-Type",
                              },
                              imageUrl: purchase.screenShotImage,
                              fit: BoxFit.contain,
                              progressIndicatorBuilder: (context, url, status) {
                                return Center(
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator(
                                      value: status.progress,
                                    ),
                                  ),
                                );
                              },
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  //Functions For Adim To do IF this order is processing status
                  isProcessing
                      ? SizedBox(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: ColorResources.white1,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      side: BorderSide(
                                        color: ColorResources.green1,
                                      ),
                                    )),
                                onPressed: () {
                                  showAcceptModelButtonSheet(
                                    context,
                                    orderId: purchase.id,
                                    userId: purchase.userId,
                                  );
                                },
                                child: const Text(
                                  "Deliver order",
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_BOLD,
                                    fontSize: 18,
                                    color: ColorResources.black,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: ColorResources.white1,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      side: BorderSide(
                                        color: ColorResources.red1,
                                      ),
                                    )),
                                onPressed: () {
                                  log("Making cancel...");
                                  orderMainController.cancelOrder(
                                      purchase.id, purchase.userId);
                                },
                                child: const Text(
                                  "Cancel order",
                                  style: TextStyle(
                                    fontFamily: TextFontFamily.SEN_BOLD,
                                    fontSize: 18,
                                    color: ColorResources.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  isDelivered
                      ? Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: ColorResources.white1,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  side: BorderSide(
                                    color: ColorResources.blue1,
                                  ),
                                )),
                            onPressed: () => Get.to(() => UserOrderPrintView(
                                  purchaseModel: purchase,
                                  total: amt,
                                  shipping: purchase.townShipNameAndFee["fee"],
                                  township:
                                      purchase.townShipNameAndFee["townName"],
                                )),
                            child: const Text(
                              "Print Preview",
                              style: TextStyle(
                                fontFamily: TextFontFamily.SEN_BOLD,
                                fontSize: 18,
                                color: ColorResources.black,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showAcceptModelButtonSheet(
    BuildContext context, {
    required String orderId,
    required String userId,
  }) {
    Get.bottomSheet(
      BottomSheetFormField(
        orderId: orderId,
        userId: userId,
      ),
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
    );
  }
}

class BottomSheetFormField extends StatefulWidget {
  const BottomSheetFormField({
    Key? key,
    required this.orderId,
    required this.userId,
  }) : super(key: key);

  final String orderId;
  final String userId;

  @override
  State<BottomSheetFormField> createState() => _BottomSheetFormFieldState();
}

class _BottomSheetFormFieldState extends State<BottomSheetFormField> {
  late TextEditingController textController;

  @override
  void initState() {
    textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final OrderMainController orderMainController = Get.find();
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )),
      child: Form(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                //DeliveryTime,
                const Text(
                  "Estimated Time of Arrival",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                //TextformField
                TextFormField(
                  controller: textController,
                  onFieldSubmitted: (value) async {},
                  style: TextStyle(
                      fontFamily: TextFontFamily.SEN_REGULAR,
                      fontSize: 15,
                      color: themeController.isLightTheme.value
                          ? ColorResources.black2
                          : ColorResources.white),
                  cursorColor: ColorResources.grey,
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      FontAwesomeIcons.clock,
                      color: themeController.isLightTheme.value
                          ? ColorResources.navyblue
                          : ColorResources.white,
                    ),
                    filled: true,
                    fillColor: themeController.isLightTheme.value
                        ? ColorResources.white
                        : ColorResources.black4,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    hintText: "15 Min",
                    hintStyle: const TextStyle(
                        fontFamily: TextFontFamily.SEN_REGULAR,
                        fontSize: 16,
                        color: ColorResources.grey5),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: themeController.isLightTheme.value
                            ? ColorResources.white8
                            : ColorResources.black5,
                        width: 1,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: themeController.isLightTheme.value
                            ? ColorResources.white8
                            : ColorResources.black5,
                        width: 1,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: themeController.isLightTheme.value
                            ? ColorResources.white8
                            : ColorResources.black5,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: themeController.isLightTheme.value
                            ? ColorResources.white8
                            : ColorResources.black5,
                        width: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                //Accept button
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: ColorResources.blue1,
                    ),
                    onPressed: () {
                      if (textController.text.isNotEmpty) {
                        log("*****Delivering Order...");
                        orderMainController.deliverOrder(
                            widget.orderId, widget.userId, textController.text);
                        Get.back();
                      } else {
                        log("**ETA text is empty..");
                      }
                    },
                    child: const Text("Save"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
