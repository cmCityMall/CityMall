import 'dart:developer';

import 'package:citymall/model/cart_product.dart';
import 'package:citymall/model/hive_personal_address.dart';
import 'package:citymall/model/personal_address.dart';
import 'package:citymall/model/purchase.dart';
import 'package:citymall/show_loading/show_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../productdetailsscreen/paymentscreen.dart';
import '../rout_screens/rout_1.dart';
import '../server/database.dart';
import 'auth_controller.dart';

class CartController extends GetxController {
  final Database _database = Database();
  final AuthController authController = Get.find();
  RxMap<String, CartProduct> cartMap = <String, CartProduct>{}.obs;
  Rxn<HivePersonalAddress> selectedHivePersonalAddress =
      Rxn<HivePersonalAddress>();
  var subTotal = 0.obs;
  String? townshipName; //Township Name
  Map<String, dynamic> townShipNameAndFee = {}; //Township Name and Fee
  int mouseIndex = -1; //Mouse Region
  var paidScreenShotImage = "".obs;
  var selectedPaymentIndex = 0
      .obs; //if index == 0 => "CashOnDelivery" : index == 1 => "Bank(or)Wave Screenshoot"

  //Get Bank Slip
  getPaidScreenShot() async {
    try {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      paidScreenShotImage.value = image?.path ?? "";
    } catch (e) {
      log("Error Bank Slip Image Picking");
    }
  }

  void setSelectedPaymentIndex(int index) => selectedPaymentIndex.value = index;

  void setSelectedHivePersonalAddress(HivePersonalAddress hp) =>
      selectedHivePersonalAddress.value = hp;

  void changeMouseIndex(int i) {
    // Change Mouse Region
    mouseIndex = i;
    update();
  }

  //Set Shipping Fee
  void setTownshipName(String? val) {
    townshipName = val!;
    update();
  }

  //Set Township Name
  void setTownShipNameAndShip({required String name, required String fee}) {
    townShipNameAndFee = {
      "townName": name,
      "fee": int.parse(fee),
    };
    update();
  }

  void addIntoCart(CartProduct cartProduct) {
    if (cartMap.containsKey(cartProduct.id)) {
      //If Already contain,increase count
      final lastCartProduct = cartMap[cartProduct.id];
      cartMap[cartProduct.id] = lastCartProduct!.copyWith(
        count: lastCartProduct.count + 1,
      );
    } else {
      //Else add count to 1
      cartMap.putIfAbsent(cartProduct.id, () => cartProduct.copyWith(count: 1));
    }
  }

  void removeFromCart(String id) {
    final count = cartMap[id]!.count;
    if (count == 1) {
      //if count is 1 and user press -,so need to remove
      cartMap.remove(id);
    } else {
      //Else only need to reduce
      cartMap[id] = cartMap[id]!.copyWith(count: count - 1);
    }
  }

  @override
  void onInit() {
    ever(cartMap, updatePrice);
    super.onInit();
  }

  updatePrice(Map<String, CartProduct> cart) {
    log("*****Cart Change and Update Price...");
    subTotal.value = 0;
    for (var element in cart.entries) {
      subTotal.value =
          subTotal.value + (element.value.lastPrice * element.value.count);
    }
  }

  Future<void> uploadPurchase() async {
    showLoading();
    try {
      await _database.writePurchase(
        Purchase(
          id: Uuid().v1(),
          eta: "",
          items: cartMap.entries.map((e) => e.value).toList(),
          personalAddress: PersonalAddress(
            fullName: selectedHivePersonalAddress.value!.fullName,
            phoneNumber: selectedHivePersonalAddress.value!.phoneNumber,
            address: selectedHivePersonalAddress.value!.address,
            zipCode: selectedHivePersonalAddress.value!.zipCode,
            country: selectedHivePersonalAddress.value!.country,
            city: selectedHivePersonalAddress.value!.city,
            district: selectedHivePersonalAddress.value!.district,
            addressType: selectedHivePersonalAddress.value!.addressType,
          ),
          screenShotImage: paidScreenShotImage.value,
          townShipNameAndFee: townShipNameAndFee,
          userId: authController.currentUser.value!.id,
          status: 0, //For processing
          dateTime: DateTime.now(),
        ),
      );
      hideLoading();
      Get.defaultDialog(
        title: "",
        titlePadding: EdgeInsets.zero,
        content: const PaymentSuccessDialogWidget(),
      );
      clearAll();
      await Future.delayed(const Duration(seconds: 2));
      //After delaying,mean after show success,Get back to until home
      selectedIndex = 0;
      Navigator.of(Get.context!, rootNavigator: true)
          .pushReplacement(MaterialPageRoute(
        builder: (context) => NavigationBarBottom(),
      ));
    } catch (e) {
      log("*****Error Uploading Purchase: $e");
    }
  }

  void clearAll() {
    cartMap.clear();
    paidScreenShotImage.value = "";
    selectedPaymentIndex.value = 0;
    townShipNameAndFee = {};
  }
}
